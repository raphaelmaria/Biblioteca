#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

MODULE_INFO(vermagic, VERMAGIC_STRING);
MODULE_INFO(name, KBUILD_MODNAME);

__visible struct module __this_module
__attribute__((section(".gnu.linkonce.this_module"))) = {
	.name = KBUILD_MODNAME,
	.init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
	.exit = cleanup_module,
#endif
	.arch = MODULE_ARCH_INIT,
};

#ifdef RETPOLINE
MODULE_INFO(retpoline, "Y");
#endif

static const struct modversion_info ____versions[]
__used
__attribute__((section("__versions"))) = {
	{ 0xf8cdd757, "module_layout" },
	{ 0xfc3b81ee, "alloc_pages_current" },
	{ 0x8200293d, "kmalloc_caches" },
	{ 0xd2b09ce5, "__kmalloc" },
	{ 0xde9d724c, "put_devmap_managed_page" },
	{ 0xb862f611, "up_read" },
	{ 0xd6ee688f, "vmalloc" },
	{ 0x58388972, "pv_lock_ops" },
	{ 0xdd01082e, "schedule_hrtimeout" },
	{ 0x17add64b, "gdt_page" },
	{ 0x15244c9d, "boot_cpu_data" },
	{ 0x7e16fb9b, "vm_node_stat" },
	{ 0x4cc8f9c8, "init_timer_key" },
	{ 0x999e8297, "vfree" },
	{ 0x167e7f9d, "__get_user_1" },
	{ 0x44aaf30f, "tsc_khz" },
	{ 0x7a2af7b4, "cpu_number" },
	{ 0x97651e6c, "vmemmap_base" },
	{ 0xdc1e5ca7, "kthread_create_on_node" },
	{ 0x15ba50a6, "jiffies" },
	{ 0x8e24c3d1, "down_read" },
	{ 0xd90043b5, "vm_zone_stat" },
	{ 0xb44ad4b3, "_copy_to_user" },
	{ 0x17de3d5, "nr_cpu_ids" },
	{ 0x2adb8261, "kernel_read" },
	{ 0x692fcb28, "misc_register" },
	{ 0xec02a35f, "del_timer_sync" },
	{ 0xdad13544, "ptrs_per_p4d" },
	{ 0xfb578fc5, "memset" },
	{ 0xd38cd261, "__default_kernel_pte_mask" },
	{ 0x3744cf36, "vmalloc_to_pfn" },
	{ 0x9202ba1c, "current_task" },
	{ 0x27e1a049, "printk" },
	{ 0x3e18c761, "kthread_stop" },
	{ 0xd976fb37, "_totalram_pages" },
	{ 0x31cd8869, "__cpu_online_mask" },
	{ 0x18e5edf9, "vmap" },
	{ 0x4c9d28b0, "phys_base" },
	{ 0xa1c76e0a, "_cond_resched" },
	{ 0x593c1bac, "__x86_indirect_thunk_rbx" },
	{ 0x6626afca, "down" },
	{ 0x28985b9f, "mod_timer" },
	{ 0x616f51f0, "poll_freewait" },
	{ 0x318f7969, "add_timer" },
	{ 0x1d19f77b, "physical_mask" },
	{ 0x7c75c1ef, "up_write" },
	{ 0xe727456a, "down_write" },
	{ 0x5813db4b, "fput" },
	{ 0xa9fce792, "poll_initwait" },
	{ 0x7cd8d75e, "page_offset_base" },
	{ 0xf63b72ee, "__free_pages" },
	{ 0xd75c79df, "smp_call_function" },
	{ 0xd6b33026, "cpu_khz" },
	{ 0x93fca811, "__get_free_pages" },
	{ 0xdb7305a1, "__stack_chk_fail" },
	{ 0x8ddd8aad, "schedule_timeout" },
	{ 0x1000e51, "schedule" },
	{ 0x2ea2c95c, "__x86_indirect_thunk_rax" },
	{ 0xa022f265, "pv_cpu_ops" },
	{ 0xc00d5473, "wake_up_process" },
	{ 0xbdfb6dbb, "__fentry__" },
	{ 0xcc5005fe, "msleep_interruptible" },
	{ 0xf86c8d03, "kmem_cache_alloc_trace" },
	{ 0xdbf17652, "_raw_spin_lock" },
	{ 0x1e01660e, "vsnprintf" },
	{ 0x4302d0eb, "free_pages" },
	{ 0xb3f7646e, "kthread_should_stop" },
	{ 0x4f68e5c9, "do_gettimeofday" },
	{ 0x1f37cca7, "schedule_hrtimeout_range" },
	{ 0x37a0cba, "kfree" },
	{ 0x32d9cea2, "smp_ops" },
	{ 0x94961283, "vunmap" },
	{ 0x72d79d83, "pgdir_shift" },
	{ 0x69acdf38, "memcpy" },
	{ 0x6df1aaf1, "kernel_sigaction" },
	{ 0x9feaf7bc, "pv_mmu_ops" },
	{ 0xcf2a6966, "up" },
	{ 0x6e314ecb, "fget" },
	{ 0x53569707, "this_cpu_off" },
	{ 0x63c4d61f, "__bitmap_weight" },
	{ 0x2198cff7, "vmalloc_to_page" },
	{ 0xe3fffae9, "__x86_indirect_thunk_rbp" },
	{ 0x362ef408, "_copy_from_user" },
	{ 0x113b918c, "misc_deregister" },
	{ 0x379d9241, "__init_rwsem" },
	{ 0x88db9f48, "__check_object_size" },
	{ 0x6228c21f, "smp_call_function_single" },
	{ 0xd52cffda, "__put_page" },
	{ 0xddd3cd83, "get_user_pages_fast" },
	{ 0xf1e63929, "devmap_managed_key" },
	{ 0x8a35b432, "sme_me_mask" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


MODULE_INFO(srcversion, "6E8671B090E7E732FC41E79");
MODULE_INFO(rhelversion, "8.4");
