cmd_/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/common/task.o := gcc -Wp,-MD,/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/common/.task.o.d  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/8/include -I./arch/x86/include -I./arch/x86/include/generated   -I./include/drm-backport -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL__ -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -Werror-implicit-function-declaration -Wno-format-security -std=gnu89 -fno-PIE -DCC_HAVE_ASM_GOTO -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -falign-jumps=1 -falign-loops=1 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -funit-at-a-time -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -DCONFIG_AS_CFI_SECTIONS=1 -DCONFIG_AS_FXSAVEQ=1 -DCONFIG_AS_SSSE3=1 -DCONFIG_AS_CRC32=1 -DCONFIG_AS_AVX=1 -DCONFIG_AS_AVX2=1 -DCONFIG_AS_AVX512=1 -DCONFIG_AS_SHA1_NI=1 -DCONFIG_AS_SHA256_NI=1 -DCONFIG_TPAUSE=1 -pipe -Wno-sign-compare -fno-asynchronous-unwind-tables -mindirect-branch=thunk-extern -mindirect-branch-register -fno-jump-tables -fno-delete-null-pointer-checks -Wno-frame-address -Wno-format-truncation -Wno-format-overflow -Wno-int-in-bool-context -O2 --param=allow-store-data-races=0 -Wframe-larger-than=2048 -fstack-protector-strong -Wno-unused-but-set-variable -Wno-unused-const-variable -g -gdwarf-4 -pg -mrecord-mcount -mfentry -DCC_USING_FENTRY -fno-inline-functions-called-once -Wdeclaration-after-statement -Wno-pointer-sign -Wno-stringop-truncation -fno-strict-overflow -fno-merge-all-constants -fmerge-constants -fno-stack-check -fconserve-stack -Werror=implicit-int -Werror=strict-prototypes -Werror=date-time -Werror=incompatible-pointer-types -Werror=designated-init -fmacro-prefix-map=./= -Wno-packed-not-aligned -Wall -Wstrict-prototypes -DVMW_USING_KBUILD -DVMMON -DVMCORE -I/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include -I/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./common -I/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./linux -I/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./vmcore  -DMODULE  -DKBUILD_BASENAME='"task"' -DKBUILD_MODNAME='"vmmon"' -c -o /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/common/.tmp_task.o /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/common/task.c

source_/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/common/task.o := /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/common/task.c

deps_/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/common/task.o := \
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
  include/linux/string.h \
    $(wildcard include/config/binary/printf.h) \
    $(wildcard include/config/fortify/source.h) \
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
  include/linux/stringify.h \
  arch/x86/include/asm/asm.h \
  arch/x86/include/asm/nops.h \
    $(wildcard include/config/mk7.h) \
    $(wildcard include/config/x86/p6/nop.h) \
    $(wildcard include/config/x86/64.h) \
  include/asm-generic/barrier.h \
  include/linux/kasan-checks.h \
  include/linux/kcsan.h \
  /usr/lib/gcc/x86_64-redhat-linux/8/include/stdarg.h \
  include/uapi/linux/string.h \
  arch/x86/include/asm/string.h \
  arch/x86/include/asm/string_64.h \
    $(wildcard include/config/x86/mce.h) \
    $(wildcard include/config/arch/has/uaccess/flushcache.h) \
  include/linux/jump_label.h \
    $(wildcard include/config/jump/label.h) \
    $(wildcard include/config/have/arch/jump/label/relative.h) \
  arch/x86/include/asm/jump_label.h \
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
  include/linux/limits.h \
  include/uapi/linux/limits.h \
  include/vdso/limits.h \
  include/linux/linkage.h \
  include/linux/export.h \
    $(wildcard include/config/module/rel/crcs.h) \
    $(wildcard include/config/trim/unused/ksyms.h) \
    $(wildcard include/config/unused/symbols.h) \
  arch/x86/include/asm/linkage.h \
    $(wildcard include/config/x86/alignment/16.h) \
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
  include/linux/build_bug.h \
  arch/x86/include/asm/div64.h \
  include/asm-generic/div64.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/modulecall.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86types.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/address_defs.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86segdescrs.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vmware_pack_begin.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vmware_pack_init.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vmware_pack_end.h \
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
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/common/vmx86.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/includeCheck.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86apic.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86msr.h \
  arch/x86/include/asm/msr-index.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/community_source.h \
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
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/common/apic.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vm_basic_types.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/bootstrap_vmm.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/sharedAreaVmmon.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/iocontrols.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/statVarsVmmon.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/common/task.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vm_asm.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86msr.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vm_asm_x86.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86sel.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86_basic_defs.h \
  arch/x86/include/asm/processor-flags.h \
    $(wildcard include/config/vm86.h) \
  arch/x86/include/uapi/asm/processor-flags.h \
  include/linux/mem_encrypt.h \
    $(wildcard include/config/arch/has/mem/encrypt.h) \
    $(wildcard include/config/amd/mem/encrypt.h) \
  arch/x86/include/asm/mem_encrypt.h \
  arch/x86/include/uapi/asm/bootparam.h \
  include/linux/screen_info.h \
  include/uapi/linux/screen_info.h \
  include/linux/apm_bios.h \
  include/uapi/linux/apm_bios.h \
  include/uapi/linux/ioctl.h \
  arch/x86/include/uapi/asm/ioctl.h \
  include/asm-generic/ioctl.h \
  include/uapi/asm-generic/ioctl.h \
  include/linux/edd.h \
  include/uapi/linux/edd.h \
  arch/x86/include/asm/ist.h \
  arch/x86/include/uapi/asm/ist.h \
  include/video/edid.h \
    $(wildcard include/config/x86.h) \
  include/uapi/video/edid.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/common/cpuid.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86cpuid.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86vendor.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/common/hostif.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vcpuset.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/common/hostifMem.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/common/hostifGlobalLock.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/common/hostKernel.h \
  arch/x86/include/asm/page.h \
  arch/x86/include/asm/page_types.h \
    $(wildcard include/config/physical/start.h) \
    $(wildcard include/config/physical/align.h) \
    $(wildcard include/config/dynamic/physical/mask.h) \
  arch/x86/include/asm/page_64_types.h \
    $(wildcard include/config/dynamic/memory/layout.h) \
    $(wildcard include/config/randomize/base.h) \
  arch/x86/include/asm/kaslr.h \
    $(wildcard include/config/randomize/memory.h) \
  arch/x86/include/asm/page_64.h \
    $(wildcard include/config/debug/virtual.h) \
    $(wildcard include/config/flatmem.h) \
    $(wildcard include/config/x86/vsyscall/emulation.h) \
  include/linux/range.h \
  include/asm-generic/memory_model.h \
    $(wildcard include/config/discontigmem.h) \
    $(wildcard include/config/sparsemem/vmemmap.h) \
    $(wildcard include/config/sparsemem.h) \
  include/linux/pfn.h \
  include/asm-generic/getorder.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/common/comport.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/crossgdt.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86svm.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/vm_asm.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86cpuid_asm.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86cpuid.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86vt.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86vt-vmcs-fields.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86vt-exit-reasons.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86vtinstr.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/perfctr.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/perfctr_arch.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86paging_common.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86paging_64.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86paging_common.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/common/memtrack.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/monLoader.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/x86paging_64.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/segs.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/addrlayout.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/./include/addrlayout_table.h \
  /home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/common/crosspage.h \
  arch/x86/include/asm/desc.h \
  arch/x86/include/asm/desc_defs.h \
  arch/x86/include/uapi/asm/ldt.h \
  arch/x86/include/asm/mmu.h \
    $(wildcard include/config/modify/ldt/syscall.h) \
  include/linux/spinlock.h \
    $(wildcard include/config/debug/spinlock.h) \
    $(wildcard include/config/preemption.h) \
    $(wildcard include/config/debug/lock/alloc.h) \
  include/linux/preempt.h \
    $(wildcard include/config/preempt/count.h) \
    $(wildcard include/config/debug/preempt.h) \
    $(wildcard include/config/trace/preempt/toggle.h) \
    $(wildcard include/config/preempt/notifiers.h) \
  include/linux/list.h \
    $(wildcard include/config/debug/list.h) \
  include/linux/poison.h \
    $(wildcard include/config/illegal/pointer/value.h) \
    $(wildcard include/config/page/poisoning/zero.h) \
  arch/x86/include/asm/preempt.h \
  arch/x86/include/asm/percpu.h \
    $(wildcard include/config/x86/64/smp.h) \
  include/asm-generic/percpu.h \
    $(wildcard include/config/have/setup/per/cpu/area.h) \
  include/linux/threads.h \
    $(wildcard include/config/nr/cpus.h) \
    $(wildcard include/config/base/small.h) \
  include/linux/percpu-defs.h \
    $(wildcard include/config/debug/force/weak/per/cpu.h) \
    $(wildcard include/config/virtualization.h) \
  include/linux/thread_info.h \
    $(wildcard include/config/thread/info/in/task.h) \
    $(wildcard include/config/have/arch/within/stack/frames.h) \
    $(wildcard include/config/hardened/usercopy.h) \
  include/linux/bug.h \
    $(wildcard include/config/generic/bug.h) \
    $(wildcard include/config/bug/on/data/corruption.h) \
  arch/x86/include/asm/bug.h \
    $(wildcard include/config/debug/bugverbose.h) \
  include/asm-generic/bug.h \
    $(wildcard include/config/bug.h) \
    $(wildcard include/config/generic/bug/relative/pointers.h) \
  include/linux/restart_block.h \
  include/linux/time64.h \
    $(wildcard include/config/64bit/time.h) \
  include/linux/math64.h \
    $(wildcard include/config/arch/supports/int128.h) \
  include/vdso/math64.h \
  include/vdso/time64.h \
  include/uapi/linux/time.h \
  include/uapi/linux/time_types.h \
  arch/x86/include/asm/current.h \
  arch/x86/include/asm/thread_info.h \
    $(wildcard include/config/frame/pointer.h) \
    $(wildcard include/config/compat.h) \
    $(wildcard include/config/ia32/emulation.h) \
  arch/x86/include/asm/cpufeature.h \
    $(wildcard include/config/x86/feature/names.h) \
  arch/x86/include/asm/processor.h \
    $(wildcard include/config/x86/vmx/feature/names.h) \
    $(wildcard include/config/stackprotector.h) \
    $(wildcard include/config/x86/debugctlmsr.h) \
    $(wildcard include/config/cpu/sup/amd.h) \
    $(wildcard include/config/xen.h) \
  arch/x86/include/asm/math_emu.h \
  arch/x86/include/asm/ptrace.h \
  arch/x86/include/asm/segment.h \
    $(wildcard include/config/xen/pv.h) \
    $(wildcard include/config/x86/32/lazy/gs.h) \
  arch/x86/include/uapi/asm/ptrace.h \
  arch/x86/include/uapi/asm/ptrace-abi.h \
  arch/x86/include/asm/paravirt_types.h \
    $(wildcard include/config/pgtable/levels.h) \
    $(wildcard include/config/paravirt/debug.h) \
  include/linux/rh_kabi.h \
    $(wildcard include/config/rh/kabi/size/align/checks.h) \
  include/linux/kconfig.h \
  arch/x86/include/asm/kmap_types.h \
    $(wildcard include/config/debug/highmem.h) \
  include/asm-generic/kmap_types.h \
  arch/x86/include/asm/pgtable_types.h \
    $(wildcard include/config/mem/soft/dirty.h) \
    $(wildcard include/config/proc/fs.h) \
  arch/x86/include/asm/pgtable_64_types.h \
  arch/x86/include/asm/sparsemem.h \
  arch/x86/include/asm/nospec-branch.h \
    $(wildcard include/config/retpoline.h) \
  include/linux/static_key.h \
  arch/x86/include/asm/alternative-asm.h \
  arch/x86/include/asm/spinlock_types.h \
    $(wildcard include/config/paravirt/spinlocks.h) \
  include/asm-generic/qspinlock_types.h \
  include/asm-generic/qrwlock_types.h \
  include/asm-generic/ptrace.h \
  arch/x86/include/uapi/asm/sigcontext.h \
  arch/x86/include/asm/msr.h \
    $(wildcard include/config/tracepoints.h) \
  arch/x86/include/asm/msr-index.h \
  arch/x86/include/uapi/asm/errno.h \
  include/uapi/asm-generic/errno.h \
  include/uapi/asm-generic/errno-base.h \
  arch/x86/include/asm/cpumask.h \
  include/linux/cpumask.h \
    $(wildcard include/config/cpumask/offstack.h) \
    $(wildcard include/config/hotplug/cpu.h) \
    $(wildcard include/config/debug/per/cpu/maps.h) \
  include/linux/bitmap.h \
  arch/x86/include/uapi/asm/msr.h \
  arch/x86/include/asm/atomic.h \
  arch/x86/include/asm/cmpxchg.h \
  arch/x86/include/asm/cmpxchg_64.h \
  arch/x86/include/asm/atomic64_64.h \
  include/asm-generic/atomic-instrumented.h \
  include/linux/tracepoint-defs.h \
  include/linux/atomic.h \
    $(wildcard include/config/generic/atomic64.h) \
  include/asm-generic/atomic-long.h \
  arch/x86/include/asm/paravirt.h \
  arch/x86/include/asm/frame.h \
  arch/x86/include/asm/special_insns.h \
  arch/x86/include/asm/fpu/types.h \
  arch/x86/include/asm/unwind_hints.h \
  arch/x86/include/asm/orc_types.h \
  arch/x86/include/asm/vmxfeatures.h \
  arch/x86/include/asm/vdso/processor.h \
  include/linux/personality.h \
  include/uapi/linux/personality.h \
  include/linux/err.h \
  include/linux/irqflags.h \
    $(wildcard include/config/trace/irqflags.h) \
    $(wildcard include/config/irqsoff/tracer.h) \
    $(wildcard include/config/preempt/tracer.h) \
    $(wildcard include/config/trace/irqflags/support.h) \
  arch/x86/include/asm/irqflags.h \
  include/linux/bottom_half.h \
  include/linux/lockdep.h \
    $(wildcard include/config/lockdep.h) \
    $(wildcard include/config/lock/stat.h) \
    $(wildcard include/config/prove/raw/lock/nesting.h) \
  include/linux/lockdep_types.h \
    $(wildcard include/config/preempt/lock.h) \
  include/linux/smp.h \
    $(wildcard include/config/up/late/init.h) \
  include/linux/errno.h \
  include/uapi/linux/errno.h \
  include/linux/llist.h \
    $(wildcard include/config/arch/have/nmi/safe/cmpxchg.h) \
  arch/x86/include/asm/smp.h \
    $(wildcard include/config/x86/local/apic.h) \
    $(wildcard include/config/x86/io/apic.h) \
    $(wildcard include/config/debug/nmi/selftest.h) \
  arch/x86/include/asm/mpspec.h \
    $(wildcard include/config/eisa.h) \
    $(wildcard include/config/x86/mpparse.h) \
  arch/x86/include/asm/mpspec_def.h \
  arch/x86/include/asm/x86_init.h \
  arch/x86/include/asm/apicdef.h \
  arch/x86/include/asm/apic.h \
    $(wildcard include/config/x86/x2apic.h) \
  arch/x86/include/asm/fixmap.h \
    $(wildcard include/config/provide/ohci1394/dma/init.h) \
    $(wildcard include/config/pci/mmconfig.h) \
    $(wildcard include/config/x86/intel/mid.h) \
    $(wildcard include/config/acpi/apei/ghes.h) \
    $(wildcard include/config/intel/txt.h) \
  arch/x86/include/uapi/asm/vsyscall.h \
  include/asm-generic/fixmap.h \
  arch/x86/include/asm/hardirq.h \
    $(wildcard include/config/kvm/intel.h) \
    $(wildcard include/config/have/kvm.h) \
    $(wildcard include/config/x86/thermal/vector.h) \
    $(wildcard include/config/x86/mce/threshold.h) \
    $(wildcard include/config/x86/mce/amd.h) \
    $(wildcard include/config/hyperv.h) \
  arch/x86/include/asm/io_apic.h \
  arch/x86/include/asm/irq_vectors.h \
    $(wildcard include/config/pci/msi.h) \
  arch/x86/include/generated/asm/mmiowb.h \
  include/asm-generic/mmiowb.h \
    $(wildcard include/config/mmiowb.h) \
  include/linux/spinlock_types.h \
  include/linux/rwlock_types.h \
  arch/x86/include/asm/spinlock.h \
  arch/x86/include/asm/qspinlock.h \
  include/asm-generic/qspinlock.h \
  arch/x86/include/asm/qrwlock.h \
  include/asm-generic/qrwlock.h \
  include/linux/rwlock.h \
    $(wildcard include/config/preempt.h) \
  include/linux/spinlock_api_smp.h \
    $(wildcard include/config/inline/spin/lock.h) \
    $(wildcard include/config/inline/spin/lock/bh.h) \
    $(wildcard include/config/inline/spin/lock/irq.h) \
    $(wildcard include/config/inline/spin/lock/irqsave.h) \
    $(wildcard include/config/inline/spin/trylock.h) \
    $(wildcard include/config/inline/spin/trylock/bh.h) \
    $(wildcard include/config/uninline/spin/unlock.h) \
    $(wildcard include/config/inline/spin/unlock/bh.h) \
    $(wildcard include/config/inline/spin/unlock/irq.h) \
    $(wildcard include/config/inline/spin/unlock/irqrestore.h) \
    $(wildcard include/config/generic/lockbreak.h) \
  include/linux/rwlock_api_smp.h \
    $(wildcard include/config/inline/read/lock.h) \
    $(wildcard include/config/inline/write/lock.h) \
    $(wildcard include/config/inline/read/lock/bh.h) \
    $(wildcard include/config/inline/write/lock/bh.h) \
    $(wildcard include/config/inline/read/lock/irq.h) \
    $(wildcard include/config/inline/write/lock/irq.h) \
    $(wildcard include/config/inline/read/lock/irqsave.h) \
    $(wildcard include/config/inline/write/lock/irqsave.h) \
    $(wildcard include/config/inline/read/trylock.h) \
    $(wildcard include/config/inline/write/trylock.h) \
    $(wildcard include/config/inline/read/unlock.h) \
    $(wildcard include/config/inline/write/unlock.h) \
    $(wildcard include/config/inline/read/unlock/bh.h) \
    $(wildcard include/config/inline/write/unlock/bh.h) \
    $(wildcard include/config/inline/read/unlock/irq.h) \
    $(wildcard include/config/inline/write/unlock/irq.h) \
    $(wildcard include/config/inline/read/unlock/irqrestore.h) \
    $(wildcard include/config/inline/write/unlock/irqrestore.h) \
  include/linux/rwsem.h \
    $(wildcard include/config/rwsem/spin/on/owner.h) \
    $(wildcard include/config/debug/rwsems.h) \
  include/linux/osq_lock.h \
  include/linux/mutex.h \
    $(wildcard include/config/mutex/spin/on/owner.h) \
    $(wildcard include/config/debug/mutexes.h) \
  include/linux/debug_locks.h \
    $(wildcard include/config/debug/locking/api/selftests.h) \
  arch/x86/include/asm/cpu_entry_area.h \
    $(wildcard include/config/cpu/sup/intel.h) \
  arch/x86/include/asm/intel_ds.h \
  include/linux/percpu.h \
    $(wildcard include/config/need/per/cpu/embed/first/chunk.h) \
    $(wildcard include/config/need/per/cpu/page/first/chunk.h) \
  include/linux/mmdebug.h \
    $(wildcard include/config/debug/vm.h) \
    $(wildcard include/config/debug/vm/pgflags.h) \

/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/common/task.o: $(deps_/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/common/task.o)

$(deps_/home/Raphael.maria/Downloads/vmware-host-modules-workstation-16.1.2/vmmon-only/common/task.o):
