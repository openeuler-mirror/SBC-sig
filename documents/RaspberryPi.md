# 树莓派

本文档提供 [树莓派](https://atomgit.com/openeuler/raspberrypi-kernel)、[Rockchip](https://atomgit.com/openeuler/rockchip)的 openEuler 镜像的构建脚本和相关文档。

<!-- TOC -->

- [树莓派](#树莓派)
    - [文件说明](#文件说明)
    - [最新镜像](#最新镜像)
    - [使用镜像](#使用镜像)
    - [镜像构建](#镜像构建)
        - [准备环境](#准备环境)
        - [构建镜像](#构建镜像)
            - [无需编译内核构建镜像](#无需编译内核构建镜像)
            - [使用自定义内核构建镜像](#使用自定义内核构建镜像)
            - [Docker 容器内构建镜像](#docker-容器内构建镜像)

<!-- /TOC -->

## 文件说明

>![](public_sys-resources/icon-note.gif) **说明：**   
>- 建议直接使用本文档 [最新镜像](#最新镜像) 章节中给出的 openEuler 的树莓派镜像。
>- 如需根据自身需求定制镜像，可参考 [openEuler 镜像的构建](raspberrypi/openEuler镜像的构建.md) 和 [交叉编译内核](raspberrypi/交叉编译内核.md)。

- [贡献指南](CONTRIBUTING.md)
- [开发板兼容性列表](compatibility-list.md)
- [树莓派](./raspberrypi): 使用文档
  - [刷写镜像](raspberrypi/刷写镜像.md)
  - [树莓派使用](raspberrypi/树莓派使用.md)
  - [openEuler 镜像的构建](raspberrypi/openEuler镜像的构建.md)
  - [交叉编译内核](raspberrypi/交叉编译内核.md)
  - [QEMU 启动树莓派](raspberrypi/QEMU启动树莓派.md)
  - [Hailo AI](raspberrypi/HailoAI.md)
  - [树莓派部署 OpenClaw](raspberrypi/树莓派部署openclaw.md)
  - [openEuler 20.03 LTS SP2 更新日志](raspberrypi/changelog/changelog-20.03-LTS-SP2.md)
  - [openEuler 20.03 LTS SP2 内测版（UKUI 桌面、中文输入法）更新日志](raspberrypi/changelog/changelog-20.03-LTS-SP2-UKUI.md)
  - [openEuler 20.03 LTS SP2 内测版（DDE 桌面、中文输入法）更新日志](raspberrypi/changelog/changelog-20.03-LTS-SP2-DDE.md)
  - [openEuler 20.03 LTS SP2 内测版（Xfce 桌面、中文输入法）更新日志](raspberrypi/changelog/changelog-20.03-LTS-SP2-Xfce.md)
  - [openEuler 21.09 更新日志](raspberrypi/changelog/changelog-21.09.md)
  - [openEuler 21.09 内测版（UKUI 桌面、中文输入法）更新日志](raspberrypi/changelog/changelog-21.09-UKUI.md)
  - [openEuler 21.09 内测版（DDE 桌面、中文输入法）更新日志](raspberrypi/changelog/changelog-21.09-DDE.md)
  - [openEuler 21.09 内测版（Xfce 桌面、中文输入法）更新日志](raspberrypi/changelog/changelog-21.09-Xfce.md)
  - [openEuler 21.09 内测版（LXDE 桌面、中文输入法）更新日志](raspberrypi/changelog/changelog-21.09-LXDE.md)
- [scripts](../scripts): 构建 openEuler 树莓派镜像的脚本
  - [构建完整镜像](scripts/build.sh)
  - [使用 Docker 构建完整镜像](./scripts/build-image-docker.sh)
  - [构建 boot 镜像](scripts/build_boot.sh)
  - [构建 rootfs 镜像](scripts/build_rootfs.sh)
  - [将 u-boot、boot、rootfs 合并成一个完整镜像](scripts/gen_image.sh)


## 最新镜像

>![](public_sys-resources/icon-notice.gif) **须知：**   
>当前只有 openEuler 24.03 LTS SP1/25.03/24.03 LTS SP2/25.09/24.03 LTS SP3/24.03 LTS SP4 版本的树莓派镜像同时支持树莓派 5 和树莓派 3B/3B+/4B/400，其他版本的树莓派镜像只支持树莓派 3B/3B+/4B/400。

[所有镜像](raspberrypi/images.md)。

其他信息：
- 固件来源：[firmware](https://github.com/raspberrypi/firmware)、[bluez-firmware](https://github.com/RPi-Distro/bluez-firmware)、[firmware-nonfree](https://github.com/RPi-Distro/firmware-nonfree)

## 使用镜像

镜像刷写 SD 卡并使用树莓派，详见以下文档：

- [刷写镜像](raspberrypi/刷写镜像.md)
- [树莓派使用](raspberrypi/树莓派使用.md)

## 镜像构建

### 准备环境

本仓库的脚本运行环境要求如下：

- 操作系统：openEuler、CentOS 7、CentOS 8
- 架构：AArch64，如树莓派

其他架构可以使用 [QEMU](https://www.qemu.org/) 模拟器搭建 AArch64 运行环境。

### 构建镜像

详细过程参见 [openEuler 镜像的构建](raspberrypi/openEuler镜像的构建.md)。

构建脚本见 [scripts](../scripts)。

构建镜像需执行命令：

`sudo bash build.sh --board BOARD_CONFIG -n NAME -k KERNEL_URL -b KERNEL_BRANCH -c KERNEL_DEFCONFIG -r REPO_INFO -s SPEC --cores N`

脚本运行结束后，会提示镜像的存储位置，镜像默认保存在脚本运行所在目录的 `build/YYYY-MM-DD/` 下。

各个参数意义：

1.  --board BOARD_CONFIG

    适用的开发板的版型配置文件在 [boards](../scripts/boards) 文件夹中，示例文件 [sample.conf](../scripts/boards/sample.conf)。构建树莓派镜像需要设置为 `raspberrypi`，对应文件 [raspberrypi.conf](../scripts/boards/raspberrypi.conf)。

    其包括的配置参数意义如下：

    - platform=PLATFORM

        开发板所使用的平台，目前支持的平台有：broadcom、rockchip、phytium。构建树莓派镜像需要设置为 `broadcom`。

    - device-tree=DTB_NAME

        内核设备树中的设备名称，和开发板名称有一点区别，对应 [kernel/arch/arm64/boot/dts/broadcom](https://atomgit.com/openeuler/raspberrypi-kernel/tree/OLK-6.6/arch/arm64/boot/dts/broadcom) 下的 `DTB_NAME.dts` 文件。构建树莓派镜像时，默认编译出所有树莓派平台的设备树文件，因此该参数可以为空或者根据需要设置为 `bcm2711-rpi-4-b` 或 `bcm2712-rpi-5-b`。

    - ubootconfig=UBOOT_DEFCONFIG

        开发板对应的 defconfig 的文件名称，对应 [u-boot/configs](https://github.com/u-boot/u-boot/tree/master/configs) 下 `UBOOT_DEFCONFIG` 文件，默认为 `firefly-rk3399_defconfig`。构建树莓派镜像无需这部分内容，默认为空：`ubootconfig=`。

2.  -n, --name IMAGE_NAME

    构建的镜像名称，例如：`openEuler-24.03-LTS-raspi-aarch64-alpha1`。

3.  -k, --kernel KERNEL_URL

    内核源码仓库的项目地址，如 `https://atomgit.com/openeuler/raspberrypi-kernel.git`。可根据需要设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git` 或 `git@atomgit.com:openeuler/kernel.git`。

    注意，如果本参数为空，则不会编译内核源码，默认使用软件源中的内核包。

4.  -b, --branch KERNEL_BRANCH

    内核源码的对应分支，例如：OLK-6.6。详细信息可参考 [使用自定义内核构建镜像](#使用自定义内核构建镜像) 章节。

5.  -c, --config KERNEL_DEFCONFIG

    内核编译使用的配置文件名称或路径，如 `bcm2711_defconfig`、`bcm2712_defconfig`。如果该参数为配置文件名称，请确保该文件在内核源码的目录 arch/arm64/configs 下。

    注意，如果 `--branch` 参数为 `OLK-6.6` 且本参数 `--config` 为空，则默认编译出同时支持树莓派 5 和树莓派 4B 的内核映像。

6.  -r, --repo REPO_INFO

    软件源 repo 文件的 URL 或者路径，也可以是软件源中资源库的 baseurl 列表。注意，如果该参数为资源库的 baseurl 列表，该参数需要使用双引号，各个 baseurl 之间以空格隔开。

    下面分别举例：
    - 软件源 repo 文件的 URL，如 `https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-20.03-LTS-SP1/generic.repo`
    - 软件源的 repo 文件路径：

        `./openEuler-20.03-LTS-SP1.repo`：生成 openEuler 20.03 LTS SP1 版本的镜像，该文件内容参考 <https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS-SP1/generic.repo>。
    - 资源库的 baseurl 列表，如 `"http://repo.openeuler.org/openEuler-20.03-LTS-SP1/OS/aarch64/ http://repo.openeuler.org/openEuler-20.03-LTS-SP1/EPOL/aarch64/"`。

7.  -s, --spec SPEC

    构建的镜像版本：
    - `headless`，无图形界面版的镜像。
    - `xfce`，带 Xfce 桌面以及中文字体、输入法等全部配套软件。
    - `ukui`，带 UKUI 桌面以及中文字体、输入法等全部配套软件。
    - `dde`，带 DDE 桌面以及中文字体、输入法等全部配套软件。
    - `gnome`，带 GNOME 桌面以及中文字体、输入法等全部配套软件。
    - `devstation`，带 GNOME 桌面、中文字体、输入法、大量开发工具和 IDE 等配套软件。
    -  rpmlist 文件路径，该文件包含镜像中要安装的软件列表，内容参考 [rpmlist](../scripts/configs/raspberrypi/rpmlist)。

    默认使用 `headless` 选项。

8.  --cores N

    并行编译的数量，根据运行脚本的宿主机 CPU 实际数目设定，默认为可用的 CPU 总数。

9.  -h, --help

    显示帮助信息。


#### 无需编译内核构建镜像
例如，使用软件源中的内核包构建 openEuler 24.03 LTS SP2 版本 openEuler 树莓派镜像，执行命令：`sudo bash build.sh --board raspberrypi --kernel "" --branch "" --config "" --repo https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-24.03-LTS-SP2/generic.repo --name openEuler-24.03-LTS-raspi-aarch64-alpha1`


>![](public_sys-resources/icon-notice.gif) **须知：**  
>无需编译内核，使用软件源中的内核包，当前支持版本有 20.09、20.03 LTS SP1、21.03、20.03 LTS SP2、21.09、20.03 LTS SP3、22.03 LTS、22.09、22.03 LTS SP1、23.03、22.03 LTS SP2、22.03 LTS SP3、24.03 LTS、22.03 LTS SP4、24.09、24.03 LTS SP1、25.03、24.03 LTS SP2、25.09、24.03 LTS SP3、24.03 LTS SP4。
>如果构建包含 Xfce/UKUI/DDE/GNOME 桌面环境或者 DevStation 开发者工作站的镜像，需要注意五点：
>1. 构建包含 Xfce 桌面环境的镜像，当前只支持 openEuler 21.03/20.03 LTS SP2/21.09/20.03 LTS SP3/22.03 LTS/22.09/22.03 LTS SP1/23.03/22.03 LTS SP2/22.03 LTS SP3/24.03 LTS/22.03 LTS SP4/24.09 版本。自 openEuler 24.03 LTS SP1 起，不再支持 Xfce 桌面环境。
>2. 构建包含 DDE 桌面环境的镜像，当前只支持 openEuler 20.03 LTS SP1/21.03/20.03 LTS SP2/21.09/20.03 LTS SP3/22.03 LTS/22.09/22.03 LTS SP1/23.03/22.03 LTS SP2/22.03 LTS SP3/24.03 LTS/22.03 LTS SP4/24.09/24.03 LTS SP1/25.03/24.03 LTS SP2/25.09/24.03 LTS SP3/24.03 LTS SP4 版本。
>3. 构建包含 GNOME 桌面环境的镜像，当前只支持 openEuler 24.03 LTS/24.09/24.03 LTS SP1/25.03/24.03 LTS SP2/25.09/24.03 LTS SP3/24.03 LTS SP4 版本。
>4. 构建 DevStation 开发者工作站的镜像，当前只支持 openEuler 24.03 LTS SP1/25.03/24.03 LTS SP2/25.09/24.03 LTS SP3/24.03 LTS SP4 版本。
>5. 根据需要设置 -s/--spec，其具体意义见该参数的介绍部分。


#### 使用自定义内核构建镜像
例如，使用软件源中的内核包构建 openEuler 24.03 LTS SP2 版本 openEuler 树莓派镜像，执行命令：`sudo bash build.sh --board raspberrypi --kernel "https://atomgit.com/openeuler/raspberrypi-kernel.git" --branch "OLK-6.6" --config "" --repo https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-24.03-LTS-SP2/generic.repo --name openEuler-24.03-LTS-raspi-aarch64-alpha1`

>![](public_sys-resources/icon-notice.gif) **须知：**  
>使用自定义内核，当前支持版本有 20.03 LTS、20.09、20.03 LTS SP1、21.03、20.03 LTS SP2、21.09、20.03 LTS SP3、22.03 LTS、22.09、22.03 LTS SP1、23.03、22.03 LTS SP2、22.03 LTS SP3、24.03 LTS、22.03 LTS SP4、24.09、24.03 LTS SP1、25.03、24.03 LTS SP2、25.09、24.03 LTS SP3、24.03 LTS SP4。
>如果构建包含 Xfce/UKUI/DDE 桌面环境或者 DevStation 开发者工作站的镜像，需要注意六点：
>1. 构建包含 Xfce 桌面环境的镜像，当前只支持 openEuler 21.03/20.03 LTS SP2/21.09/20.03 LTS SP3/22.03 LTS/22.09/22.03 LTS SP1/23.03/22.03 LTS SP2/22.03 LTS SP3/24.03 LTS/22.03 LTS SP4/24.09 版本，需要选择对应内核源码和分支。自 openEuler 24.03 LTS SP1 起，不再支持 Xfce 桌面环境。
>    -  openEuler 21.03：需要选择 [openEuler 内核](https://atomgit.com/openeuler/kernel) 的 [openEuler-21.03](https://atomgit.com/openeuler/kernel/tree/openEuler-21.03/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/kernel.git`，`-b/--branch` 设置为 `openEuler-21.03`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 20.03 LTS SP2/20.03 LTS SP3：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-20.03-LTS](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-20.03-LTS/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-20.03-LTS`，`-c/--config` 设置为 `openeuler-raspi_defconfig`。
>    -  openEuler 21.09：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-21.09](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-21.09/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-21.09`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 22.03 LTS：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-22.03-LTS](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-22.03-LTS/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-22.03-LTS`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 22.09：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-22.09](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-22.09/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-22.09`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 22.03 LTS SP1：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-22.03-LTS-SP1](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-22.03-LTS-SP1/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-22.03-LTS-SP1`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 23.03：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-23.03](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-23.03/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-23.03`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 22.03 LTS SP2：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-22.03-LTS-SP2](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-22.03-LTS-SP2/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-22.03-LTS-SP2`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 22.03 LTS SP3/22.03 LTS SP4：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [OLK-5.10](https://atomgit.com/openeuler/raspberrypi-kernel/tree/OLK-5.10/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `OLK-5.10`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 24.03 LTS/24.09：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [OLK-6.6](https://atomgit.com/openeuler/raspberrypi-kernel/tree/OLK-6.6/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `OLK-6.6`，`-c/--config` 设置为空 `""`。
>2. 构建包含 UKUI 桌面环境的镜像，当前只支持 openEuler 20.09/20.03 LTS SP1/21.03/20.03 LTS SP2/21.09/20.03 LTS SP3/22.03 LTS/22.09/22.03 LTS SP1/23.03/22.03 LTS SP2/22.03 LTS SP3/24.03 LTS/22.03 LTS SP4/24.09/24.03 LTS SP1/25.03/24.03 LTS SP2/25.09/24.03 LTS SP3/24.03 LTS SP4 版本，需要选择对应内核源码和分支。
>    -  openEuler 20.09：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-20.09](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-20.09/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-20.09`，`-c/--config` 设置为 `openeuler-raspi_defconfig`。
>    -  openEuler 20.03 LTS SP1/20.03 LTS SP2/20.03 LTS SP3：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-20.03-LTS](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-20.03-LTS/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-20.03-LTS`，`-c/--config` 设置为 `openeuler-raspi_defconfig`。
>    -  openEuler 21.03：需要选择 [openEuler 内核](https://atomgit.com/openeuler/kernel) 的 [openEuler-21.03](https://atomgit.com/openeuler/kernel/tree/openEuler-21.03/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/kernel.git`，-b/--branch` 设置为 `openEuler-21.03`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 21.09：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-21.09](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-21.09/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-21.09`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 22.03 LTS：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-22.03-LTS](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-22.03-LTS/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-22.03-LTS`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 22.09：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-22.09](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-22.09/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-22.09`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 22.03 LTS SP1：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-22.03-LTS-SP1](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-22.03-LTS-SP1/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-22.03-LTS-SP1`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 23.03：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-23.03](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-23.03/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-23.03`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 22.03 LTS SP2：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-22.03-LTS-SP2](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-22.03-LTS-SP2/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-22.03-LTS-SP2`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 22.03 LTS SP3/22.03 LTS SP4：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [OLK-5.10](https://atomgit.com/openeuler/raspberrypi-kernel/tree/OLK-5.10/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `OLK-5.10`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 24.03 LTS/24.09/24.03 LTS SP1/24.03 LTS SP2/24.03 LTS SP3/24.03 LTS SP4：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [OLK-6.6](https://atomgit.com/openeuler/raspberrypi-kernel/tree/OLK-6.6/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `OLK-6.6`，`-c/--config` 设置为空 `""`。
>    -  openEuler 25.03：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-25.03](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-25.03/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-25.03`，`-c/--config` 设置为空 `""`。
>    -  openEuler 25.09：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-25.09](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-25.09/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-25.09`，`-c/--config` 设置为空 `""`。
>3. 构建包含 DDE 桌面环境的镜像，当前只支持 openEuler 20.03 LTS SP1/21.03/20.03 LTS SP2/21.09/20.03 LTS SP3/22.03 LTS/22.09/22.03 LTS SP1/23.03/22.03 LTS SP2/22.03 LTS SP3/24.03 LTS/22.03 LTS SP4/24.09/24.03 LTS SP1/25.03/24.03 LTS SP2/25.09/24.03 LTS SP3/24.03 LTS SP4 版本。
>    -  openEuler 20.03 LTS SP1/20.03 LTS SP2/20.03 LTS SP3：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-20.03-LTS](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-20.03-LTS/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-20.03-LTS`，`-c/--config` 设置为 `openeuler-raspi_defconfig`。
>    -  openEuler 21.03：需要选择 [openEuler 内核](https://atomgit.com/openeuler/kernel) 的 [openEuler-21.03](https://atomgit.com/openeuler/kernel/tree/openEuler-21.03/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/kernel.git`，-b/--branch` 设置为 `openEuler-21.03`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 21.09：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-21.09](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-21.09/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-21.09`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 22.03 LTS：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-22.03-LTS](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-22.03-LTS/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-22.03-LTS`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 22.09：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-22.09](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-22.09/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-22.09`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 22.03 LTS SP1：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-22.03-LTS-SP1](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-22.03-LTS-SP1/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-22.03-LTS-SP1`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 23.03：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-23.03](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-23.03/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-23.03`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 22.03 LTS SP2：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-22.03-LTS-SP2](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-22.03-LTS-SP2/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-22.03-LTS-SP2`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 22.03 LTS SP3/22.03 LTS SP4：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [OLK-5.10](https://atomgit.com/openeuler/raspberrypi-kernel/tree/OLK-5.10/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `OLK-5.10`，`-c/--config` 设置为 `bcm2711_defconfig`。
>    -  openEuler 24.03 LTS/24.09/24.03 LTS SP1/24.03 LTS SP2/24.03 LTS SP3/24.03 LTS SP4：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [OLK-6.6](https://atomgit.com/openeuler/raspberrypi-kernel/tree/OLK-6.6/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `OLK-6.6`，`-c/--config` 设置为空 `""`。
>    -  openEuler 25.03：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-25.03](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-25.03/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-25.03`，`-c/--config` 设置为空 `""`。
>    -  openEuler 25.09：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-25.09](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-25.09/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-25.09`，`-c/--config` 设置为空 `""`。
>4. 构建包含 GNOME 桌面环境的镜像，当前只支持 openEuler 24.03 LTS/22.03 LTS SP4/24.09/24.03 LTS SP1/25.03/24.03 LTS SP2/25.09/24.03 LTS SP3/24.03 LTS SP4 版本。
>    -  openEuler 24.03 LTS/24.09/24.03 LTS SP1/24.03 LTS SP2/24.03 LTS SP3/24.03 LTS SP4：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [OLK-6.6](https://atomgit.com/openeuler/raspberrypi-kernel/tree/OLK-6.6/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `OLK-6.6`，`-c/--config` 设置为空 `""`。
>    -  openEuler 25.03：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-25.03](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-25.03/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-25.03`，`-c/--config` 设置为空 `""`。
>5. 构建 DevStation 开发者工作站的镜像，当前只支持 openEuler 24.03 LTS SP1/25.03/24.03 LTS SP2/24.03 LTS SP3/24.03 LTS SP4 版本。
>    -  openEuler 24.03 LTS SP1/24.03 LTS SP2/24.03 LTS SP3/24.03 LTS SP4：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [OLK-6.6](https://atomgit.com/openeuler/raspberrypi-kernel/tree/OLK-6.6/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `OLK-6.6`，`-c/--config` 设置为空 `""`。
>    -  openEuler 25.03：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-25.03](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-25.03/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-25.03`，`-c/--config` 设置为空 `""`。
>    -  openEuler 25.09：需要选择 [openEuler-RaspberryPi 内核](https://atomgit.com/openeuler/raspberrypi-kernel) 的 [openEuler-25.09](https://atomgit.com/openeuler/raspberrypi-kernel/tree/openEuler-25.09/) 分支，即将参数 `-k/--kernel` 设置为 `git@atomgit.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-25.09`，`-c/--config` 设置为空 `""`。
>6. 根据需要设置 -s/--spec，其具体意义见该参数的介绍部分。

#### Docker 容器内构建镜像

构建镜像需执行命令：

`sudo bash build-image-docker.sh -d DOCKER_FILE --board BOARD_CONFIG -n NAME -k KERNEL_URL -b KERNEL_BRANCH -c KERNEL_DEFCONFIG -r REPO_INFO -s SPEC --cores N`

脚本运行结束后，会提示镜像的存储位置，镜像默认保存在脚本运行所在目录的 `build/YYYY-MM-DD/` 下。

注意！！！运行该脚本前，需安装 Docker 运行环境。该脚本会自动将 `-d DOCKER_FILE` 参数对应的 Docker 镜像导入本机系统中。

除参数 `-d DOCKER_FILE` 外，其余参数与 [构建镜像章节](#构建镜像) 中 [build.sh](../scripts/build.sh) 对应参数一致：

1.  -d, --docker DOCKER_FILE

    Docker 镜像的 URL 或者路径， 默认为 `https://repo.openeuler.org/openEuler-20.03-LTS-SP1/docker_img/aarch64/openEuler-docker.aarch64.tar.xz`。使用该默认参数时，脚本会自动下载 openEuler 20.03 LTS SP1 的 Docker 镜像，并导入本机系统中。

使用 Docker 构建镜像支持在不同的操作系统（例如 Ubuntu、Fedora）以及不同的架构（x86_64）上构建树莓派镜像，经过测试的版本构建命令举例如下，其他版本待测试：

```
sudo bash build.sh \
    --board raspberrypi \
    -n openEuler-24.03-LTS-RaspberryPi-aarch64-alpha1 \
    -k https://atomgit.com/openeuler/raspberrypi-kernel.git \
    -b OLK-6.6 \
    -c bcm2712_defconfig \
    -r https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-24.03-LTS/generic.repo \
    -s headless
```