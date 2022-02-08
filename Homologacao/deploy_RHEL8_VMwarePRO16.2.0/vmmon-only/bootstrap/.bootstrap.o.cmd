cmd_/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/bootstrap/bootstrap.o := gcc -Wp,-MD,/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/bootstrap/.bootstrap.o.d  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/8/include -I./arch/x86/include -I./arch/x86/include/generated   -I./include/drm-backport -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL__ -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -Werror-implicit-function-declaration -Wno-format-security -std=gnu89 -fno-PIE -DCC_HAVE_ASM_GOTO -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -falign-jumps=1 -falign-loops=1 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -funit-at-a-time -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -DCONFIG_AS_CFI_SECTIONS=1 -DCONFIG_AS_FXSAVEQ=1 -DCONFIG_AS_SSSE3=1 -DCONFIG_AS_CRC32=1 -DCONFIG_AS_AVX=1 -DCONFIG_AS_AVX2=1 -DCONFIG_AS_AVX512=1 -DCONFIG_AS_SHA1_NI=1 -DCONFIG_AS_SHA256_NI=1 -DCONFIG_TPAUSE=1 -pipe -Wno-sign-compare -fno-asynchronous-unwind-tables -mindirect-branch=thunk-extern -mindirect-branch-register -fno-jump-tables -fno-delete-null-pointer-checks -Wno-frame-address -Wno-format-truncation -Wno-format-overflow -Wno-int-in-bool-context -O2 --param=allow-store-data-races=0 -Wframe-larger-than=2048 -fstack-protector-strong -Wno-unused-but-set-variable -Wno-unused-const-variable -g -gdwarf-4 -pg -mrecord-mcount -mfentry -DCC_USING_FENTRY -fno-inline-functions-called-once -Wdeclaration-after-statement -Wno-pointer-sign -Wno-stringop-truncation -fno-strict-overflow -fno-merge-all-constants -fmerge-constants -fno-stack-check -fconserve-stack -Werror=implicit-int -Werror=strict-prototypes -Werror=date-time -Werror=incompatible-pointer-types -Werror=designated-init -fmacro-prefix-map=./= -Wno-packed-not-aligned -Wall -Wstrict-prototypes -DVMW_USING_KBUILD -DVMMON -DVMCORE -I/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include -I/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./common -I/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./linux -I/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./vmcore  -DMODULE  -DKBUILD_BASENAME='"bootstrap"' -DKBUILD_MODNAME='"vmmon"' -c -o /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/bootstrap/.tmp_bootstrap.o /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/bootstrap/bootstrap.c

source_/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/bootstrap/bootstrap.o := /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/bootstrap/bootstrap.c

deps_/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/bootstrap/bootstrap.o := \
  include/linux/kconfig.h \
    $(wildcard include/config/cpu/big/endian.h) \
    $(wildcard include/config/booger.h) \
    $(wildcard include/config/foo.h) \
  include/linux/compiler_types.h \
    $(wildcard include/config/enable/must/check.h) \
    $(wildcard include/config/enable/warn/deprecated.h) \
  include/linux/compiler-gcc.h \
    $(wildcard include/config/arch/supports/optimized/inlining.h) \
    $(wildcard include/config/optimize/inlining.h) \
    $(wildcard include/config/gcov/kernel.h) \
    $(wildcard include/config/arch/use/builtin/bswap.h) \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vm_basic_types.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/includeCheck.h \
  include/linux/types.h \
    $(wildcard include/config/have/uid16.h) \
    $(wildcard include/config/uid16.h) \
    $(wildcard include/config/arch/dma/addr/t/64bit.h) \
    $(wildcard include/config/phys/addr/t/64bit.h) \
    $(wildcard include/config/64bit.h) \
  include/uapi/linux/types.h \
  arch/x86/include/uapi/asm/types.h \
  include/uapi/asm-generic/types.h \
  include/asm-generic/int-ll64.h \
  include/uapi/asm-generic/int-ll64.h \
  arch/x86/include/uapi/asm/bitsperlong.h \
  include/asm-generic/bitsperlong.h \
  include/uapi/asm-generic/bitsperlong.h \
  include/uapi/linux/posix_types.h \
  include/linux/stddef.h \
  include/uapi/linux/stddef.h \
  include/linux/compiler_types.h \
  arch/x86/include/asm/posix_types.h \
    $(wildcard include/config/x86/32.h) \
  arch/x86/include/uapi/asm/posix_types_64.h \
  include/uapi/asm-generic/posix_types.h \
  include/generated/uapi/linux/version.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vm_basic_defs.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vm_basic_types.h \
  /usr/lib/gcc/x86_64-redhat-linux/8/include/stddef.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/bootstrap_vmm.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/monAddrLayout.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vm_pagetable.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vm_basic_defs.h \

/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/bootstrap/bootstrap.o: $(deps_/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/bootstrap/bootstrap.o)

$(deps_/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/bootstrap/bootstrap.o):
