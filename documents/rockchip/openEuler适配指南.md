- [描述](#描述)
- [新开发板移植适配指南](#新开发板移植适配指南)
  - [内核移植](#内核移植)
  - [准备 u-boot](#准备-u-boot)
  - [准备 firmware 文件](#准备-firmware-文件)
  - [编写版型文件](#编写版型文件)
  - [运行测试](#运行测试)

# 描述

本文档介绍如何为本框架适配新的开发板。

# 新开发板适配指南

## 内核移植

内核移植是难度较大的工作，具体步骤不做介绍，移植 openEuler 内核的大致流程如下：

  1.  移植相关的内核驱动到以下仓库：

       - 瑞芯微：

         https://gitee.com/openeuler/rockchip-kernel.git

       - 飞腾：

         https://gitee.com/openeuler/phytium-kernel.git

       - 全志：
       
         https://gitee.com/openeuler/allwinner-kernel.git

  2.  如果内核仓库中已经存在相关驱动，则只需要在相应内核仓库提交对应开发板的内核设备树即可。

## 准备 u-boot

  - RK3399

    在版型文件中定义 u-boot 配置名称，参考下文[编写版型文件](#编写版型文件)。

  - RK35xx

    需要将编译好的 u-boot 二进制文件放到 [u-boot 目录](../../scripts/rockchip/bin/u-boot/)下，并在 [build_boot.sh](../../scripts/rockchip/build_u-boot.sh#L126) 中增加相应操作。

## 准备 firmware 文件
   
这里提到的 firmware 是开发板的板载蓝牙和 WiFi 的驱动固件，可参考[本框架储存的的 firmware 文件](../../scripts/rockchip/bin/linux-firmware/)。

请确定开发板所使用的 firmware，并提交至仓库的相应目录下。

## 编写版型文件

适用的开发板的版型配置文件在 [boards](../../scripts/rockchip/boards/) 文件夹中，版型文件示例如下：

```
ubootconfig=firefly-rk3399_defconfig  #Required! The name of defconfig file when compiling u-boot, which defaults to firefly-rk3399_defconfig.
dtb_name=rk3399-firefly  #Required! The device tree name of target board, which defaults to rk3399-firefly.
platform=rockchip  #Required! The platform of target board, which defaults to rockchip.

POST_BOARD_OVERLAY() {
    echo "Put ${board} firmware into rootfs..."

    mkdir -p ${rootfs_dir}/usr/lib/firmware/brcm
    cp ${nonfree_bin_dir}/linux-firmware/ap6356s/brcmfmac4356-sdio.bin ${rootfs_dir}/usr/lib/firmware/brcm
    cp ${nonfree_bin_dir}/linux-firmware/ap6356s/brcmfmac4356-sdio.firefly,firefly-rk3399.txt ${rootfs_dir}/usr/lib/firmware/brcm
    cp ${nonfree_bin_dir}/linux-firmware/ap6356s/BCM4356A2.hcd ${rootfs_dir}/usr/lib/firmware/brcm
}
```
    
其包括的配置参数意义如下：

  1.  ubootconfig=UBOOT_DEFCONFIG

      开发板对应的 defconfig 的文件名称，对应 [u-boot/configs](https://github.com/u-boot/u-boot/tree/master/configs) 下 `UBOOT_DEFCONFIG` 文件，默认为 `firefly-rk3399_defconfig`；如需在 RK3568/RK3588 开发板上使用预编译的 u-boot，可以将此项设置为 `none`。

  2.  dtb_name=DTB_NAME

      内核设备树中的设备名称，和开发板名称有一点区别，对应 [kernel/arch/arm64/boot/dts/rockchip](https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-22.03-LTS-SP3/arch/arm64/boot/dts/rockchip) 下的 `DTB_NAME.dts` 文件。

  3.  platform=PLATFORM

      开发板所使用的平台，目前支持的平台有：rockchip、phytium。

    
  4.  POST_BOARD_OVERLAY()

      `POST_BOARD_OVERLAY()` 是执行复制 firmware 文件到根目录以及对目标开发板根目录执行特定操作的函数，其使用的变量与 [build_rootfs.sh](../../scripts/rockchip/build_rootfs.sh) 相同，通常包含以下两个变量：

      - nonfree_bin_dir

        该参数为储存 firmware 的文件夹，默认为 [${workdir}/../bin](../../scripts/rockchip/bin/)。

      - rootfs_dir

        该参数为框架构建的 openEuler 根目录所在的路径，默认为 `${workdir}/rootfs`。
    
## 运行测试

通过运行脚本[一次构建](../瑞芯微等开发板.md#一次构建)，将 `--board` 参数设置为新增开发板的版型文件来运行测试。