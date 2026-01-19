# SBC-sig

English | [简体中文](./README.md)

This repository is the main repository of the openEuler SBC (Single-Board Computer) SIG. It provides information related to SBC SIG, build scripts and documentation for openEuler images suitable for development boards such as [Raspberry Pi](https://www.raspberrypi.org/), [Rockchip](https://www.rock-chips.com/), [Allwinner](https://www.allwinnertech.com/) and [Amlogic](https://www.amlogic.cn/).

<!-- TOC -->

- [SBC-sig](#sbc-sig)
    - [To Do List](#to-do-list)
    - [How to collaborate](#how-to-collaborate)
    - [File description](#file-description)
    - [How to download latest image](#how-to-download-latest-image)
        - [Raspberry Pi](#raspberry-pi)
        - [Rockchip](#rockchip)
    - [How to build image](#how-to-build-image)
        - [Prepare the environment](#prepare-the-environment)
        - [Run the scripts to build image](#run-the-scripts-to-build-image)
            - [Build on host](#build-on-host)
            - [Build in a Docker container](#build-in-a-docker-container)

<!-- /TOC -->

## To Do List
1. Raspberry Pi
   1. [Migrate openEuler to Raspberry Pi CM4](https://atomgit.com/openeuler/raspberrypi/issues/119)
2. Rockchip
   1. [Migrate openEuler 22.09 to RK3399 SoCs](https://atomgit.com/openeuler/rockchip/issues/5)
   2. [Migrate openEuler 22.03 LTS (Next) to Rockchip SoCs](https://atomgit.com/openeuler/rockchip/issues/20)
   3. [Migrate openEuler 22.03 LTS (Next) to ITX-3588J SoCs](https://atomgit.com/openeuler/rockchip-kernel/issues/6)
3. Allwinner
   1. [Migrate openEuler 5.10 kernel to Allwinner SoCs](https://atomgit.com/openeuler/allwinner-kernel/issues/1)

## How to collaborate

You can get introduction of openEuler SBC SIG from [sig-SBC](https://atomgit.com/openeuler/community/tree/master/sig/sig-SBC).

- Issues: welcome to collaborate with us by creating new issues or reply opened issues. You can get repository list from [sig-SBC](https://atomgit.com/openeuler/community/tree/master/sig/sig-SBC).
- Join Slack workspace: [openeuler-sbc](https://openeuler-sbc.slack.com)
  - [Invite link](https://join.slack.com/t/openeuler-sbc/shared_invite/zt-uh95ug4n-yX7a~c7VrTEU64tZlX3Djw)
- Weekly meeting schedule
  - Meeting Time: The 1st and 3rd Wednesday of each month, 17:00 - 17:30 UTC+8.
  - Meeting Link: There are two methods to get the meeting link which will be updated before each meeting.
    - Log in to the [openEuler Community](https://openeuler.org/) website, then view the booking information of `sig-SBC例会` in the meeting calendar.
    - Search `openEuler` in mini programs of WeChat, add `OpenAtom openEuler mini program`. Then click `会议` and view the booking information of `sig-SBC例会`.
  - [Meeting Agenda](https://etherpad.openeuler.org/p/sig-SBC-meetings)
  - [Meeting Minutes](https://atomgit.com/openeuler/SBC-sig/issues/5)
- Warmly welcome to submit Pull Requests.

## File description

>![](documents/public_sys-resources/icon-note.gif) **NOTE: **   
>- Recommendation: use the latest images provided in the chapter [How to download latest image](#how-to-download-latest-image) of this documentation.

- [documents](./documents/):
  - [How to contribute](documents/CONTRIBUTING.md)
  - [Compatibility List](documents/compatibility-list.en.md)
  - [Raspberry Pi](documents/RaspberryPi.md)
    - [Getting started with Raspberry Pi](documents/RaspberryPi.md)
    - [Install openEuler on an SD card](documents/raspberrypi/刷写镜像.md)
    - [How to use Raspberry Pi](documents/raspberrypi/树莓派使用.md)
    - [Building openEuler image for Raspberry Pi](documents/raspberrypi/openEuler镜像的构建.md)
    - [Cross-compile the kernel](documents/raspberrypi/交叉编译内核.md)
    - [Emulate Raspberry Pi with QEMU](documents/raspberrypi/QEMU启动树莓派.md)
    - [Hailo AI](documents/raspberrypi/HailoAI.md)
  - [Rockchip and other SoCs](documents/Rockchip.md)
    - [Getting started with Rockchip and other SoCs](documents/Rockchip.md)
    - [Building openEuler image for Rockchip development boards](documents/rockchip/openEuler镜像的构建.md)
    - [Install an Image on an EMMC](documents/rockchip/刷写EMMC镜像.md)
    - [Build images sequentially](documents/rockchip/顺序构建.md)
    - [Compile the kernel of Firefly-RK3399 based on the Firefly SDK](documents/rockchip/基于Firefly-SDK编译Firefly-RK3399的内核镜像.md)
    - [Packaging ITX-RK3588J Integrated Burn Write Image](documents/rockchip/打包ITX-RK3588J一体化烧写镜像.md)
    - [Set up SELinux](documents/rockchip/设置SELinux.md)
    - [Build an image using Docker](documents/rockchip/使用Docker构建镜像.md)
    - [openEuler Adaptation Guide](documents/rockchip/openEuler适配指南.md)
    - [Using RKNPU on openEuler](documents/rockchip/在openEuler上使用RKNPU.md)
    - [Run RKLLM on openEuler](documents/rockchip/在openEuler上运行RKLLM.md)
- [scripts](./scripts/): Script for building openEuler image
    - [Build a unified system image](scripts/build.sh)
    - [Build a unified system image using Docker](./scripts/build-image-docker.sh)
    - [Build a boot Image](scripts/build_boot.sh)
    - [Build a rootfs Image](scripts/build_rootfs.sh)
    - [Compile u-boot](scripts/build_u-boot.sh)
    - [Generate a bootable image](scripts/gen_image.sh)

## How to download latest image

### Raspberry Pi

>![](documents/public_sys-resources/icon-notice.gif) **Note:**   
>Currently, only the openEuler 24.03 LTS SP1/25.03/24.03 LTS SP2/25.09/24.03 LTS SP3 Raspberry Pi images support both Raspberry Pi 5 and Raspberry Pi 3B/3B+/4B/400, while other versions of the Raspberry Pi images only support Raspberry Pi 3B/3B+/4B/400.

Basic information of the images for Raspberry Pi is as follows. [more images](documents/raspberrypi/images.en.md)

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
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.03-LTS-SP3-raspi-aarch64-alpha1.img.xz">openEuler 24.03 LTS SP3 alpha1</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2026/01/16</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>332.3 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-132.0.0.17</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-24.03-LTS-SP3/generic.repo">openEuler 24.03 LTS SP3 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.03-LTS-SP3-UKUI-raspi-aarch64-alpha1.img.xz">openEuler 24.03 LTS SP3 alpha1 (UKUI desktop and Chinese input method)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2026/01/16</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.4 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-132.0.0.17</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-24.03-LTS-SP3/generic.repo">openEuler 24.03 LTS SP3 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.03-LTS-SP3-DDE-raspi-aarch64-alpha1.img.xz">openEuler 24.03 LTS SP3 alpha1 (DDE desktop and Chinese input method)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2026/01/16</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.7 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-132.0.0.17</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-24.03-LTS-SP3/generic.repo">openEuler 24.03 LTS SP3 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.03-LTS-SP3-GNOME-raspi-aarch64-alpha1.img.xz">openEuler 24.03 LTS SP3 alpha1 (GNOME desktop and Chinese input method)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2026/01/16</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.1 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-132.0.0.17</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-24.03-LTS-SP3/generic.repo">openEuler 24.03 LTS SP3 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.03-LTS-SP3-DevStation-raspi-aarch64-alpha1.img.xz">openEuler 24.03 LTS SP3 alpha1 (DevStation and Chinese input method)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2026/01/16</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.6 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-132.0.0.17</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-24.03-LTS-SP3/generic.repo">openEuler 24.03 LTS SP3 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://repo.openeuler.org/openEuler-24.03-LTS-SP3/raspi_img/openEuler-24.03-LTS-SP3-raspi-aarch64.img.xz">openEuler 24.03 LTS SP3</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2025/12/31</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>291.5 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>6.6.0-132.0.0.17</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-24.03-LTS-SP3/generic.repo">openEuler 24.03 LTS SP3 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-22.03-LTS-SP4-raspi-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP4 alpha1</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/07/06</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>235 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-209.0.0.21</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-22.03-LTS-SP4-UKUI-raspi-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP4 alpha1 (UKUI desktop and Chinese input method)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/07/06</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.5 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-209.0.0.21</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-22.03-LTS-SP4-DDE-raspi-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP4 alpha1 (DDE desktop and Chinese input method)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/07/06</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.4 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-209.0.0.21</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-22.03-LTS-SP4-Xfce-raspi-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP4 alpha1 (Xfce desktop and Chinese input method)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/07/06</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>2.0 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-209.0.0.21</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-22.03-LTS-SP4-UEFI-raspi-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP4 alpha1 (EFI boot)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/07/06</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>255 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-217.0.0.22</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://repo.openeuler.org/openEuler-22.03-LTS-SP4/raspi_img/openEuler-22.03-LTS-SP4-raspi-aarch64.img.xz">openEuler 22.03 LTS SP4</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/06/29</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>229 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-209.0.0.21</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP4/generic.repo">openEuler 22.03 LTS SP4 repository</a></td>
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
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo">openEuler 20.03 LTS repository</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>A compressed RAW original image</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-20.03-LTS-rk3399-firefly-aarch64-alpha1.tar.gz">openEuler 20.03 LTS Firefly-RK3399</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/12/20</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>493 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.90</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo">openEuler 20.03 LTS repository</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>A compressed image for the EMMC</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-20.03-LTS-RockPi-4A-aarch64-alpha1.img.xz">openEuler 20.03 LTS RockPi-4A</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/12/20</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>295 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.90</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo">openEuler 20.03 LTS repository</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>A compressed RAW original image</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-21.09-Firefly-RK3399-aarch64-alpha1.img.xz">openEuler 21.09 Firefly-RK3399</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/12/20</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>420 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-21.09/generic.repo">openEuler 21.09 repository</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>A compressed RAW original image</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-21.09-Firefly-RK3399-aarch64-alpha1.tar.gz">openEuler 21.09 Firefly-RK3399</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/12/20</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>717 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-21.09/generic.repo">openEuler 21.09 repository</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>A compressed image for the EMMC</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-21.09-RockPi-4A-aarch64-alpha1.img.xz">openEuler 21.09 RockPi-4A</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/12/20</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>717 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-21.09/generic.repo">openEuler 21.09 repository</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>A compressed RAW original image</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3588/openEuler-22.03-LTS-ITX-3588J-aarch64-alpha1.img.xz">openEuler 22.03 Firefly ITX-3588J</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2023/7/11</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>494 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-22.03-LTS/generic.repo">openEuler 22.03 repository</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>A compressed RAW original image</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3588/openEuler-22.03-LTS-rk3588-xfce.img.xz">openEuler 22.03 Firefly ITX-3588J + XFCE</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2023/7/11</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.9 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-22.03-LTS/generic.repo">openEuler 22.03 repository</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>A compressed RAW original image</p></td>
</tr>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://eulixos.com/repo/others/openeuler-rk3399/openEuler-22.03-LTS-SP3-Firefly-RK3399-aarch64-alpha1.img.xz">openEuler 22.03 LTS SP3 Firefly-RK3399</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>2024/1/23</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>450 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-22.03-LTS-SP3/generic.repo">openEuler 22.03 LTS SP3 repository</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>A compressed RAW original image</p></td>
</tr>
</tbody></table>

## How to build image

### Prepare the environment

To build openEuler AArch64 image for Raspberry Pi, Rockchip or other SoCs, the requirements of running scripts of this repository are as follows:

- OS: openEuler or CentOS 8
- Hardware: AArch64 hardware, such as Raspberry Pi, Firefly RK3399, Firefly ROC-RK3588S-PC

For other architecture hardware, you can use [QEMU](https://www.qemu.org/) to build AArch64 system emulation.

### Run the scripts to build image
You can use the unified build scripts [build.sh](./scripts/build.sh) or [build-image-docker.sh](./scripts/build-image-docker.sh) to build images for Raspberry Pi, Rockchip, and other development boards, either directly on the host machine or by launching a Docker container. For details, please refer to the documentation below:
- [Build Raspberry Pi images](./documents/RaspberryPi.md#构建镜像)
- [Build images for Rochchip and other SoCs](./documents/Rockchip.md#镜像构建)

#### Build on host
Run the following command to build images on the host machine:

`sudo bash build.sh --board BOARD_CONFIG -n NAME -k KERNEL_URL -b KERNEL_BRANCH -c KERNEL_DEFCONFIG -r REPO_INFO -s SPEC --cores N`

After building the image, you can find the image in `build/YYYY-MM-DD` of the directory in which the script resides as shown in the script output.

**NOTE: You can directly execute "sudo bash build.sh" to build an openEuler 20.03 LTS image for Firefly-RK3399 with the script's default parameters.**

**Parameter Descriptions**

1.  --board BOARD_CONFIG
    The board configuration files are located in the [boards](scripts/boards) directory. See the example file [sample.conf](scripts/boards/sample.conf). The default is `firefly-rk3399`.

    Configuration parameters included:
    - platform=PLATFORM

        The Hardware platform used by the board. Currently supported platforms are: broadcom, rockchip, phytium. Default is `rockchip`.

    - device-tree=DTB_NAME

        The device name in the kernel device tree (slightly different from the board name). Corresponds to the `DTB_NAME.dts` file under [kernel/arch/arm64/boot/dts/rockchip](https://atomgit.com/openeuler/kernel/tree/master/arch/arm64/boot/dts/rockchip). Default is `rk3399-firefly`.

    - ubootconfig=UBOOT_DEFCONFIG

        The defconfig file name for the development board. Corresponds to the `UBOOT_DEFCONFIG` file under [u-boot/configs](https://github.com/u-boot/u-boot/tree/master/configs). Default is `firefly-rk3399_defconfig`. To use a precompiled u-boot (e.g., on RK3588), set this to empty: ubootconfig=.

2.  -n, --name IMAGE_NAME

    The image name to be built. For example, `openEuler-20.03-LTS-Firefly-RK3399-aarch64-alpha1` or `openEuler-24.03-LTS-raspi-aarch64-alpha1`.

3.  -k, --kernel KERNEL_URL

    The URL of kernel source repository, which defaults to `https://atomgit.com/openeuler/raspberrypi-kernel.git`. You can set the parameter as `git@atomgit.com:openeuler/raspberrypi-kernel.git` or `git@atomgit.com:openeuler/kernel.git` according to the requirement.

4.  -b, --branch KERNEL_BRANCH

    The branch name of kernel source repository, which defaults to openEuler-20.03-LTS.

5.  -c, --config KERNEL_DEFCONFIG

    The filename/path of configuration for compiling kernel, which defaults to `openeuler-raspi_defconfig`. If this parameter is the filename of configuration, please make sure the configuration file in `arch/arm64/configs` of the kernel source.

6.  -r, --repo REPO_INFO

    The URL/path of target repo file, or the list of repositories' baseurls. Note that, the baseurls should be separated by space and enclosed in double quotes.
    Examples are as follows:

    - The URL of target repo file: `https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-20.03-LTS/generic.repo`.

    - The path of target repo file:

        `./openEuler-20.03-LTS.repo`：for building openEuler 20.03 LTS image, refer to <https://atomgit.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo> for details.

    - List of repo's baseurls: `http://repo.openeuler.org/openEuler-20.03-LTS/OS/aarch64/ http://repo.openeuler.org/openEuler-20.03-LTS/EPOL/aarch64/`.

7.  -s, --spec SPEC

    Specify the image version:
    - `headless`, image without desktop environments.
    - `xfce`, image with Xfce desktop environment and related software including CJK fonts and IME.
    - `ukui`, image with UKUI desktop environment and fundamental software including CJK fonts and IME.
    - `dde`, image with DDE desktop environment and fundamental software including CJK fonts and IME.
    - `gnome`，image with GNOME desktop environment and fundamental software including CJK fonts and IME.
    - `devstation`，image with GNOME desktop environment and fundamental software including CJK fonts, IME, development tools and IDEs.
    - The file path of rpmlist, the file contains a list of the software to be installed in the image, refer to [rpmlist](./scripts/configs/rpmlist) for details.

    The default is `headless`.

8.  --cores N

    The number of parallel compilations, according to the actual number of CPU of the host running the script. The default is the number of processing units available.

9.  -h, --help

    Displays help information.

#### Build in a Docker container
Run the following command to build an image in a Docker container:

`sudo bash build-image-docker.sh -d DOCKER_FILE --board BOARD_CONFIG -n NAME -k KERNEL_URL -b KERNEL_BRANCH -c KERNEL_DEFCONFIG -r REPO_INFO -s SPEC --cores N`

After building the image, you can find the image in `build/YYYY-MM-DD` of the directory in which the script resides.

Caution, before running the script, you need to install Docker. The script will automatically import the Docker image into the local system according to the script's parameter: DOCKER_FILE.

In addition to the parameter DOCKER_FILE, the other parameters are the same as the corresponding parameters in [Build on host](#build-on-host):

1.  -d, --docker DOCKER_FILE

    The URL/path of the Docker image, which defaults to `https://repo.openeuler.org/openEuler-20.03-LTS-SP1/docker_img/aarch64/openEuler-docker.aarch64.tar.xz`. With the default parameter, the script will automatically download the Docker image of openEuler 20.03 LTS SP1 and import it into the local system.
