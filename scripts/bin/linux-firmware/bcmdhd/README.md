### 目录说明

本目录用于存放 bcmdhd 无线驱动的无线固件：

bcmdhd 驱动和 brcmfmac 驱动有什么区别：

bcmdhd 和 brcmfmac 都是博通网卡的无线驱动。其中 brcmfmac 是由主线维护的驱动，随着 Linux 版本的更新而更新，但是支持的模块受限；bcmdhd 是由博通提供的原厂驱动，只能用于特定版本，支持的无线模块较多。

适用的开发板：

1. Firefly-RK3399

   - 内核仓库：https://gitee.com/openeuler/rockchip-kernel

   - 内核分支：[openEuler-20.03-LTS](https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-20.03-LTS/)

   - 无线驱动：[openEuler-20.03-LTS bcmdhd](https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-20.03-LTS/drivers/net/wireless/rockchip_wlan/rkwifi/bcmdhd)
   
   &nbsp;

2. ROC-RK3568-PC

   - 内核仓库：https://gitee.com/openeuler/rockchip-kernel

   - 内核分支：
     - [openEuler-22.03-LTS-SP2](https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-22.03-LTS-SP2/)

     - [openEuler-22.03-LTS-SP3](https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-22.03-LTS-SP3/)

   - 无线驱动：

     - [openEuler-22.03-LTS-SP2 bcmdhd](https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-22.03-LTS-SP2/drivers/net/wireless/rockchip_wlan/rkwifi/bcmdhd)

     - [openEuler-22.03-LTS-SP3 bcmdhd](https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-22.03-LTS-SP3/drivers/net/wireless/rockchip_wlan/rkwifi/bcmdhd)