cmd_/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/bootstrap/vmmblob.o := gcc -Wp,-MD,/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/bootstrap/.vmmblob.o.d  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/8/include -I./arch/x86/include -I./arch/x86/include/generated   -I./include/drm-backport -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL__ -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -Werror-implicit-function-declaration -Wno-format-security -std=gnu89 -fno-PIE -DCC_HAVE_ASM_GOTO -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -falign-jumps=1 -falign-loops=1 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -funit-at-a-time -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -DCONFIG_AS_CFI_SECTIONS=1 -DCONFIG_AS_FXSAVEQ=1 -DCONFIG_AS_SSSE3=1 -DCONFIG_AS_CRC32=1 -DCONFIG_AS_AVX=1 -DCONFIG_AS_AVX2=1 -DCONFIG_AS_AVX512=1 -DCONFIG_AS_SHA1_NI=1 -DCONFIG_AS_SHA256_NI=1 -DCONFIG_TPAUSE=1 -pipe -Wno-sign-compare -fno-asynchronous-unwind-tables -mindirect-branch=thunk-extern -mindirect-branch-register -fno-jump-tables -fno-delete-null-pointer-checks -Wno-frame-address -Wno-format-truncation -Wno-format-overflow -Wno-int-in-bool-context -O2 --param=allow-store-data-races=0 -Wframe-larger-than=2048 -fstack-protector-strong -Wno-unused-but-set-variable -Wno-unused-const-variable -g -gdwarf-4 -pg -mrecord-mcount -mfentry -DCC_USING_FENTRY -fno-inline-functions-called-once -Wdeclaration-after-statement -Wno-pointer-sign -Wno-stringop-truncation -fno-strict-overflow -fno-merge-all-constants -fmerge-constants -fno-stack-check -fconserve-stack -Werror=implicit-int -Werror=strict-prototypes -Werror=date-time -Werror=incompatible-pointer-types -Werror=designated-init -fmacro-prefix-map=./= -Wno-packed-not-aligned -Wall -Wstrict-prototypes -DVMW_USING_KBUILD -DVMMON -DVMCORE -I/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include -I/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./common -I/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./linux -I/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./vmcore  -DMODULE  -DKBUILD_BASENAME='"vmmblob"' -DKBUILD_MODNAME='"vmmon"' -c -o /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/bootstrap/.tmp_vmmblob.o /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/bootstrap/vmmblob.c

source_/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/bootstrap/vmmblob.o := /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/bootstrap/vmmblob.c

deps_/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/bootstrap/vmmblob.o := \
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
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/driver-config.h \
    $(wildcard include/config/modules.h) \
    $(wildcard include/config/smp.h) \
    $(wildcard include/config/modversions.h) \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/includeCheck.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/compat_version.h \
  include/generated/uapi/linux/version.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/compat_autoconf.h \
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
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vmware.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vm_basic_types.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vm_basic_defs.h \
  /usr/lib/gcc/x86_64-redhat-linux/8/include/stddef.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vm_assert.h \
  include/linux/kernel.h \
    $(wildcard include/config/preempt/voluntary.h) \
    $(wildcard include/config/debug/atomic/sleep.h) \
    $(wildcard include/config/preempt/rt.h) \
    $(wildcard include/config/mmu.h) \
    $(wildcard include/config/prove/locking.h) \
    $(wildcard include/config/arch/has/refcount.h) \
    $(wildcard include/config/lock/down/kernel.h) \
    $(wildcard include/config/lock/down/mandatory.h) \
    $(wildcard include/config/panic/timeout.h) \
    $(wildcard include/config/tracing.h) \
    $(wildcard include/config/ftrace/mcount/record.h) \
  /usr/lib/gcc/x86_64-redhat-linux/8/include/stdarg.h \
  include/linux/limits.h \
  include/uapi/linux/limits.h \
  include/vdso/limits.h \
  include/linux/linkage.h \
  include/linux/stringify.h \
  include/linux/export.h \
    $(wildcard include/config/module/rel/crcs.h) \
    $(wildcard include/config/trim/unused/ksyms.h) \
    $(wildcard include/config/unused/symbols.h) \
  arch/x86/include/asm/linkage.h \
    $(wildcard include/config/x86/64.h) \
    $(wildcard include/config/x86/alignment/16.h) \
  include/linux/compiler.h \
    $(wildcard include/config/trace/branch/profiling.h) \
    $(wildcard include/config/profile/all/branches.h) \
    $(wildcard include/config/stack/validation.h) \
    $(wildcard include/config/debug/entry.h) \
    $(wildcard include/config/kasan.h) \
    $(wildcard include/config/kcsan.h) \
  include/linux/kcsan-checks.h \
    $(wildcard include/config/kcsan/ignore/atomics.h) \
  arch/x86/include/asm/barrier.h \
  arch/x86/include/asm/alternative.h \
  arch/x86/include/asm/asm.h \
  arch/x86/include/asm/nops.h \
    $(wildcard include/config/mk7.h) \
    $(wildcard include/config/x86/p6/nop.h) \
  include/asm-generic/barrier.h \
  include/linux/kasan-checks.h \
  include/linux/kcsan.h \
  include/linux/bitops.h \
  include/linux/bits.h \
  include/linux/const.h \
  include/vdso/const.h \
  include/uapi/linux/const.h \
  include/vdso/bits.h \
  arch/x86/include/asm/bitops.h \
    $(wildcard include/config/x86/cmov.h) \
  arch/x86/include/asm/rmwcc.h \
  include/asm-generic/bitops/find.h \
    $(wildcard include/config/generic/find/first/bit.h) \
  include/asm-generic/bitops/sched.h \
  arch/x86/include/asm/arch_hweight.h \
  arch/x86/include/asm/cpufeatures.h \
  arch/x86/include/asm/required-features.h \
    $(wildcard include/config/x86/minimum/cpu/family.h) \
    $(wildcard include/config/math/emulation.h) \
    $(wildcard include/config/x86/pae.h) \
    $(wildcard include/config/x86/cmpxchg64.h) \
    $(wildcard include/config/x86/use/3dnow.h) \
    $(wildcard include/config/matom.h) \
    $(wildcard include/config/paravirt.h) \
  arch/x86/include/asm/disabled-features.h \
    $(wildcard include/config/x86/intel/mpx.h) \
    $(wildcard include/config/x86/intel/umip.h) \
    $(wildcard include/config/x86/intel/memory/protection/keys.h) \
    $(wildcard include/config/x86/5level.h) \
    $(wildcard include/config/page/table/isolation.h) \
    $(wildcard include/config/iommu/support.h) \
    $(wildcard include/config/x86/sgx.h) \
  include/asm-generic/bitops/const_hweight.h \
  include/asm-generic/bitops/le.h \
  arch/x86/include/uapi/asm/byteorder.h \
  include/linux/byteorder/little_endian.h \
  include/uapi/linux/byteorder/little_endian.h \
  include/linux/swab.h \
  include/uapi/linux/swab.h \
  arch/x86/include/uapi/asm/swab.h \
  include/linux/byteorder/generic.h \
  include/asm-generic/bitops/ext2-atomic-setbit.h \
  include/linux/log2.h \
    $(wildcard include/config/arch/has/ilog2/u32.h) \
    $(wildcard include/config/arch/has/ilog2/u64.h) \
  include/linux/typecheck.h \
  include/linux/printk.h \
    $(wildcard include/config/message/loglevel/default.h) \
    $(wildcard include/config/console/loglevel/default.h) \
    $(wildcard include/config/console/loglevel/quiet.h) \
    $(wildcard include/config/early/printk.h) \
    $(wildcard include/config/printk/nmi.h) \
    $(wildcard include/config/printk.h) \
    $(wildcard include/config/dynamic/debug.h) \
  include/linux/init.h \
    $(wildcard include/config/have/arch/prel32/relocations.h) \
    $(wildcard include/config/strict/kernel/rwx.h) \
    $(wildcard include/config/strict/module/rwx.h) \
  include/linux/kern_levels.h \
  include/linux/cache.h \
    $(wildcard include/config/arch/has/cache/line/size.h) \
  include/uapi/linux/kernel.h \
  include/uapi/linux/sysinfo.h \
  arch/x86/include/asm/cache.h \
    $(wildcard include/config/x86/l1/cache/shift.h) \
    $(wildcard include/config/x86/internode/cache/shift.h) \
    $(wildcard include/config/x86/vsmp.h) \
  include/linux/dynamic_debug.h \
    $(wildcard include/config/jump/label.h) \
  include/linux/jump_label.h \
    $(wildcard include/config/have/arch/jump/label/relative.h) \
  arch/x86/include/asm/jump_label.h \
  include/linux/build_bug.h \
  arch/x86/include/asm/div64.h \
  include/asm-generic/div64.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vm_assert.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./common/hostif.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/includeCheck.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./common/vmx86.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86apic.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86msr.h \
  arch/x86/include/asm/msr-index.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/community_source.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vmware_pack_begin.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vmware_pack_init.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vmware_pack_end.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/modulecall.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86types.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/address_defs.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86segdescrs.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vm_pagetable.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86desc.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/ptsc.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/rateconv.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vm_basic_asm.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vm_basic_asm_x86_common.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vm_basic_asm_x86_64.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vm_atomic.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/versioned_atomic.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vcpuid.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vcpuset.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vcpuset_types.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vmm_constants.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/contextinfo.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/modulecallstructs.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/mon_assert.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/uccostTable.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vcpuid.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/iocontrols.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/overheadmem_types.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/pageLock_defs.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/numa_defs.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/cpu_defs.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/bootstrap_vmm.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/monAddrLayout.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/sharedAreaType.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/numa_defs.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/rateconv.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vmmem_shared.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./common/apic.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vm_basic_types.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/bootstrap_vmm.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/sharedAreaVmmon.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/iocontrols.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/statVarsVmmon.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vcpuset.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./common/hostifMem.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./common/hostifGlobalLock.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vmmblob.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/monLoader.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86paging_64.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86paging_common.h \

/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/bootstrap/vmmblob.o: $(deps_/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/bootstrap/vmmblob.o)

$(deps_/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/bootstrap/vmmblob.o):
