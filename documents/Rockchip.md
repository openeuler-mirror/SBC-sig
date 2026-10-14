# 瑞芯微等开发板

本仓库提供适用于 Rockchip 等开发板的 openEuler 镜像的构建脚本和相关文档。

<!-- TOC -->

- [瑞芯微等开发板](#瑞芯微等开发板)
    - [文件说明](#文件说明)
    - [最新镜像](#最新镜像)
    - [镜像构建](#镜像构建)
        - [准备环境](#准备环境)
        - [构建完整镜像](#构建完整镜像)
        - [Docker 容器内构建](#docker-容器内构建)
            - [使用脚本构建镜像需执行命令：](#使用脚本构建镜像需执行命令)
            - [使用 Docker 分步构建](#使用-docker-分步构建)
        - [顺序构建](#顺序构建)
    - [刷写镜像](#刷写镜像)
        - [刷写到 SD 卡](#刷写到-sd-卡)
        - [刷写到 EMMC](#刷写到-emmc)
    - [问题汇总](#问题汇总)

<!-- /TOC -->

## 文件说明

- [贡献指南](CONTRIBUTING.md)
- [开发板兼容性列表](compatibility-list.md)
- [documents](./rockchip): 使用文档
    - [openEuler镜像的构建](rockchip/openEuler镜像的构建.md)
    - [刷写EMMC镜像](rockchip/刷写EMMC镜像.md)
    - [顺序构建](rockchip/顺序构建.md)
    - [构建完整镜像命令列举](rockchip/构建完整镜像命令列举.md)
    - [基于Firefly-SDK编译Firefly-RK3399的内核镜像](rockchip/基于Firefly-SDK编译Firefly-RK3399的内核镜像.md)
    - [打包 ITX-RK3588J 一体化烧写镜像](rockchip/打包ITX-RK3588J一体化烧写镜像.md)
    - [设置 SELinux](rockchip/设置SELinux.md)
    - [使用 Docker 构建镜像](rockchip/使用Docker构建镜像.md)
    - [openEuler 适配指南](rockchip/openEuler适配指南.md)
    - [在openEuler上使用RKNPU](rockchip/在openEuler上使用RKNPU.md)
    - [在openEuler上运行RKLLM](rockchip/在openEuler上运行RKLLM.md)
- [scripts](../scripts):  构建 openEuler 树莓派、Rockchip 等开发板镜像的脚本
    - [构建完整镜像](scripts/build.sh)
    - [使用 Docker 构建完整镜像](./scripts/build-image-docker.sh)
    - [构建 boot 镜像](scripts/build_boot.sh)
    - [构建 rootfs 镜像](scripts/build_rootfs.sh)
    - [将 u-boot、boot、rootfs 合并成一个完整镜像](scripts/gen_image.sh)

## 最新镜像

镜像下载连接及基本信息见 [瑞芯微等其他开发板](../README.md#瑞芯微等其他开发板)。

## 镜像构建

>![](public_sys-resources/icon-notice.gif) **须知：**  
>RK3399 当前支持 openEuler 版本：20.03 LTS、20.03 LTS SP1、20.03 LTS SP2、20.03 LTS SP3、22.03 LTS SP2 和 22.03 LTS SP3。
>RK3566/RK3568 当前支持 openEuler 版本：22.03 LTS SP2、22.03 LTS SP3 和 24.03 LTS。
>RK3588 当前支持 openEuler 版本：22.03 LTS、22.03 LTS SP2 和 22.03 LTS SP3。
>如果构建包含 Xfce/UKUI/DDE 桌面环境的镜像，需要注意三点：
>1. 构建包含 Xfce 桌面环境的镜像，当前只支持 20.03 LTS SP2、20.03 LTS SP3、21.09、22.03 LTS、22.03 LTS SP3、24.03 LTS 版本。
>2. 构建包含 UKUI 或 DDE 桌面环境的镜像，当前只支持 20.03 LTS SP1、20.03 LTS SP2、20.03 LTS SP3、21.09、22.03 LTS、22.03 LTS SP3、24.03 LTS 版本。
>3. 根据需要设置 -s/--spec，其具体意义见该参数的介绍部分。同时需要设置对应 -r/--repo 参数。

### 准备环境
- 操作系统：openEuler 、CentOS 8
- 架构：
    - AArch64，如树莓派、 RK3399 开发板、 RK3588 开发板
    - X86_64，[详细说明](#问题汇总)

**注意: 在`直接构建镜像时所使用的设备的 openEuler 版本`或`使用 Docker 拉取的 openEuler 版本`需要与待构建的版本相近，例如：构建适用于 RK3588 开发板的 openEuler 22.03 LTS 时可以使用 openEuler 22.03 LTS SP1、openEuler 22.03 LTS SP2、openEuler 22.03 LTS SP3 以及 openEuler 22.03 LTS SP4。**

详细过程参见 [openEuler 镜像的构建](rockchip/openEuler镜像的构建.md)。

构建脚本见 [scripts](../scripts)。

### 构建完整镜像

构建镜像需执行命令：

`sudo bash build.sh --board BOARD_CONFIG -n NAME -k KERNEL_URL -b KERNEL_BRANCH -c KERNEL_DEFCONFIG -r REPO_INFO -s SPEC --cores N`

**说明: 基于 build.sh 提供的默认参数，执行 sudo bash build.sh 可构建 Firefly-RK3399 的 openEuler-20.03-LTS 镜像。**

脚本执行完成后，会在脚本所在目录的 build/YYYY-MM-DD 文件夹下生成以下文件：

- 打包后的 EMMC 刷写文件：openEuler-VERSION-BOARD-RELEASE.tar.gz。
- 压缩后的 RAW 原始镜像：openEuler-VERSION-BOARD-ARCH-RELEASE.img.xz。

>打包后的 EMMC 刷写文件和压缩后的 RAW 原始镜像文件有什么区别？

>1. 打包后的 EMMC 刷写文件：指需要使用 RKDevTool 或者 rkdeveloptool 来刷入到例如 Firefly-RK3399 这一类自带 EMMC 储存介质的开发板中。
>2. 压缩后的 RAW 原始镜像文件：通常指的是一个完整的磁盘镜像文件，其中包含了所有磁盘扇区的数据。可以刷写到例如 SD 卡、EMMC 等多种储存介质中。
>3. 带 EMMC 的开发板也可以使用 SD 卡启动镜像，启动选择的储存介质各不相同，如果 EMMC 启动优先级大于 SD 卡，则优先启动 EMMC 内的系统，在这种情况下若想使用 SD 卡内的系统需要先清空 EMMC。
>4. EMMC 刷写过程在 [刷写到 EMMC](#刷写到-emmc) 中介绍；SD 卡刷写过程在 [刷写到 SD 卡](#刷写到-sd-卡) 中介绍。

各个参数意义：

1.  --board BOARD_CONFIG

    适用的开发板的版型配置文件在 [boards](../scripts/boards) 文件夹中，示例文件 [sample.conf](../scripts/boards/sample.conf)，默认为 `firefly-rk3399`。
    
    其包括的配置参数意义如下：

    - platform=PLATFORM

        开发板所使用的平台，目前支持的平台有：broadcom、rockchip、phytium，默认为 `rockchip`。

    - device-tree=DTB_NAME

        内核设备树中的设备名称，和开发板名称有一点区别，对应 [kernel/arch/arm64/boot/dts/rockchip](https://atomgit.com/openeuler/kernel/tree/master/arch/arm64/boot/dts/rockchip) 下的 `DTB_NAME.dts` 文件，默认为 `rk3399-firefly`。

    - ubootconfig=UBOOT_DEFCONFIG

        开发板对应的 defconfig 的文件名称，对应 [u-boot/configs](https://github.com/u-boot/u-boot/tree/master/configs) 下 `UBOOT_DEFCONFIG` 文件，默认为 `firefly-rk3399_defconfig`；如需在 RK3588 开发板上使用预编译的 u-boot，可以将此项设置为空：`ubootconfig=`。

2.  -n, --name IMAGE_NAME

    构建的镜像名称，例如：`openEuler-20.03-LTS-Firefly-RK3399-aarch64-alpha1` 或 `openEuler-21.09-Firefly-RK3399-aarch64-alpha1`。

3.  -k, --kernel KERNEL_URL

    内核源码仓库的项目地址，默认为 `https://atomgit.com/openeuler/rockchip-kernel.git`。可根据需要设置为 `git@atomgit.com:openeuler/rockchip-kernel.git` 或 `git@atomgit.com:openeuler/kernel.git`。

4.  -b, --branch KERNEL_BRANCH

    内核源码的对应分支，默认为 openEuler-20.03-LTS。根据 -k 参数有以下选择：

    - -k https://atomgit.com/openeuler/rockchip-kernel.git
        - openEuler-20.03-LTS
    - -k https://atomgit.com/openeuler/kernel.git
        - openEuler-21.09

5.  -c, --config KERNEL_DEFCONFIG

    内核编译使用的配置文件名称或路径，默认为 `openeuler_rockchip_defconfig`。如果该参数为配置文件名称，请确保该文件在内核源码的目录 `arch/arm64/configs` 或构建框架的 [scripts/configs/common](../scripts/configs/common) 下。

6.  -r, --repo REPO_INFO

    软件源 repo 文件的 URL 或者路径，也可以是软件源中资源库的 baseurl 列表。注意，如果该参数为资源库的 baseurl 列表，该参数需要使用双引号，各个 baseurl 之间以空格隔开。
    下面分别举例：

    - 软件源 repo 文件的 URL，如 `https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-20.03-LTS/generic.repo`。
    - 软件源的 repo 文件路径：

        `./openEuler-20.03-LTS.repo`：生成 openEuler 20.03 LTS 版本的镜像，该文件内容参考 <https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo>。

    - 资源库的 baseurl 列表，如 `http://repo.openeuler.org/openEuler-20.03-LTS/OS/aarch64/ http://repo.openeuler.org/openEuler-20.03-LTS/EPOL/aarch64/`。

7.  -s, --spec SPEC

    构建的镜像版本：
    - `headless`，无图形界面版的镜像。
    - `xfce`，带 Xfce 桌面以及中文字体、输入法等全部配套软件。
    - `ukui`，带 UKUI 桌面及必要的配套软件（不包括中文字体以及输入法）。
    - `dde`，带 DDE 桌面及必要的配套软件（不包括中文字体以及输入法）。
    -  rpmlist 文件路径，其中包含镜像中要安装的软件列表，内容参考 [rpmlist](../scripts/configs/common/rpmlist)。

    默认使用 `headless` 选项。

8.  --cores N

    并行编译的数量，根据运行脚本的宿主机 CPU 实际数目设定，默认为可用的 CPU 总数。

9.  -h, --help

    显示帮助信息。

已经测试的开发板如下，其他类型开发板适用情况待测试。

<table><thead align="left"><tr>
<th class="cellrowborder" valign="top" width="10%"><p><strong>开发板名称</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>开发板信息</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>芯片名称</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>支持的 openEuler 版本</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>构建命令</strong></p></th>
</tr></thead>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><ul><li>Firefly RK3399</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://wiki.t-firefly.com/zh_CN/Firefly-RK3399/index.html">Firefly Wiki</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Rockchip RK3399</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 20.03 LTS, openEuler 22.03 LTS SP2, openEuler 22.03 LTS SP3, openEuler 24.03 LTS</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#firefly-rk3399">构建完整镜像命令</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><ul><li>Radxa Rock Pi 4A</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://docs.radxa.com/rock4/rock4ab">Radxa Wiki</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Rockchip RK3399</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 20.03 LTS, openEuler 22.03 LTS</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#radxa-rockpi-4a">构建完整镜像命令</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><ul><li>Firefly ROC-RK3566-PC</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://wiki.t-firefly.com/zh_CN/ROC-RK3566-PC/">Firefly Wiki</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Rockchip RK3566</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 22.03 LTS SP2, openEuler 22.03 LTS SP3, openEuler 24.03 LTS</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#firefly-roc-rk3566-pc">构建完整镜像命令</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><ul><li>Firefly ROC-RK3568-PC-SE</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://wiki.t-firefly.com/zh_CN/ROC-RK3568-PC-SE/">Firefly Wiki</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Rockchip RK3568</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 22.03 LTS SP2, openEuler 22.03 LTS SP3</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#firefly-roc-rk3568-pc-se">构建完整镜像命令</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><ul><li>Firefly ROC-RK3568-PC</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://wiki.t-firefly.com/zh_CN/ROC-RK3568-PC/">Firefly Wiki</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Rockchip RK3568</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 22.03 LTS SP2, openEuler 22.03 LTS SP3</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#firefly-roc-rk3568-pc">构建完整镜像命令</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><ul><li>BananaPi Armsom-Sige5</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://docs.armsom.org/armsom-sige5">Armsom Wiki</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Rockchip RK3576</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 22.03 LTS SP3</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#bananapi-armsom-sige5">构建完整镜像命令</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><ul><li>100ASK DShanPi A1</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://wiki.dshanpi.org/docs/DshanPi-A1/intro">DShanPi Wiki</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Rockchip RK3576</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 22.03 LTS SP3</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#100ask-dshanpi-a1">构建完整镜像命令</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><ul><li>Firefly ITX-3588J</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://wiki.t-firefly.com/zh_CN/Core-3588J/index.html">Firefly Wiki</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Rockchip RK3588</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 22.03 LTS SP3</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#firefly-itx-3588j">构建完整镜像命令</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><ul><li>Firefly ROC-RK3588S-PC</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://wiki.t-firefly.com/zh_CN/ROC-RK3588S-PC/index.html">Firefly Wiki</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Rockchip RK3588</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 22.03 LTS SP2, openEuler 22.03 LTS SP3</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#firefly-roc-rk3588s-pc">构建完整镜像命令</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><ul><li>Radxa Rock-5B</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://docs.radxa.com/rock5/rock5b">Radxa Wiki</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Rockchip RK3588</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 22.03 LTS SP2, openEuler 22.03 LTS SP3</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#radxa-rock-5b">构建完整镜像命令</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><ul><li>Phytium Pi 4GB</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://www.phytium.com.cn/homepage/phytium_pie/">Phytium Website</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Phytium</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 22.03 LTS SP4, openEuler 24.03 LTS SP1</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#phytium-pi-4gb">构建完整镜像命令</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><ul><li>Orange Pi Zero 2</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="http://www.orangepi.cn/orangepiwiki/index.php/Orange_Pi_Zero_2">OrangePi Wiki</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Allwinner H616</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 20.03 LTS, openEuler 24.03 LTS</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#orange-pi-zero-2">构建完整镜像命令</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><ul><li>Longan Pi 3H</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://wiki.sipeed.com/hardware/zh/longan/h618/lpi3h/1_intro.html">Sipeed Wiki</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Allwinner H618</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 24.03 LTS</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#longan-pi-3h">构建完整镜像命令</a></td>
<tr>
<td class="cellrowborder" valign="top" width="10%"><ul><li>Khadas VIM3</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://docs.khadas.com/products/sbc/vim3/start">Khadas Wiki</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Amlogic A311D</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 24.03 LTS</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#khadas-vim3">构建完整镜像命令</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><ul><li>Radxa Orion O6</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://docs.radxa.com/orion/o6">Radxa Wiki</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>CIX P1 CD8180</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 24.03 LTS</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#radxa-orion-o6">构建完整镜像命令</a></td>
</tr>
</tbody></table>

### Docker 容器内构建

#### 使用脚本构建镜像需执行命令：

`sudo bash build-image-docker.sh -d DOCKER_FILE --board BOARD_CONFIG -n NAME -k KERNEL_URL -b KERNEL_BRANCH -c KERNEL_DEFCONFIG -r REPO_INFO -s SPEC --cores N`

脚本运行结束后，镜像默认保存在脚本运行所在目录的 `build/YYYY-MM-DD` 下。

注意！！！运行该脚本前，需安装 Docker 运行环境。该脚本会自动将 DOCKER_FILE 参数对应的 Docker 镜像导入本机系统中。

除参数 DOCKER_FILE 外，剩余参数与[构建完整镜像](#构建完整镜像)中对应参数一致：

1.  -d, --docker DOCKER_FILE

    Docker 镜像的 URL 或者路径， 默认为 `https://repo.openeuler.org/openEuler-22.03-LTS-SP3/docker_img/aarch64/openEuler-docker.aarch64.tar.xz`。使用该默认参数时，脚本会自动下载 openEuler 22.03 LTS SP3 的 Docker 镜像，并导入本机系统中。

#### 使用 Docker 分步构建

请参考文档：[使用 Docker 构建镜像](rockchip/使用Docker构建镜像.md)

### 顺序构建

依次执行脚本构建生成压缩后的 SD 卡启动镜像和打包后的 EMMC 刷写文件，过程参考[顺序构建](rockchip/顺序构建.md)。

## 刷写镜像

### 刷写到 SD 卡

将压缩后的 RAW 原始镜像解压后写入 SD 卡，请参考[树莓派镜像烧录](raspberrypi/刷写镜像.md)，过程中所用到的镜像应为本项目提供适用于 Rockchip 开发板的镜像。

>注意：由于 Firefly-RK3399 与其他 RK3399 开发板不同，会优先启动 EMMC 上的系统，在 Firefly-RK3399 上使用 SD 卡启动镜像之前需要清除 EMMC 上的系统，上电后需要按下电源键来启动。

### 刷写到 EMMC

将 openEuler 安装到 EMMC，详见[刷写EMMC镜像](rockchip/刷写EMMC镜像.md)。


## 问题汇总

1.  自构建 openEuler 镜像登录时提示 Login incorrect：
    
    该问题通常有以下几种特征：

    - 根据提示输入 root / openeuler 后提示 Login incorrect
    
    ```
    openEuler 22.03 LTS
    Kernel 5.10.0 on an aarch64

    openEuler login:root
    Password:

    Login incorrect
    ```

    - chroot 到根目录无法修改密码

    `passwd:Authentication token manipulation error`

    遇到这一类问题有以下解决方法，如果有更多方法，欢迎反馈：

    - [使用 Docker 构建镜像（推荐）](rockchip/使用Docker构建镜像.md)
    
    - [设置 SELinux](rockchip/设置SELinux.md)

2.  使用 x86_64 的主机进行构建时的注意事项：

    (1) 由于 openEuler x86_64 软件仓库没有交叉编译工具链，在使用 x86_64 进行构建时，需要使用 [openEuler Embedded Toolchains](https://atomgit.com/openeuler/yocto-meta-openeuler/releases/tag/toolchains-v0.1.8) 交叉编译工具链。

    (2) 在使用 x86_64 架构进行构建时，构建主机需具备运行 QEMU User Static 的环境支持。目前，openEuler 25.09 以及 openEuler 24.03 LTS SP3 已正式集成该软件包；而对于在 openEuler 22.03 LTS 至 openEuler 24.03 LTS SP3 之间的版本，则使用 openEuler 24.03 LTS SP3 软件仓库的 QEMU User Static 软件包。

    (3) 使用 `build-image-docker.sh` 指定 Docker 容器镜像时，应该使用和构建主机架构相同的容器；在 x86_64 上使用 Docker 构建时，推荐使用 Ubuntu 22.04 LTS，经测试 Ubuntu 24.03 LTS 会出现安全权限问题。

    (4) 本框架支持在不同的操作系统（例如 Ubuntu、Fedora）以及不同的架构（x86_64）上构建 openEuler，在 x86_64 的 Ubuntu 22.04 LTS 下使用 Docker 经过测试的目标开发板及构建命令举例如下，其他开发板型号和环境待测试：

      - Rockchip: Firefly ROC-RK3588S-PC

        ```
        sudo bash build-image-docker.sh \
             --board firefly-roc-rk3588s-pc \
             -d https://repo.openeuler.org/openEuler-22.03-LTS-SP3/docker_img/x86_64/openEuler-docker.x86_64.tar.xz \
             -n openEuler-22.03-LTS-SP3-Station-M3-aarch64-alpha1 \
             -k https://atomgit.com/openeuler/rockchip-kernel.git \
             -b openEuler-22.03-LTS-SP3 \
             -c openeuler_rockchip_defconfig \
             -r https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-22.03-LTS-SP3/generic.repo \
             -s headless
        ```

      - Allwinner: Orange Pi Zero 2

        ```
        sudo bash build-image-docker.sh \
             --board orangepi-zero2 \
             -d https://repo.openeuler.org/openEuler-24.03-LTS/docker_img/x86_64/openEuler-docker.x86_64.tar.xz \
             -n openEuler-24.03-LTS-OrangePi-Zero2-aarch64-alpha1 \
             -k https://atomgit.com/openeuler/allwinner-kernel.git \
             -b openEuler-24.03-LTS \
             -c openeuler_allwinner_defconfig \
             -r https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-24.03-LTS/generic.repo \
             -s headless
        ```

      - Phytium: Phytium Pi 4GB

        ```
        sudo bash build-image-docker.sh \
            --board phytiumpi-4gb \
            -d https://repo.openeuler.org/openEuler-24.03-LTS-SP1/docker_img/aarch64/openEuler-docker.aarch64.tar.xz \
            -n openEuler-24.03-LTS-SP1-PhytiumPi-4GB-aarch64-alpha3 \
            -k https://atomgit.com/openeuler/phytium-kernel.git \
            -b openEuler-24.03-LTS-SP1-update-20260922 \
            -c phytium_defconfig \
            -r https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-24.03-LTS-SP1/generic.repo \
            -s headless
        ```

      - Amlogic: Khadas VIM3

        ```
        sudo bash build-image-docker.sh \
             --board khadas-vim3 \
             -d https://repo.openeuler.org/openEuler-24.03-LTS/docker_img/x86_64/openEuler-docker.x86_64.tar.xz \
             -n openEuler-24.03-LTS-Khadas-VIM3-aarch64-alpha1 \
             -k https://atomgit.com/openeuler/kernel.git \
             -b OLK-6.6 \
             -c amlogic-kernel-OLK-6.6.config \
             -r https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-24.03-LTS/generic.repo \
             -s headless
        ```

      - CIX: Radxa Orion O6

        ```
        sudo bash build-image-docker.sh \
             --board radxa-orion-o6 \
             -d https://repo.openeuler.org/openEuler-24.03-LTS/docker_img/x86_64/openEuler-docker.x86_64.tar.xz \
             -n openEuler-24.03-LTS-Radxa-Orion-O6-aarch64-alpha1 \
             -k https://github.com/armbian/linux-cix.git \
             -b cix-6.6-2025q3 \
             -c cix-kernel-cix-6.6-2025q3.config \
             -r https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-24.03-LTS/generic.repo \
             -s headless
        ```