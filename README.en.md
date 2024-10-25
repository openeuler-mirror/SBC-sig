# SBC-sig

English | [简体中文](./README.md)

This repository is the main repository of the openEuler SBC (Single-Board Computer) SIG. It provides information related to SBC SIG, build scripts and documentation for openEuler images suitable for development boards such as [Raspberry Pi](https://gitee.com/openeuler/raspberrypi-kernel), [Rockchip](https://gitee.com/openeuler/rockchip-kernel) and [Allwinner](https://gitee.com/openeuler/allwinner-kernel).

<!-- TOC -->

- [SBC-sig](#sbc-sig)
    - [To Do List](#to-do-list)
    - [How to collaborate](#how-to-collaborate)
    - [File description](#file-description)
    - [How to download latest image](#how-to-download-latest-image)
        - [Raspberry Pi](#raspberry-pi)
        - [Rockchip](#rockchip)

<!-- /TOC -->

## To Do List
1. Raspberry Pi
   1. [Migrate openEuler to Raspberry Pi CM4](https://gitee.com/openeuler/raspberrypi/issues/I5CHSV)
2. Rockchip
   1. [Migrate openEuler 22.09 to RK3399 SoCs](https://gitee.com/openeuler/rockchip/issues/I5CHNJ)
   2. [Migrate openEuler 22.03 LTS (Next) to Rockchip SoCs](https://gitee.com/openeuler/rockchip/issues/I5CHO9)
   3. [Migrate openEuler 22.03 LTS (Next) to ITX-3588J SoCs](https://gitee.com/openeuler/rockchip-kernel/issues/I5XTK1)
3. Allwinner
   1. [Migrate openEuler 5.10 kernel to Allwinner SoCs](https://gitee.com/openeuler/allwinner-kernel/issues/I5CHOF)

## How to collaborate

You can get introduction of openEuler SBC SIG from [sig-SBC](https://gitee.com/openeuler/community/tree/master/sig/sig-SBC).

- Issues: welcome to collaborate with us by creating new issues or reply opened issues. You can get repository list from [sig-SBC](https://gitee.com/openeuler/community/tree/master/sig/sig-SBC).
- Join Slack workspace: [openeuler-sbc](https://openeuler-sbc.slack.com)
  - [Invite link](https://join.slack.com/t/openeuler-sbc/shared_invite/zt-uh95ug4n-yX7a~c7VrTEU64tZlX3Djw)
- Weekly meeting schedule
  - Meeting Time: The 1st and 3rd Wednesday of each month, 17:00 - 17:30 UTC+8.
  - Meeting Link: There are two methods to get the meeting link which will be updated before each meeting.
    - Log in to the [openEuler Community](https://openeuler.org/) website, then view the booking information of `sig-SBC例会` in the meeting calendar.
    - Search `openEuler` in mini programs of WeChat, add `OpenAtom openEuler mini program`. Then click `会议` and view the booking information of `sig-SBC例会`.
  - [Meeting Agenda](https://etherpad.openeuler.org/p/sig-SBC-meetings)
  - [Meeting Minutes](https://gitee.com/openeuler/SBC-sig/issues/IB2WFJ)
- Warmly welcome to submit Pull Requests.

## File description

>![](documents/public_sys-resources/icon-note.gif) **NOTE: **   
>- Recommendation: use the latest images provided in the chapter [How to download latest image](#how-to-download-latest-image) of this documentation.

- [documents](./documents/):
  - [Raspberry Pi](documents/树莓派.md)
    - [Getting started with Raspberry Pi](documents/树莓派.md)
    - [Install openEuler on an SD card](documents/raspberrypi/刷写镜像.md)
    - [How to use Raspberry Pi](documents/raspberrypi/树莓派使用.md)
    - [Building openEuler image for Raspberry Pi](documents/raspberrypi/openEuler镜像的构建.md)
    - [Cross-compile the kernel](documents/raspberrypi/交叉编译内核.md)
    - [Emulate Raspberry Pi with QEMU](documents/raspberrypi/QEMU启动树莓派.md)
  - [Rockchip and other SoCs](documents/瑞芯微等开发板.md)  
    - [Getting started with Rockchip and other SoCs](documents/瑞芯微等开发板.md)
    - [Building openEuler image for Rockchip development boards](documents/rockchip/openEuler镜像的构建.md)
    - [Install an Image on an EMMC](documents/rockchip/刷写EMMC镜像.md)
    - [Build images sequentially](documents/rockchip/顺序构建.md)
    - [Compile the kernel of Firefly-RK3399 based on the Firefly SDK](documents/rockchip/基于Firefly-SDK编译Firefly-RK3399的内核镜像.md)
    - [Packaging ITX-RK3588J Integrated Burn Write Image](documents/rockchip/打包ITX-RK3588J一体化烧写镜像.md)
    - [Set up SELinux](documents/rockchip/设置SELinux.md)
    - [Build an image using Docker](documents/rockchip/使用Docker构建镜像.md)
- [scripts](./scripts/):
  - [Raspberry Pi](./scripts/raspberrypi): Script for building openEuler image for Raspberry Pi
    - [Quickly Build (without kernel compilation)](scripts/raspberrypi/build-image.sh)
    - [Build on host (with kernel compilation)](scripts/raspberrypi/build-image-common.sh)
    - [Build in a Docker container (with kernel compilation)](scripts/raspberrypi/build-image-docker.sh)
  - [Rockchip and other SoCs](./scripts/rockchip): Used to build openEuler images for Rockchip and other SoCs
    - [One-time build images](scripts/rockchip/build.sh)
    - [Build a boot Image](scripts/rockchip/build_boot.sh)
    - [Build a rootfs Image](scripts/rockchip/build_rootfs.sh)
    - [Compile u-boot](scripts/rockchip/build_u-boot.sh)
    - [Generate a bootable image](scripts/rockchip/gen_image.sh)

## How to download latest image

### Raspberry Pi

Basic information of the images for Raspberry Pi is as follows. [more images](documents/images.en.md)

<table><thead align="left"><tr>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Version</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>System user(password)</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Release date</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Size</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Kernel version</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Repository of rootfs</strong></p></th>
</tr></thead>
<tbody>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.09-raspi-aarch64-alpha1.img.xz">openEuler 24.09 alpha1</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/10/14</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>271 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-45.0.0.9</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-24.09/generic.repo">openEuler 24.09 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.09-UKUI-raspi-aarch64-alpha1.img.xz">openEuler 24.09 alpha1 (UKUI desktop and Chinese input method)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/10/14</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.6 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-45.0.0.9</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-24.09/generic.repo">openEuler 24.09 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.09-DDE-raspi-aarch64-alpha1.img.xz">openEuler 24.09 alpha1 (DDE desktop and Chinese input method)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/10/14</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.7 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-45.0.0.9</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-24.09/generic.repo">openEuler 24.09 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.09-Xfce-raspi-aarch64-alpha1.img.xz">openEuler 24.09 alpha1 (Xfce desktop and Chinese input method)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/10/14</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>2.2 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-45.0.0.9</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-24.09/generic.repo">openEuler 24.09 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.09-UEFI-raspi-aarch64-alpha1.img.xz">openEuler 24.09 alpha1 (EFI boot)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/10/14</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>298 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-46.0.0.10</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-24.09/generic.repo">openEuler 24.09 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://repo.openeuler.org/openEuler-24.09/raspi_img/openEuler-24.09-raspi-aarch64.img.xz">openEuler 24.09</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/09/29</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>268 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-45.0.0.9</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-24.09/generic.repo">openEuler 24.09 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-22.03-LTS-SP4-raspi-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP4 alpha1</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/07/06</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>235 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-209.0.0.21</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-22.03-LTS-SP4-UKUI-raspi-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP4 alpha1 (UKUI desktop and Chinese input method)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/07/06</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.5 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-209.0.0.21</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-22.03-LTS-SP4-DDE-raspi-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP4 alpha1 (DDE desktop and Chinese input method)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/07/06</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.4 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-209.0.0.21</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-22.03-LTS-SP4-Xfce-raspi-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP4 alpha1 (Xfce desktop and Chinese input method)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/07/06</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>2.0 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-209.0.0.21</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-22.03-LTS-SP4-UEFI-raspi-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP4 alpha1 (EFI boot)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/07/06</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>255 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-217.0.0.22</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://repo.openeuler.org/openEuler-22.03-LTS-SP4/raspi_img/openEuler-22.03-LTS-SP4-raspi-aarch64.img.xz">openEuler 22.03 LTS SP4</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/06/29</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>229 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-209.0.0.21</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.03-LTS-raspi-aarch64-alpha1.img.xz">openEuler 24.03 LTS alpha1</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/06/24</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>214 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-26.0.0.4</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-24.03-LTS/generic.repo">openEuler 24.03 LTS repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.03-LTS-UKUI-raspi-aarch64-alpha1.img.xz">openEuler 24.03 LTS alpha1 (UKUI desktop and Chinese input method)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/06/24</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.6 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-26.0.0.4</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-24.03-LTS/generic.repo">openEuler 24.03 LTS repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.03-LTS-DDE-raspi-aarch64-alpha1.img.xz">openEuler 24.03 LTS alpha1 (DDE desktop and Chinese input method)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/06/24</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.7 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-26.0.0.4</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-24.03-LTS/generic.repo">openEuler 24.03 LTS repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.03-LTS-Xfce-raspi-aarch64-alpha1.img.xz">openEuler 24.03 LTS alpha1 (Xfce desktop and Chinese input method)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/06/24</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>2.2 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-26.0.0.4</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-24.03-LTS/generic.repo">openEuler 24.03 LTS repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.03-LTS-UEFI-raspi-aarch64-alpha1.img.xz">openEuler 24.03 LTS alpha1 (EFI boot)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/06/24</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>330 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-30.0.0.6</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-24.03-LTS/generic.repo">openEuler 24.03 LTS repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://repo.openeuler.org/openEuler-24.03-LTS/raspi_img/openEuler-24.03-LTS-raspi-aarch64.img.xz">openEuler 24.03 LTS</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/06/04</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>244 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-26.0.0.4</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-24.03-LTS/generic.repo">openEuler 24.03 LTS repository</a></td>
</tr>
</tbody></table>

### Rockchip

Basic information of the image is as follows:

<table><thead align="left"><tr>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Version</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>System User (Password)</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Release Date</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Size</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Kernel Version</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Repository of rootfs</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Image type</strong></p></th>
</tr></thead>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-20.03-LTS-rk3399-firefly-aarch64-alpha1.img.xz">openEuler 20.03 LTS Firefly-RK3399</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/12/20</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>288 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.90</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo">openEuler 20.03 LTS repository</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>A compressed RAW original image</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-20.03-LTS-rk3399-firefly-aarch64-alpha1.tar.gz">openEuler 20.03 LTS Firefly-RK3399</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/12/20</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>493 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.90</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo">openEuler 20.03 LTS repository</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>A compressed image for the EMMC</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-20.03-LTS-RockPi-4A-aarch64-alpha1.img.xz">openEuler 20.03 LTS RockPi-4A</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/12/20</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>295 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.90</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo">openEuler 20.03 LTS repository</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>A compressed RAW original image</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-21.09-Firefly-RK3399-aarch64-alpha1.img.xz">openEuler 21.09 Firefly-RK3399</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/12/20</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>420 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-21.09/generic.repo">openEuler 21.09 repository</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>A compressed RAW original image</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-21.09-Firefly-RK3399-aarch64-alpha1.tar.gz">openEuler 21.09 Firefly-RK3399</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/12/20</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>717 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-21.09/generic.repo">openEuler 21.09 repository</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>A compressed image for the EMMC</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-21.09-RockPi-4A-aarch64-alpha1.img.xz">openEuler 21.09 RockPi-4A</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/12/20</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>717 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-21.09/generic.repo">openEuler 21.09 repository</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>A compressed RAW original image</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3588/openEuler-22.03-LTS-ITX-3588J-aarch64-alpha1.img.xz">openEuler 22.03 Firefly ITX-3588J</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2023/7/11</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>494 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/raw/openEuler-22.03-LTS/generic.repo">openEuler 22.03 repository</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>A compressed RAW original image</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3588/openEuler-22.03-LTS-rk3588-xfce.img.xz">openEuler 22.03 Firefly ITX-3588J + XFCE</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2023/7/11</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.9 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/raw/openEuler-22.03-LTS/generic.repo">openEuler 22.03 repository</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>A compressed RAW original image</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-22.03-LTS-SP3-Firefly-RK3399-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP3 Firefly-RK3399</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/1/23</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>450 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP3/generic.repo">openEuler 22.03 LTS SP3 repository</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>A compressed RAW original image</p></td>
</tr>
</tbody></table>