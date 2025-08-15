#!/usr/bin/env bash
# shellcheck disable=SC2034

function build_glibc_header() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}" || die "ERROR: cd to ${ROOT}"
    # use clean hashtable
    hash -r

    header "MAKING GLIBC HEADERS"
    mkdir -p "${BUILD_DIR}/build-glibc"
    cd "${BUILD_DIR}/build-glibc" || die "glibc build folder does not exist!"
    call_cmd "${SOURCES_DIR}/glibc-${GLIBC}/configure" "${GLIBC_CONFIGURATION[@]}"

    call_cmd make install-bootstrap-headers=yes install-headers || die "Error while building glibc headers!" -n
    call_cmd make "${JOBS}" csu/subdir_lib || die "Error while building glibc headers 2!" -n
    call_cmd install csu/crt1.o csu/crti.o csu/crtn.o "${INSTALL}/${TARGET}/lib" || die "Error while installing crt" -n
    call_cmd "${TARGET}-gcc" -nostdlib -nostartfiles -shared -x c /dev/null -o "${INSTALL}/${TARGET}/lib/libc.so" || die "Error while building libc" -n
    touch "${INSTALL}/${TARGET}/include/gnu/stubs.h"

    set_build_state "${FUNCNAME[0]}"
}

function build_glibc() {

    check_build_state "${FUNCNAME[0]}" && return
    cd "${ROOT}" || die "ERROR: cd to ${ROOT}"
    # use clean hashtable
    hash -r

    header "MAKING GLIBC"
    cd "${BUILD_DIR}/build-glibc" || die "glibc build folder does not exist!"
    call_cmd make "${JOBS}" || die "Error while building glibc"
    call_cmd make install || die "Error while installing glibc"

    set_build_state "${FUNCNAME[0]}"
    # 在之前的 Dockerfile 基础上添加以下内容

# 新增构建参数
ARG GLIBC_VERSION=2.35
ARG INSTALL=/opt/${TARGET}-toolchain/${TARGET}

# 复制 glibc 源代码
COPY glibc-${GLIBC_VERSION}.tar.xz ${SOURCES_DIR}/

# 解压 glibc 源代码
RUN cd ${SOURCES_DIR} && \
    tar -xf glibc-${GLIBC_VERSION}.tar.xz

# 设置 glibc 配置
ENV GLIBC_CONFIGURATION=(
    "--prefix=${PREFIX}/${TARGET}"
    "--host=${TARGET}"
    "--build=$(gcc -dumpmachine)"
    "--with-headers=${PREFIX}/${TARGET}/include"
    "--enable-add-ons"
    "--enable-obsolete-rpc"
    "--enable-kernel=4.14"
    "--disable-werror"
    "--with-__thread"
    "--with-tls"
    "--with-fp"
    "--with-arch=armv8-a"
    "--with-tune=cortex-a72"
)

# 在安装完 GCC 工具链后添加 glibc 构建步骤
RUN /bin/bash -c "source /home/script_dir/gcc-build-tools/build-gcc && \
    mkdir -p ${INSTALL}/lib && \
    mkdir -p ${INSTALL}/include && \
    build_glibc_header"

RUN /bin/bash -c "source /home/script_dir/gcc-build-tools/build-gcc && \
    build_glibc"

# 验证 glibc 安装
RUN test -f ${INSTALL}/lib/libc.so.6 || { echo "GLIBC installation verification failed"; exit 1; }
}
