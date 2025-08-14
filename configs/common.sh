#!/usr/bin/env bash
# shellcheck disable=SC2034

function setup_common_urls() {
    # 1) 依赖库（MPFR / GMP / MPC）
MPFR_BASE_URL="https://ftpmirror.gnu.org/gnu/mpfr/"
GMP_BASE_URL="https://ftpmirror.gnu.org/gnu/gmp/"
MPC_BASE_URL="https://ftpmirror.gnu.org/gnu/mpc/"



    ISL_BASE_URL="https://libisl.sourceforge.io/"
}

function setup_common_urls_tar() {

    setup_common_urls

    # 2) 主源码包（GCC / Binutils / GDB / GLIBC）
BINUTILS_BASE_URL="https://ftpmirror.gnu.org/gnu/binutils/binutils-"
GCC_BASE_URL="https://ftpmirror.gnu.org/gnu/gcc/"
GLIBC_BASE_URL="https://ftpmirror.gnu.org/gnu/glibc/"
GDB_BASE_URL="https://ftpmirror.gnu.org/gnu/gdb/"
    LINUX_BASE_URL="https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-"
    NEWLIB_BASE_URL="ftp://sourceware.org/pub/newlib/"
    AVRLIBC_BASE_URL="https://github.com/avrdudes/avr-libc/archive/refs/tags/"
    
    PICOLIBC_BASE_URL="https://github.com/keith-packard/picolibc/archive/"
    MINGW_BASE_URL="https://github.com/mingw-w64/mingw-w64/archive/refs/tags/"
    UCLIBC_NG_BASE_URL="https://downloads.uclibc-ng.org/releases/"
    ELF2FLT_BASE_URL="https://github.com/uclinux-dev/elf2flt/archive/refs/tags/"
}

function setup_common_urls_git() {

    setup_common_urls

    BINUTILS_GIT_URL="git://sourceware.org/git/binutils-gdb.git"
    GCC_GIT_URL="git://gcc.gnu.org/git/gcc.git"
    GLIBC_GIT_URL="git://sourceware.org/git/glibc.git"
    LINUX_GIT_URL="git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"
    NEWLIB_GIT_URL="git://sourceware.org/git/newlib-cygwin.git"
    AVRLIBC_GIT_URL="https://github.com/avrdudes/avr-libc.git"
    GDB_GIT_URL="git://sourceware.org/git/binutils-gdb.git"
    PICOLIBC_GIT_URL="https://github.com/keith-packard/picolibc.git"
    MINGW_GIT_URL="https://github.com/mingw-w64/mingw-w64.git"
    # Use kraj's mirror to be able to use shallow clones:
    UCLIBC_NG_GIT_URL="https://github.com/kraj/uclibc-ng.git"
    #UCLIBC_NG_GIT_URL="https://cgit.uclibc-ng.org/cgi/cgit/uclibc-ng.git/"
    ELF2FLT_GIT_URL="https://github.com/uclinux-dev/elf2flt.git"
}
