# 贡献指南
openEuler SBC SIG —— 诚挚邀请您的加入。

SBC（single-board computer）SIG 致力于将 openEuler 操作系统适配到各类单板计算机（SBC），包括但不限于树莓派（Raspberry Pi）、瑞芯微（Rockchip）等。其核心工作涵盖硬件适配、内核维护、镜像构建、社区协作及标准化推进，旨在确保 openEuler 在 SBC 设备上的稳定运行和生态扩展。更多信息请参阅 [openEuler SBC SIG 介绍](https://atomgit.com/openeuler/community/blob/master/sig/sig-SBC/README.md)。

SBC SIG 交流方式可参考：
- [openEuler 社区贡献说明](https://atomgit.com/openeuler/community/blob/master/zh/contributors/README.md)
- [如何参与 SBC SIG](../README.md#如何参与-sig-组)

本文将以树莓派为例，介绍向 SBC SIG 贡献代码和文档的要求与规范。

另外，针对瑞芯微系列开发板适配指南参考文档有 [openEuler 适配指南](rockchip/openEuler适配指南.md)

### 内核源码
SBC SIG 维护的内核源码仓库包括：
- [树莓派内核](https://atomgit.com/openeuler/raspberrypi-kernel)
- [瑞芯微内核](https://atomgit.com/openeuler/rockchip-kernel)
- [飞腾内核](https://atomgit.com/openeuler/phytium-kernel)
- [全志内核](https://atomgit.com/openeuler/allwinner-kernel)

内核源码贡献相关流程如下：
1. 新增开发板适配需求：请在本仓库提交 ISSUE，待需求审核通过并在 openEuler 社区创建对应内核仓库后，方可接受相关内核适配的 PR。
2. 现有内核（树莓派、瑞芯微、飞腾或全志）适配：请在对应内核仓库或本仓库提交 ISSUE，并根据 ISSUE 提交新特性或内核修复的 PR。

### 镜像构建
SBC SIG 目前使用一套统一脚本构建各类开发板镜像，详见 [scripts](../scripts/)。主要包括：
- [构建完整镜像](../scripts/build.sh)
- [使用 Docker 构建完整镜像](../scripts/build-image-docker.sh)
- [构建 boot 镜像](../scripts/build_boot.sh)
- [构建 rootfs 镜像](../scripts/build_rootfs.sh)
- [编译 u-boot](../scripts/build_u-boot.sh)
- [将 u-boot、boot、rootfs 合并成一个完整镜像](../scripts/gen_image.sh)
- [构建开发板镜像的配置文件](../scripts/boards/)，如构建树莓派镜像的配置文件为 [raspberrypi.conf](../scripts/boards/raspberrypi.conf)。

以添加树莓派镜像构建脚本为例，步骤如下：
1. 在 [scripts/boards](../scripts/boards/) 下添加构建树莓派镜像的配置文件：[raspberrypi.conf](../scripts/boards/raspberrypi.conf)。
2. 根据树莓派镜像构建需求，依次完善以下脚本：
    - [构建 boot 镜像](scripts/build_boot.sh)
    - [构建 rootfs 镜像](scripts/build_rootfs.sh)
    - [编译 u-boot](scripts/build_u-boot.sh)
3. 完善脚本 [scripts/gen_image.sh](../scripts/gen_image.sh)，将上述步骤生成的 u-boot、boot、rootfs 整合成一个完整镜像。

构建脚本命令及参数说明请参考：
1. [树莓派镜像构建](./RaspberryPi.md#构建镜像)
1. [瑞芯微等开发板镜像构建](./Rockchip.md#构建完整镜像)

### 文档
SBC SIG 维护的各类开发板构建与使用文档存放于 [documents](./)。以添加树莓派相关文档为例，应包含以下内容：
1. 在 [README.md](../README.md) 和 [README.en.md](../README.en.md) 中补充：
    1. 树莓派相关文档列表：[文件说明](../README.md#文件说明)
    2. [树莓派镜像下载列表](../README.md#树莓派)
    3. [树莓派镜像构建方法](../README.md#构建镜像)
2. 在 [documents](./) 目录下添加树莓派的导航文档：[RaspberryPi.md](./RaspberryPi.md) ，文档名称为树莓派英文全称。
3. 在以树莓派英文全称命名的文件夹 [RaspberryPi](./RaspberryPi) 中归档所有树莓派相关文档。
