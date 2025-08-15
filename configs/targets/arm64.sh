#!/usr/bin/env bash
# shellcheck disable=SC2034

function config_arm64() {
    TARGET="aarch64-openkitty-linux-gnu" 
    # shellcheck disable=SC2034
    LINUX_ARCH="arm64"

    local VERSION="$1"
    local TAR_OR_GIT="$2"

    setup_default_config

    # Append additional confis here
    BINUTILS_CONFIGURATION=(
        "${BINUTILS_BASE_CONFIG[@]}"
    )

    GCC_CONFIGURATION=(
    "${GCC_BASE_CONFIG[@]}"
    --with-sysroot="${INSTALL}/${TARGET}"
    --with-native-system-header-dir=/include
    --with-dynamic-linker="${INSTALL}/${TARGET}/lib/ld-linux-aarch64.so.1"
)




    
    GLIBC_CONFIGURATION=(
        "${GLIBC_BASE_CONFIG[@]}"
    )

GCC_FINAL_CONFIGURATION=(
    "${GCC_BASE_CONFIG[@]}"
    --includedir="${INSTALL}/${TARGET}/include"
    --with-sysroot="${INSTALL}/${TARGET}"
    --with-native-system-header-dir=/include
    --with-dynamic-linker="${INSTALL}/${TARGET}/lib/ld-linux-aarch64.so.1"
)

    GDB_CONFIGURATION=(
        "${GDB_BASE_CONFIG[@]}"
    )

    type -t "setup_variables_${TAR_OR_GIT}_${VERSION}" > /dev/null || die "No setup_variables_${TAR_OR_GIT}_${VERSION} found!"
    "setup_variables_${TAR_OR_GIT}_${VERSION}"

    setup_linux_default_downloadfuncs
    setup_linux_default_buildfuncs
}
