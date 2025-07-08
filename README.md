# SBC-sig

[English](./README.en.md) | 简体中文

本仓库是 openEuler 社区 SBC (Single-Board Computer) SIG 组的主仓库，提供 SIG 组相关信息以及适用于[树莓派](https://gitee.com/openeuler/raspberrypi-kernel)、[Rockchip](https://gitee.com/openeuler/rockchip-kernel)、[全志](https://gitee.com/openeuler/allwinner-kernel)等开发板的 openEuler 镜像的构建脚本和相关文档。

<!-- TOC -->

- [SBC-sig](#sbc-sig)
    - [To Do List](#to-do-list)
    - [如何参与 SIG 组](#如何参与-sig-组)
    - [文件说明](#文件说明)
    - [最新镜像](#最新镜像)
        - [树莓派](#树莓派)
        - [瑞芯微等其他开发板](#瑞芯微等其他开发板)
    - [镜像构建](#镜像构建)
        - [准备环境](#准备环境)
        - [构建镜像](#构建镜像)

<!-- /TOC -->
## To Do List

1. 树莓派
   1. [树莓派 CM4 核心板适配、测试](https://gitee.com/openeuler/raspberrypi/issues/I5CHSV)
2. Rockchip
   1. [openEuler 22.09 适配到 RK3399](https://gitee.com/openeuler/rockchip/issues/I5CHNJ)
   2. [openEuler 22.03 LTS (Next) 适配到 Rockchip 开发板](https://gitee.com/openeuler/rockchip/issues/I5CHO9)
   3. [openEuler 22.03 LTS (Next) 适配到 ITX-3588J 开发板](https://gitee.com/openeuler/rockchip-kernel/issues/I5XTK1)
3. 全志
   1. [openEuler 5.10 内核适配到全志开发板](https://gitee.com/openeuler/allwinner-kernel/issues/I5CHOF)

## 如何参与 SIG 组

SIG 组基本信息位于 [sig-SBC](https://gitee.com/openeuler/community/tree/master/sig/sig-SBC)。

- 建立或回复 issue：欢迎通过建立或回复 issue 来讨论，此 SIG 组维护的仓库列表可在 [sig-SBC](https://gitee.com/openeuler/community/tree/master/sig/sig-SBC) 中查看。
- 加入 Slack 群组：[openeuler-sbc](https://openeuler-sbc.slack.com)
  - [加入群组链接](https://join.slack.com/t/openeuler-sbc/shared_invite/zt-uh95ug4n-yX7a~c7VrTEU64tZlX3Djw)
- SIG 组会议：每个月的第一个和第三个周三下午 17:00 - 17:30 会进行一次讨论会议
  - 会议链接：有以下两种获取方式
    - [openEuler 社区网站](https://openeuler.org/)下的会议日历中查看 `sig-SBC例会` 预定信息。
    - 微信小程序搜索 `openEuler`，添加 `OpenAtom openEuler` 小程序，可在其`会议`栏目查看 `sig-SBC例会` 预定信息。
  - [会议议题](https://etherpad.openeuler.org/p/sig-SBC-meetings)：每次会议前填写要讨论的议题，我们也会从 issue 列表中提取本周讨论的内容。
  - [会议记录](https://gitee.com/openeuler/SBC-sig/issues/IB2WFJ)：每次会议结束后会议结论会更新在此 issue 中。
- 重要的事说三遍：**欢迎提交 PR！欢迎提交 PR！欢迎提交 PR！**

## 文件说明

>![](documents/public_sys-resources/icon-note.gif) **说明：**   
>- 建议直接使用本文档 [最新镜像](#最新镜像) 章节中给出的 openEuler 的树莓派/RK3399等镜像。

- [documents](./documents/): 使用文档
  - [树莓派](documents/树莓派.md)
    - [树莓派快速入门](documents/树莓派.md)
    - [刷写镜像](documents/raspberrypi/刷写镜像.md)
    - [树莓派使用](documents/raspberrypi/树莓派使用.md)
    - [openEuler 镜像的构建](documents/raspberrypi/openEuler镜像的构建.md)
    - [交叉编译内核](documents/raspberrypi/交叉编译内核.md)
    - [QEMU 启动树莓派](documents/raspberrypi/QEMU启动树莓派.md)
  - [瑞芯微等其他开发板](documents/瑞芯微等开发板.md)
    - [瑞芯微等快速入门](documents/瑞芯微等开发板.md)
    - [openEuler镜像的构建](documents/rockchip/openEuler镜像的构建.md)
    - [刷写EMMC镜像](documents/rockchip/刷写EMMC镜像.md)
    - [顺序构建](documents/rockchip/顺序构建.md)
    - [基于Firefly-SDK编译Firefly-RK3399的内核镜像](documents/rockchip/基于Firefly-SDK编译Firefly-RK3399的内核镜像.md)
    - [打包 ITX-RK3588J 一体化烧写镜像](documents/rockchip/打包ITX-RK3588J一体化烧写镜像.md)
    - [设置 SELinux](documents/rockchip/设置SELinux.md)
    - [使用 Docker 构建镜像](documents/rockchip/使用Docker构建镜像.md)
- [scripts](./scripts/): 镜像构建脚本
    - [树莓派](./scripts/raspberrypi): 构建 openEuler 树莓派镜像的脚本
      - [快速构建（不编译内核）](scripts/raspberrypi/build-image.sh)
      - [主机上构建（编译内核）](scripts/raspberrypi/build-image-common.sh)
      - [Docker 容器中构建（编译内核）](scripts/raspberrypi/build-image-docker.sh)
    - [瑞芯微等开发板](./scripts/rockchip): 构建 openEuler RK3399 等开发板镜像的脚本
      - [一次构建脚本](scripts/rockchip/build.sh)
      - [boot 镜像构建脚本](scripts/build_boot.sh)
      - [rootfs 镜像构建脚本](scripts/build_rootfs.sh)
      - [u-boot 编译脚本](scripts/rockchip/build_u-boot.sh)
      - [可启动镜像生成脚本](scripts/rockchip/gen_image.sh)

## 最新镜像

### 树莓派

>![](./documents/public_sys-resources/icon-notice.gif) **须知：**   
>当前只有 openEuler 24.03 LTS SP1/25.03/24.03 LTS SP2 版本的树莓派镜像同时支持树莓派 5 和树莓派 3B/3B+/4B/400，其他版本的树莓派镜像只支持树莓派 3B/3B+/4B/400。

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
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.03-LTS-SP2-raspi-aarch64-alpha1.img.xz">openEuler 24.03 LTS SP2 内测版</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2025/07/08</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>295 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-98.0.0.15</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-24.03-LTS-SP2/generic.repo">openEuler 24.03 LTS SP2 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.03-LTS-SP2-UKUI-raspi-aarch64-alpha1.img.xz">openEuler 24.03 LTS SP2 内测版（UKUI 桌面、中文输入法）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2025/07/08</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.6 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-98.0.0.15</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-24.03-LTS-SP2/generic.repo">openEuler 24.03 LTS SP2 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.03-LTS-SP2-DDE-raspi-aarch64-alpha1.img.xz">openEuler 24.03 LTS SP2 内测版（DDE 桌面、中文输入法）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2025/07/08</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.8 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-98.0.0.15</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-24.03-LTS-SP2/generic.repo">openEuler 24.03 LTS SP2 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.03-LTS-SP2-GNOME-raspi-aarch64-alpha1.img.xz">openEuler 24.03 LTS SP2 内测版（GNOME 桌面、中文输入法）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2025/07/08</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>2.5 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-98.0.0.15</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-24.03-LTS-SP2/generic.repo">openEuler 24.03 LTS SP2 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.03-LTS-SP2-DevStation-raspi-aarch64-alpha1.img.xz">openEuler 24.03 LTS SP2 内测版（DevStation 开发者工作站、中文输入法）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2025/07/08</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.3 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-98.0.0.15</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-24.03-LTS-SP2/generic.repo">openEuler 24.03 LTS SP2 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP2/raspi_img/openEuler-24.03-LTS-SP2-raspi-aarch64.img.xz">openEuler 24.03 LTS SP2</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2025/06/26</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>291.6 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-98.0.0.15</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-24.03-LTS-SP2/generic.repo">openEuler 24.03 LTS SP2 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-22.03-LTS-SP4-raspi-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP4 内测版</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/07/06</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>235 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-209.0.0.21</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-22.03-LTS-SP4-UKUI-raspi-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP4 内测版（UKUI 桌面、中文输入法）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/07/06</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.5 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-209.0.0.21</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-22.03-LTS-SP4-DDE-raspi-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP4 内测版（DDE 桌面、中文输入法）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/07/06</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.4 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-209.0.0.21</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-22.03-LTS-SP4-Xfce-raspi-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP4 内测版（Xfce 桌面、中文输入法）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/07/06</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>2.0 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-209.0.0.21</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-22.03-LTS-SP4-UEFI-raspi-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP4 内测版（EFI 引导启动）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/07/06</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>255 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-217.0.0.22</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://repo.openeuler.org/openEuler-22.03-LTS-SP4/raspi_img/openEuler-22.03-LTS-SP4-raspi-aarch64.img.xz">openEuler 22.03 LTS SP4</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/06/29</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>229 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-209.0.0.21</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 源仓库</a></td>
</tr>
</tbody></table>

### 瑞芯微等其他开发板

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
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo">openEuler 20.03 LTS 源仓库</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>压缩后的 RAW 原始镜像</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-20.03-LTS-rk3399-firefly-aarch64-alpha1.tar.gz">openEuler 20.03 LTS Firefly-RK3399</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/12/20</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>493 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.90</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo">openEuler 20.03 LTS 源仓库</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>打包后的 EMMC 刷写文件</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-20.03-LTS-RockPi-4A-aarch64-alpha1.img.xz">openEuler 20.03 LTS RockPi-4A</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/12/20</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>295 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.90</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo">openEuler 20.03 LTS repository</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>压缩后的 RAW 原始镜像</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-21.09-Firefly-RK3399-aarch64-alpha1.img.xz">openEuler 21.09 Firefly-RK3399</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/12/20</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>420 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-21.09/generic.repo">openEuler 21.09 源仓库</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>压缩后的 RAW 原始镜像</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-21.09-Firefly-RK3399-aarch64-alpha1.tar.gz">openEuler 21.09 Firefly-RK3399</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/12/20</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>717 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-21.09/generic.repo">openEuler 21.09 源仓库</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>打包后的 EMMC 刷写文件</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-21.09-RockPi-4A-aarch64-alpha1.img.xz">openEuler 21.09 RockPi-4A</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/12/20</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>717 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-21.09/generic.repo">openEuler 21.09 源仓库</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>压缩后的 RAW 原始镜像</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3588/openEuler-22.03-LTS-ITX-3588J-aarch64-alpha1.img.xz">openEuler 22.03 Firefly ITX-3588J</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2023/7/11</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>494 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/raw/openEuler-22.03-LTS/generic.repo">openEuler 22.03 源仓库</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>压缩后的 RAW 原始镜像</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3588/openEuler-22.03-LTS-rk3588-xfce.img.xz">openEuler 22.03 Firefly ITX-3588J + XFCE 桌面</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2023/7/11</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.9 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/raw/openEuler-22.03-LTS/generic.repo">openEuler 22.03 源仓库</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>压缩后的 RAW 原始镜像</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-22.03-LTS-SP3-Firefly-RK3399-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP3 Firefly-RK3399</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/1/24</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>450 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP3/generic.repo">openEuler 22.03 LTS SP3 源仓库</a></td>
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

可以使用树莓派或瑞芯微等开发板各自的脚本构建镜像，具体文档参考：
- [树莓派镜像构建](./documents/树莓派.md#构建镜像)
- [瑞芯微等开发板镜像构建](./documents/瑞芯微等开发板.md#镜像构建)

也可以使用统一入口 [build.sh](./scripts/build.sh) 构建树莓派或瑞芯微等开发板镜像，执行命令：

`sudo bash scripts/build.sh --board BOARD_TYPE --in-docker [other_args...]`

各个参数含义：

1. --in-docker
   使用 Docker 容器构建镜像，参考链接：
   - [使用 Docker 容器构建树莓派镜像](./documents/树莓派.md#docker-容器内构建)
   - [使用 Docker 容器构建瑞芯微等开发板镜像](./documents/瑞芯微等开发板.md#docker-容器内构建)

2. --board BOARD_TYPE
   开发板类型和构建方式。当前支持的参数有：
   - rpi，无需编译内核直接构建树莓派镜像，其他参数请参考 [无需编译内核快速构建树莓派镜像](./documents/树莓派.md#快速构建无需编译内核推荐)。
   - rpi-custom，编译内核并构建树莓派镜像，其他参数请参考 [编译内核构建树莓派镜像](./documents/树莓派.md#完全构建包括编译内核)。
   - firefly-itx-3588j，构建 Firefly ITX-3588J 开发板镜像，其他参数请参考 [构建瑞芯微等开发板镜像](./documents/瑞芯微等开发板.md#一次构建)。
   - firefly-rk3399，构建 Firefly RK3399 开发板镜像，其他参数请参考 [构建瑞芯微等开发板镜像](./documents/瑞芯微等开发板.md#一次构建)。
   - firefly-roc-rk3566-pc，构建 Firefly ROC-RK3566-PC 开发板镜像，其他参数请参考 [构建瑞芯微等开发板镜像](./documents/瑞芯微等开发板.md#一次构建)。
   - firefly-roc-rk3568-pc，构建 Firefly ROC-RK3568-PC 开发板镜像，其他参数请参考 [构建瑞芯微等开发板镜像](./documents/瑞芯微等开发板.md#一次构建)。
   - firefly-roc-rk3568-pc-se，构建 Firefly ROC-RK3568-PC-SE 开发板镜像，其他参数请参考 [构建瑞芯微等开发板镜像](./documents/瑞芯微等开发板.md#一次构建)。
   - firefly-roc-rk3588s-pc，构建 Firefly ROC-RK3588S-PC 开发板镜像，其他参数请参考 [构建瑞芯微等开发板镜像](./documents/瑞芯微等开发板.md#一次构建)。
   - phytiumpi-4gb，构建 Phytium Pi 4GB 开发板镜像，其他参数请参考 [构建瑞芯微等开发板镜像](./documents/瑞芯微等开发板.md#一次构建)。
   - radxa-rock5b，构建 Radxa Rock-5B 开发板镜像，其他参数请参考 [构建瑞芯微等开发板镜像](./documents/瑞芯微等开发板.md#一次构建)。
   - radxa-rockpi-4a，构建 Radxa RockPi-4A 开发板镜像，其他参数请参考 [构建瑞芯微等开发板镜像](./documents/瑞芯微等开发板.md#一次构建)。
   - orangepi-zero2，构建 Orange Pi Zero2 开发板镜像，其他参数请参考 [构建瑞芯微等开发板镜像](./documents/瑞芯微等开发板.md#一次构建)。
   - longanpi-3h，构建 Sipeed Longan Pi 3H 开发板镜像，其他参数请参考 [构建瑞芯微等开发板镜像](./documents/瑞芯微等开发板.md#一次构建)。

3. -h, --help
   显示帮助信息。
