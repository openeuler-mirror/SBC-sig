- [描述](#描述)
- [使用 Windows 刷写](#使用-windows-刷写)
  - [使用打包后的 EMMC 刷写文件](#使用打包后的-emmc-刷写文件)
  - [使用压缩后的 RAW 原始镜像](#使用压缩后的-raw-原始镜像)
- [使用 Linux 刷写](#使用-linux-刷写)
- [使用 SD 镜像启动后进入系统刷写](#使用-sd-镜像启动后进入系统刷写)

# 描述

本文档以 Firefly ROC-RK3588S-PC 开发板刷写镜像为例，介绍了如何在 Rockchip 平台上将 openEuler 安装到 EMMC。

# 使用 Windows 刷写

## 使用打包后的 EMMC 刷写文件

1.  本方法仅适用于 RK3399。

2.  生成的刷写文件压缩包为 build 下的 openEuler-VERSION-BOARD-RELEASE.tar.gz，将其解压。

3.  下载 [RKDevTool 工具](http://www.t-firefly.com/doc/download/page/id/3.html#other_374)。

4.  进入 Loader 模式

    1.  使用 Type-C data cable 连接好开发板和主机。

    2.  使开发板进入 Loader 模式。
        - 按住开发板上的 RECOVERY （恢复）键并保持
        - 短按一下 RESET（复位）键
        - 大约两秒钟后，松开 RECOVERY 键

        ![loader](images/loader.png)

5.  切换至下载镜像页，勾选需要烧录的分区，可以多选。

6.  确保映像文件的路径和刷入地址正确，点击路径右边的空白表格单元格选择对应的文件。

    以 boot.img 文件为例，起始偏移地址对应分区表配置文件 `rk3399_parameter.gpt` 中的 `0x00078000@0x00008000(boot:bootable)`，含义为：起始地址为 `0x00008000`，大小为 `0x00078000` 的分区，分区名为 `boot`，可启动。

    ![emmcaddress](images/rk3399-emmcaddress.png)

7.  点击执行按钮开始升级，升级结束后开发板会自动重启。

## 使用压缩后的 RAW 原始镜像

1.  本方法适用于 Rk3399/RK356X/RK3576/RK3588。

2.  刷写所需要的文件：
    
    1.  生成的刷写文件压缩包为 build 下或项目主页发布的的压缩后的 RAW 原始镜像（需要解压）：openEuler-VERSION-BOARD-RELEASE.img.xz。

    2.  项目主页 scripts/bin 目录下提供的：
        - 如果是 RK3399，使用 [rk3399_loader.bin](../../scripts/bin/rockchip/rk3399_loader.bin)
        - 如果是 RK3588，使用 [rk3588_loader.bin](../../scripts/bin/rockchip/rk3588_loader.bin)

3.  下载版本不小于 2.92 的 [RKDevTool 工具](https://dl.radxa.com/tools/windows/windows_RKDevTool_Release_v2.92.zip)。

4.  进入 Maskrom 模式

    1.  使用 Type-C data cable 连接好开发板和主机。

    2.  使开发板进入 Maskrom 模式。
        1.  如果开发板有 Maskrom 按键。
            - 按住开发板上的 Maskrom 键并保持；
            - 插上电源线；
            - 在 RKDevTool 显示“发现一个 MASKROM 设备后”，松开 Maskrom 键。
        2.  如果开发板没有 Maskrom 按键（例如 Firefly-RK3399）。
            - 开发板开机，登录到开发板后，清除 EMMC 上的引导程序，此时开发板会自动进入 maskrom 模式。
              ```
              dd if=/dev/zero of=/dev/mmcblk0 bs=1M count=8
              reboot
              ```

5.  切换至下载镜像页，勾选需要烧录的分区，可以多选。

6.  按照图片顺序进行操作：

    1.  两者地址都为 `0x00000000`，确保刷入地址正确。

    2.  点击路径右边的空白表格单元格选择：
        - 如果是 RK3399，选择 rk3399_loader.bin
        - 如果是 RK3566/RK3568，选择 rk356x_loader.bin
        - 如果是 RK3576，选择 rk3576_loader.bin
        - 如果是 RK3588，选择 rk3588_loader.bin

    3.  点击路径右边的空白表格单元格选择 openEuler-VERSION-BOARD-RELEASE.img。

    4.  双击 system 项目的“储存”栏，选择储存为 EMMC。

    5.  勾选“强制按地址写”。

    6.  点击执行，开始刷写。

    ![emmcaddress](images/emmcaddress.png)

7.  刷写成功界面如下，刷写结束后开发板会自动重启。

    ![completely](images/completely.png)

# 使用 Linux/MacOS 刷写

1.  编译安装 rkdeveloptool ，具体可以参考 [Rockchip 官方 wiki - rkdeveloptool](http://opensource.rock-chips.com/wiki_Rkdeveloptool)；MacOS 需要安装 `Xcode 命令行工具` 以及 `homebrew` 环境。
    
    1.  下载源码

        `git clone https://github.com/rockchip-linux/rkdeveloptool.git`

    2.  编译安装

        `cd rkdeveloptool`

        `autoreconf -i`

        `./configure`

        `make`

        `make install`


2.  设备进入 MASKROM 模式：

    1. 如果是 Firefly-RK3399，开发板开机后，登录到开发板，需要清除 EMMC 上的引导程序，断电重启后开发板会自动进入 maskrom 模式

    ```
    dd if=/dev/zero of=/dev/mmcblk0 bs=1M count=8
    reboot
    ```

    2. 如果是自带 MASKROM 按键的开发板，按下 MASKROM 按键，然后连接电脑，接上电源后，开发板会进入 MASKROM 模式。

    使用 Type-C data cable 连接好开发板和主机，使用 `lsusb` 命令看到以下信息即为成功进入 Maskrom Mode

    RK3399 显示如下
    ![rk3399-maskrommode](images/rk3399-maskrommode.png)

3.  刷写 openEuler 到 EMMC:

    1. 如果使用打包后的 EMMC 刷写文件
    
       生成的刷写文件压缩包为 build 下的 openEuler-VERSION-BOARD-RELEASE.tar.gz，将其解压，刷写过程如下：

       下载 loader 文件来初始化设备：

       ```
       rkdeveloptool db rk3399_loader.bin
       ```

       应用分区表配置文件：

       ```
       rkdeveloptool gpt rk3399_parameter.gpt
       ```

       刷入 idbloader 到 EMMC 起始偏移地址为 0x40（块大小为 512 的第 64 个块）的地方：

       ```
       rkdeveloptool wl 0x40 idbloader.img
       ```

       刷入 u-boot 到 EMMC 起始偏移地址为 0x4000（块大小为 512 的第 16384 个块）的地方：

       ```
       rkdeveloptool wl 0x4000 u-boot.itb
       ```

       刷入 boot.img，起始偏移地址对应分区表配置文件 `rk3399_parameter.gpt` 中的 `0x00078000@0x00008000(boot:bootable)`，含义为：起始地址为 `0x00008000`，大小为 `0x00078000` 的分区，分区名为 `boot`，可启动。

       ```
       rkdeveloptool wl 0x8000 boot.img
       ```

       刷入 rootfs.img，起始地址参考上文描述。

       ```
       rkdeveloptool wl 0x80000 rootfs.img
       ```

       然后重启设备

       ```
       rkdeveloptool rd
       ```

    2. 如果使用压缩后的 RAW 原始镜像

       生成的刷写文件压缩包为 build 下或项目主页发布的的压缩后的 RAW 原始镜像（需要解压）：openEuler-VERSION-BOARD-RELEASE.img.xz，将其解压，刷写过程如下：

       下载 loader 文件来初始化设备：

       ```
       rkdeveloptool db loader.bin
       ```

       其中，`loader.bin` 需要按照以下情况进行替换：

        - 如果是 RK3399，替换为 rk3399_loader.bin
        - 如果是 RK3566/RK3568，替换为 rk356x_loader.bin
        - 如果是 RK3576，替换为 rk3576_loader.bin
        - 如果是 RK3588，替换为 rk3588_loader.bin

       刷写 RAW 原始镜像到 EMMC：

       ```
       rkdeveloptool wl 0  openEuler-VERSION-BOARD-RELEASE.img
       ```

       这里的 `openEuler-VERSION-BOARD-RELEASE.img` 需要替换为实际的镜像名称

       重启设备

       ```
       rkdeveloptool rd
       ```

# 使用 SD 镜像启动后进入系统刷写

1.  确保能使用 SD 镜像成功启动并进入系统，此处不限系统，例如 Firefly/Radxa 提供的官方 Debian/Ubuntu 系统。

2.  准备好项目主页提供或者根据项目脚本生成的`压缩后的 SD 卡启动文件`。

3.  使用 `lsblk` 查找并确认 EMMC 盘符，使用 SD 镜像启动后的 EMMC 盘符通常同时符合以下两个特点：

    1.  盘符以 `mmcblk` 开头。

    2.  未被挂载为根目录和 `/boot` 目录。

4.  刷写系统。（在 Firefly ROC-RK3588S-PC 和 Firefly ITX-RK3588 上，EMMC 盘符为 `mmcblk0`，此处以 `mmcblk0`为例）

    `xzcat openEuler-VERSION-BOARD-ARCH-RELEASE.img.xz | dd of=/dev/mmcblk0 status=progress`

5.  关机后取下 SD 卡，然后再启动开发板即可。
