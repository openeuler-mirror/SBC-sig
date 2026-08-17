# SBC-sig

[English](./README.en.md) | 简体中文

本仓库是 openEuler 社区 SBC (Single-Board Computer) SIG 组的主仓库，提供 SIG 组相关信息以及适用于[树莓派](https://www.raspberrypi.org/)、[Rockchip](https://www.rock-chips.com/)、[全志](https://www.allwinnertech.com/)、[晶晨](https://www.amlogic.cn/)、[此芯](https://www.cixtech.com/)、[飞腾](https://www.phytium.com.cn/)等开发板的 openEuler 镜像的构建脚本和相关文档。

<!-- TOC -->

- [SBC-sig](#sbc-sig)
    - [To Do List](#to-do-list)
    - [如何参与 SIG 组](#如何参与-sig-组)
    - [文件说明](#文件说明)
    - [最新镜像](#最新镜像)
        - [树莓派](#树莓派)
        - [瑞芯微](#瑞芯微)
        - [飞腾](#飞腾)
    - [镜像构建](#镜像构建)
        - [准备环境](#准备环境)
        - [构建镜像](#构建镜像)
            - [宿主机上构建镜像](#宿主机上构建镜像)
            - [Docker 容器内构建镜像](#docker-容器内构建镜像)

<!-- /TOC -->
## To Do List

1. 树莓派
   1. [树莓派 CM4 核心板适配、测试](https://atomgit.com/openeuler/raspberrypi/issues/119)
2. Rockchip
   1. [openEuler 22.09 适配到 RK3399](https://atomgit.com/openeuler/rockchip/issues/5)
   2. [openEuler 22.03 LTS (Next) 适配到 Rockchip 开发板](https://atomgit.com/openeuler/rockchip/issues/20)
   3. [openEuler 22.03 LTS (Next) 适配到 ITX-3588J 开发板](https://atomgit.com/openeuler/rockchip-kernel/issues/6)
3. 全志
   1. [openEuler 5.10 内核适配到全志开发板](https://atomgit.com/openeuler/allwinner-kernel/issues/1)

## 如何参与 SIG 组

SIG 组基本信息位于 [sig-SBC](https://atomgit.com/openeuler/community/tree/master/sig/sig-SBC)。

- 建立或回复 issue：欢迎通过建立或回复 issue 来讨论，此 SIG 组维护的仓库列表可在 [sig-SBC](https://atomgit.com/openeuler/community/tree/master/sig/sig-SBC) 中查看。
- 加入 Slack 群组：[openeuler-sbc](https://openeuler-sbc.slack.com)
  - [加入群组链接](https://join.slack.com/t/openeuler-sbc/shared_invite/zt-uh95ug4n-yX7a~c7VrTEU64tZlX3Djw)
- SIG 组会议：每个月的第一个和第三个周三下午 17:00 - 17:30 会进行一次讨论会议
  - 会议链接：有以下两种获取方式
    - [openEuler 社区网站](https://openeuler.org/)下的会议日历中查看 `sig-SBC例会` 预定信息。
    - 微信小程序搜索 `openEuler`，添加 `OpenAtom openEuler` 小程序，可在其`会议`栏目查看 `sig-SBC例会` 预定信息。
  - [会议议题](https://etherpad.openeuler.org/p/sig-SBC-meetings)：每次会议前填写要讨论的议题，我们也会从 issue 列表中提取本周讨论的内容。
  - [会议记录](https://atomgit.com/openeuler/SBC-sig/issues/5)：每次会议结束后会议结论会更新在此 issue 中。
- 重要的事说三遍：**欢迎提交 PR！欢迎提交 PR！欢迎提交 PR！**

## 文件说明

>![](documents/public_sys-resources/icon-note.gif) **说明：**   
>- 建议直接使用本文档 [最新镜像](#最新镜像) 章节中给出的 openEuler 的树莓派/Rockchip 等镜像。

- [documents](./documents/): 使用文档
  - [贡献指南](documents/CONTRIBUTING.md)
  - [开发板兼容性列表](documents/compatibility-list.md)
  - [树莓派](documents/RaspberryPi.md)
    - [树莓派快速入门](documents/RaspberryPi.md)
    - [刷写镜像](documents/raspberrypi/刷写镜像.md)
    - [树莓派使用](documents/raspberrypi/树莓派使用.md)
    - [openEuler 镜像的构建](documents/raspberrypi/openEuler镜像的构建.md)
    - [交叉编译内核](documents/raspberrypi/交叉编译内核.md)
    - [QEMU 启动树莓派](documents/raspberrypi/QEMU启动树莓派.md)
    - [Hailo AI](documents/raspberrypi/HailoAI.md)
    - [树莓派部署 OpenClaw](documents/raspberrypi/树莓派部署openclaw.md)
  - [瑞芯微等其他开发板](documents/Rockchip.md)
    - [瑞芯微等快速入门](documents/Rockchip.md)
    - [openEuler镜像的构建](documents/rockchip/openEuler镜像的构建.md)
    - [刷写EMMC镜像](documents/rockchip/刷写EMMC镜像.md)
    - [顺序构建](documents/rockchip/顺序构建.md)
    - [基于Firefly-SDK编译Firefly-RK3399的内核镜像](documents/rockchip/基于Firefly-SDK编译Firefly-RK3399的内核镜像.md)
    - [打包 ITX-RK3588J 一体化烧写镜像](documents/rockchip/打包ITX-RK3588J一体化烧写镜像.md)
    - [设置 SELinux](documents/rockchip/设置SELinux.md)
    - [使用 Docker 构建镜像](documents/rockchip/使用Docker构建镜像.md)
    - [openEuler 适配指南](documents/rockchip/openEuler适配指南.md)
    - [在openEuler上使用RKNPU](documents/rockchip/在openEuler上使用RKNPU.md)
    - [在openEuler上运行RKLLM](documents/rockchip/在openEuler上运行RKLLM.md)
- [scripts](./scripts/): openEuler 镜像构建脚本
    - [构建完整镜像](scripts/build.sh)
    - [使用 Docker 构建完整镜像](./scripts/build-image-docker.sh)
    - [构建 boot 镜像](scripts/build_boot.sh)
    - [构建 rootfs 镜像](scripts/build_rootfs.sh)
    - [编译 u-boot](scripts/build_u-boot.sh)
    - [将 u-boot、boot、rootfs 合并成一个完整镜像](scripts/gen_image.sh)

## 最新镜像

### 树莓派

>![](./documents/public_sys-resources/icon-notice.gif) **须知：**   
>当前只有 openEuler 24.03 LTS SP1/25.03/24.03 LTS SP2/25.09/24.03 LTS SP3 版本的树莓派镜像同时支持树莓派 5 和树莓派 3B/3B+/4B/400，其他版本的树莓派镜像只支持树莓派 3B/3B+/4B/400。

树莓派镜像的基本信息如下所示。[更多树莓派镜像](documents/raspberrypi/images.md)

<table><thead align="left"><tr>
<th class="cellrowborder" valign="top" width="10%"><p><strong>镜像版本</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>系统用户（密码）</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>发布时间</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>大小</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>内核版本</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>构建文件系统的源仓库</strong></p></th>
</tr></thead>
<tbody>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.03-LTS-SP3-raspi-aarch64-alpha1.img.xz">openEuler 24.03 LTS SP3 内测版</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2026/01/16</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>332.3 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-132.0.0.17</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-24.03-LTS-SP3/generic.repo">openEuler 24.03 LTS SP3 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.03-LTS-SP3-UKUI-raspi-aarch64-alpha1.img.xz">openEuler 24.03 LTS SP3 内测版（UKUI 桌面、中文输入法）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2026/01/16</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.4 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-132.0.0.17</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-24.03-LTS-SP3/generic.repo">openEuler 24.03 LTS SP3 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.03-LTS-SP3-DDE-raspi-aarch64-alpha1.img.xz">openEuler 24.03 LTS SP3 内测版（DDE 桌面、中文输入法）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2026/01/16</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.7 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-132.0.0.17</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-24.03-LTS-SP3/generic.repo">openEuler 24.03 LTS SP3 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.03-LTS-SP3-GNOME-raspi-aarch64-alpha1.img.xz">openEuler 24.03 LTS SP3 内测版（GNOME 桌面、中文输入法）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2026/01/16</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.1 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-132.0.0.17</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-24.03-LTS-SP3/generic.repo">openEuler 24.03 LTS SP3 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.03-LTS-SP3-DevStation-raspi-aarch64-alpha1.img.xz">openEuler 24.03 LTS SP3 内测版（DevStation 开发者工作站、中文输入法）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2026/01/16</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.6 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-132.0.0.17</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-24.03-LTS-SP3/generic.repo">openEuler 24.03 LTS SP3 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://repo.openeuler.org/openEuler-24.03-LTS-SP3/raspi_img/openEuler-24.03-LTS-SP3-raspi-aarch64.img.xz">openEuler 24.03 LTS SP3</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2025/12/31</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>291.5 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-132.0.0.17</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-24.03-LTS-SP3/generic.repo">openEuler 24.03 LTS SP3 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-22.03-LTS-SP4-raspi-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP4 内测版</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/07/06</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>235 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-209.0.0.21</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-22.03-LTS-SP4-UKUI-raspi-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP4 内测版（UKUI 桌面、中文输入法）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/07/06</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.5 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-209.0.0.21</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-22.03-LTS-SP4-DDE-raspi-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP4 内测版（DDE 桌面、中文输入法）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/07/06</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.4 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-209.0.0.21</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-22.03-LTS-SP4-Xfce-raspi-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP4 内测版（Xfce 桌面、中文输入法）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/07/06</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>2.0 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-209.0.0.21</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-22.03-LTS-SP4-UEFI-raspi-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP4 内测版（EFI 引导启动）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/07/06</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>255 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-217.0.0.22</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://repo.openeuler.org/openEuler-22.03-LTS-SP4/raspi_img/openEuler-22.03-LTS-SP4-raspi-aarch64.img.xz">openEuler 22.03 LTS SP4</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/06/29</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>229 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-209.0.0.21</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 源仓库</a></td>
</tr>
</tbody></table>

### 瑞芯微

镜像的基本信息如下所示：

<table><thead align="left"><tr>
<th class="cellrowborder" valign="top" width="10%"><p><strong>镜像版本</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>系统用户（密码）</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>发布时间</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>大小</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>内核版本</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>构建文件系统的源仓库</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>镜像类型</strong></p></th>
</tr></thead>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-20.03-LTS-rk3399-firefly-aarch64-alpha1.img.xz">openEuler 20.03 LTS Firefly-RK3399</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/12/20</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>288 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.90</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo">openEuler 20.03 LTS 源仓库</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>压缩后的 RAW 原始镜像</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-20.03-LTS-rk3399-firefly-aarch64-alpha1.tar.gz">openEuler 20.03 LTS Firefly-RK3399</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/12/20</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>493 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.90</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo">openEuler 20.03 LTS 源仓库</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>打包后的 EMMC 刷写文件</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-20.03-LTS-RockPi-4A-aarch64-alpha1.img.xz">openEuler 20.03 LTS RockPi-4A</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/12/20</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>295 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.90</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo">openEuler 20.03 LTS repository</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>压缩后的 RAW 原始镜像</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-21.09-Firefly-RK3399-aarch64-alpha1.img.xz">openEuler 21.09 Firefly-RK3399</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/12/20</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>420 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-21.09/generic.repo">openEuler 21.09 源仓库</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>压缩后的 RAW 原始镜像</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-21.09-Firefly-RK3399-aarch64-alpha1.tar.gz">openEuler 21.09 Firefly-RK3399</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/12/20</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>717 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-21.09/generic.repo">openEuler 21.09 源仓库</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>打包后的 EMMC 刷写文件</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-21.09-RockPi-4A-aarch64-alpha1.img.xz">openEuler 21.09 RockPi-4A</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/12/20</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>717 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-21.09/generic.repo">openEuler 21.09 源仓库</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>压缩后的 RAW 原始镜像</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3588/openEuler-22.03-LTS-ITX-3588J-aarch64-alpha1.img.xz">openEuler 22.03 Firefly ITX-3588J</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2023/7/11</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>494 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-22.03-LTS/generic.repo">openEuler 22.03 源仓库</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>压缩后的 RAW 原始镜像</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3588/openEuler-22.03-LTS-rk3588-xfce.img.xz">openEuler 22.03 Firefly ITX-3588J + XFCE 桌面</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2023/7/11</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.9 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-22.03-LTS/generic.repo">openEuler 22.03 源仓库</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>压缩后的 RAW 原始镜像</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-22.03-LTS-SP3-Firefly-RK3399-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP3 Firefly-RK3399</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/1/24</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>450 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP3/generic.repo">openEuler 22.03 LTS SP3 源仓库</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>压缩后的 RAW 原始镜像</p></td>
</tr>
</tbody></table>

### 飞腾

<table><thead align="left"><tr>
<th class="cellrowborder" valign="top" width="10%"><p><strong>镜像版本</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>系统用户（密码）</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>发布时间</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>大小</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>内核版本</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>构建文件系统的源仓库</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>镜像类型</strong></p></th>
</tr></thead>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/openeuler-sbc-sig/images/phytium/openEuler-24.03-LTS-SP1-PhytiumPi-4GB-aarch64-alpha2.img.xz">openEuler 24.03 LTS SP1 PhytiumPi 4GB alpha2</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2026/08/11</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>817 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0<br>(phytium-kernel: <a href="https://atomgit.com/openeuler/phytium-kernel/tree/openEuler-24.03-LTS-SP1-update-20260723">openEuler-24.03-LTS-SP1-update-20260723</a>)</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-24.03-LTS-SP1/generic.repo">openEuler 24.03 LTS SP1 源仓库</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>压缩后的 RAW 原始镜像</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/openeuler-sbc-sig/images/phytium/openEuler-22.03-LTS-SP4-PhytiumPi-4GB-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP4 PhytiumPi 4GB</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2026/06/16</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>877 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0<br>(phytium-kernel: <a href="https://atomgit.com/openeuler/phytium-kernel/tree/openEuler-22.03-LTS-SP4-update-20260527">openEuler-22.03-LTS-SP4-update-20260527</a>)</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 源仓库</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>压缩后的 RAW 原始镜像</p></td>
</tr>
</tbody></table>

## 镜像构建

### 准备环境

本仓库的脚本运行环境要求如下：

- 操作系统：openEuler、CentOS 8
- 架构：AArch64，如树莓派、 RK3399 开发板、 RK3588 开发板

其他架构可以使用 [QEMU](https://www.qemu.org/) 模拟器搭建 AArch64 运行环境。

### 构建镜像
镜像构建使用统一入口 [build.sh](./scripts/build.sh) 或 [build-image-docker.sh](./scripts/build-image-docker.sh) 在宿主机或者启动 Docker 容器构建树莓派或瑞芯微等开发板镜像。
具体参考以下文档：
- [树莓派镜像构建](./documents/RaspberryPi.md#构建镜像)
- [瑞芯微等开发板镜像构建](./documents/Rockchip.md#镜像构建)

#### 宿主机上构建镜像

构建镜像需执行命令：

`sudo bash build.sh --board BOARD_CONFIG -n NAME -k KERNEL_URL -b KERNEL_BRANCH -c KERNEL_DEFCONFIG -r REPO_INFO -s SPEC --cores N`

脚本运行结束后，会提示镜像的存储位置，镜像默认保存在脚本运行所在目录的 build/YYYY-MM-DD/ 下。

**说明: 基于 build.sh 提供的默认参数，执行 sudo bash build.sh 可构建 Firefly-RK3399 的 openEuler-20.03-LTS 镜像。**

**参数意义**

1.  --board BOARD_CONFIG

    适用的开发板的版型配置文件在 [boards](scripts/boards) 文件夹中，示例文件 [sample.conf](scripts/boards/sample.conf)，默认为 `firefly-rk3399`。

    其包括的配置参数意义如下：

    - platform=PLATFORM

        开发板所使用的平台，目前支持的平台有：broadcom、rockchip、phytium、amlogic，默认为 `rockchip`。

    - device-tree=DTB_NAME

        内核设备树中的设备名称，和开发板名称有一点区别，对应 [kernel/arch/arm64/boot/dts/rockchip](https://atomgit.com/openeuler/kernel/tree/master/arch/arm64/boot/dts/rockchip) 下的 `DTB_NAME.dts` 文件，默认为 `rk3399-firefly`。

    - ubootconfig=UBOOT_DEFCONFIG

        开发板对应的 defconfig 的文件名称，对应 [u-boot/configs](https://github.com/u-boot/u-boot/tree/master/configs) 下 `UBOOT_DEFCONFIG` 文件，默认为 `firefly-rk3399_defconfig`；如需在 RK3588 开发板上使用预编译的 u-boot，可以将此项设置为空：`ubootconfig=`。

2.  -n, --name IMAGE_NAME

    构建的镜像名称，例如：`openEuler-20.03-LTS-Firefly-RK3399-aarch64-alpha1` 或 `openEuler-24.03-LTS-raspi-aarch64-alpha1`。

3.  -k, --kernel KERNEL_URL

    内核源码仓库的项目地址，默认为 `https://atomgit.com/openeuler/rockchip-kernel.git`。可根据需要设置为 `git@atomgit.com:openeuler/rockchip-kernel.git` 或 `git@atomgit.com:openeuler/kernel.git`。

4.  -b, --branch KERNEL_BRANCH

    内核源码的对应分支，默认为 openEuler-20.03-LTS。

5.  -c, --config KERNEL_DEFCONFIG

    内核编译使用的配置文件名称或路径，默认为 `openeuler_rockchip_defconfig`。如果该参数为配置文件名称，请确保该文件在内核源码的目录 `arch/arm64/configs` 或构建框架的 [scripts/configs/common](./scripts/configs/common/) 下。

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
    - `ukui`，带 UKUI 桌面以及中文字体、输入法等全部配套软件。
    - `dde`，带 DDE 桌面以及中文字体、输入法等全部配套软件。
    - `gnome`，带 GNOME 桌面以及中文字体、输入法等全部配套软件。
    - `devstation`，带 GNOME 桌面、中文字体、输入法、大量开发工具和 IDE 等配套软件。
    -  rpmlist 文件路径，其中包含镜像中要安装的软件列表，内容参考 [rpmlist](../scripts/configs/common/rpmlist)。

    默认使用 `headless` 选项。

8.  --cores N

    并行编译的数量，根据运行脚本的宿主机 CPU 实际数目设定，默认为可用的 CPU 总数。

9.  -h, --help

    显示帮助信息。

#### Docker 容器内构建镜像
构建镜像需执行命令：

`sudo bash build-image-docker.sh -d DOCKER_FILE --board BOARD_CONFIG -n NAME -k KERNEL_URL -b KERNEL_BRANCH -c KERNEL_DEFCONFIG -r REPO_INFO -s SPEC --cores N`

脚本运行结束后，会提示镜像的存储位置，镜像默认保存在脚本运行所在目录的 `build/YYYY-MM-DD/` 下。

注意！！！运行该脚本前，需安装 Docker 运行环境。该脚本会自动将 `-d DOCKER_FILE` 参数对应的 Docker 镜像导入本机系统中。

除参数 `-d DOCKER_FILE` 外，其余参数与 [宿主机上构建镜像](#宿主机上构建镜像) 中 [build.sh](scripts/build.sh) 对应参数一致：

1.  -d, --docker DOCKER_FILE

    Docker 镜像的 URL 或者路径， 默认为 `https://repo.openeuler.org/openEuler-20.03-LTS-SP1/docker_img/aarch64/openEuler-docker.aarch64.tar.xz`。使用该默认参数时，脚本会自动下载 openEuler 20.03 LTS SP1 的 Docker 镜像，并导入本机系统中。
