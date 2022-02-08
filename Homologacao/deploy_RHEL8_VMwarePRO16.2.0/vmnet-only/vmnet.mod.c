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
	{ 0x6bc3fbc0, "__unregister_chrdev" },
	{ 0x8200293d, "kmalloc_caches" },
	{ 0xd2b09ce5, "__kmalloc" },
	{ 0x53219e85, "sock_init_data" },
	{ 0xde9d724c, "put_devmap_managed_page" },
	{ 0x1ed8b599, "__x86_indirect_thunk_r8" },
	{ 0xec916042, "__skb_gso_segment" },
	{ 0x58388972, "pv_lock_ops" },
	{ 0xe25ee9d3, "_raw_write_lock_irqsave" },
	{ 0x92af3c33, "proc_create_single_data" },
	{ 0x263ed23b, "__x86_indirect_thunk_r12" },
	{ 0x37110088, "remove_wait_queue" },
	{ 0xc7a4fbed, "rtnl_lock" },
	{ 0x32ae5741, "_raw_read_lock" },
	{ 0xf1b501ca, "skb_clone" },
	{ 0xb945b867, "skb_copy" },
	{ 0x420ecfe3, "seq_printf" },
	{ 0xd2da1048, "register_netdevice_notifier" },
	{ 0xa5976e4f, "dev_base_lock" },
	{ 0x6729d3df, "__get_user_4" },
	{ 0x6ad5f0ce, "__register_chrdev" },
	{ 0xc29957c3, "__x86_indirect_thunk_rcx" },
	{ 0xa6093a32, "mutex_unlock" },
	{ 0xb1e483fe, "skb_set_owner_w" },
	{ 0xb348a850, "ex_handler_refcount" },
	{ 0x97651e6c, "vmemmap_base" },
	{ 0x91715312, "sprintf" },
	{ 0x15ba50a6, "jiffies" },
	{ 0x9d0d6206, "unregister_netdevice_notifier" },
	{ 0xe2d5255a, "strcmp" },
	{ 0x1c1b9f8e, "_raw_write_unlock_irqrestore" },
	{ 0xda96277a, "proc_remove" },
	{ 0x696246f, "__netdev_alloc_skb" },
	{ 0xd6025ada, "__pskb_pull_tail" },
	{ 0xd9a5ea54, "__init_waitqueue_head" },
	{ 0xb44ad4b3, "_copy_to_user" },
	{ 0xaad8c7d6, "default_wake_function" },
	{ 0x7e526bfa, "__x86_indirect_thunk_r10" },
	{ 0xfb578fc5, "memset" },
	{ 0x24f94834, "netif_rx_ni" },
	{ 0x2434cd30, "proc_mkdir" },
	{ 0x56a744c0, "sk_alloc" },
	{ 0x3812050a, "_raw_spin_unlock_irqrestore" },
	{ 0x9202ba1c, "current_task" },
	{ 0xd3197df2, "skb_copy_datagram_iter" },
	{ 0x27e1a049, "printk" },
	{ 0x449ad0a7, "memcmp" },
	{ 0xef045c19, "free_netdev" },
	{ 0xa1c76e0a, "_cond_resched" },
	{ 0x6aee3d4e, "register_netdev" },
	{ 0x94ca0b57, "skb_push" },
	{ 0x41aed6e7, "mutex_lock" },
	{ 0xd4f05c18, "sk_free" },
	{ 0xcaad8e24, "dev_remove_pack" },
	{ 0x3701a196, "csum_partial_copy_to_user" },
	{ 0xa29abf62, "init_net" },
	{ 0xfe487975, "init_wait_entry" },
	{ 0x7cd8d75e, "page_offset_base" },
	{ 0xc6cbbc89, "capable" },
	{ 0xb601be4c, "__x86_indirect_thunk_rdx" },
	{ 0xb2fd5ceb, "__put_user_4" },
	{ 0x93fca811, "__get_free_pages" },
	{ 0xdb7305a1, "__stack_chk_fail" },
	{ 0x1000e51, "schedule" },
	{ 0x67b4bbab, "kfree_skb" },
	{ 0x83dba64c, "alloc_netdev_mqs" },
	{ 0x2ea2c95c, "__x86_indirect_thunk_rax" },
	{ 0x1030cd3d, "eth_type_trans" },
	{ 0xbdfb6dbb, "__fentry__" },
	{ 0xcbd4898c, "fortify_panic" },
	{ 0xb05be19c, "ether_setup" },
	{ 0x80526da3, "__dev_get_by_name" },
	{ 0xf86c8d03, "kmem_cache_alloc_trace" },
	{ 0xdbf17652, "_raw_spin_lock" },
	{ 0x51760917, "_raw_spin_lock_irqsave" },
	{ 0x1e01660e, "vsnprintf" },
	{ 0x4302d0eb, "free_pages" },
	{ 0x3eeb2322, "__wake_up" },
	{ 0xef62b796, "iov_iter_init" },
	{ 0x8c26d495, "prepare_to_wait_event" },
	{ 0x4afb2238, "add_wait_queue" },
	{ 0x22975705, "dev_set_promiscuity" },
	{ 0x37a0cba, "kfree" },
	{ 0x69acdf38, "memcpy" },
	{ 0x92540fbf, "finish_wait" },
	{ 0xdea8077e, "skb_dequeue" },
	{ 0x51adffd1, "unregister_netdev" },
	{ 0x56bf228f, "dev_add_pack" },
	{ 0xd471b997, "consume_skb" },
	{ 0x17cb5773, "dev_queue_xmit" },
	{ 0x5bce0a2a, "skb_put" },
	{ 0x362ef408, "_copy_from_user" },
	{ 0xdb792a1b, "param_ops_uint" },
	{ 0x6e720ff2, "rtnl_unlock" },
	{ 0x88db9f48, "__check_object_size" },
	{ 0xd52cffda, "__put_page" },
	{ 0xddd3cd83, "get_user_pages_fast" },
	{ 0xf1e63929, "devmap_managed_key" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


MODULE_INFO(srcversion, "45FEC03A271A70396076D4B");
MODULE_INFO(rhelversion, "8.4");
