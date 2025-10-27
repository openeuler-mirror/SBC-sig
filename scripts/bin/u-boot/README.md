### 目录说明

本目录用于存放镜像构建中所需的 U-Boot 引导镜像，按 SoC 架构和厂商分类组织。每个子目录对应一个具体的开发板，包含该板所需的完整 U-Boot 启动组件。

#### Rockchip 平台

基于 RK35xx 系列 SoC，采用两级启动流程（SPL + U-Boot FIT）。

**文件组成：**
- `idbloader.img`：包含 TPL/SPL 的一级加载器（First Stage Loader）
- `u-boot.itb`：FIT 格式的 U-Boot 主镜像（含设备树）

**适用开发板：**
- armsom-sige5
- dshanpi-a1
- firefly-rk3566
- firefly-rk3568
- firefly-rk3588
- radxa-rock5b

#### Allwinner 平台

基于 Sunxi 系列 SoC，使用单一体 SPL+U-Boot 镜像。

**文件组成：**
- `u-boot-sunxi-with-spl.bin`：合并了 SPL 与 U-Boot 的单一体镜像

**适用开发板：**
- longanpi-3h
- orangepi-zero2

#### Phytium（飞腾）平台

基于飞腾 SoC，使用封装为 FIP 格式的完整启动镜像。

**文件组成：**
- `fip-all-sd-boot.bin`：封装为 FIP 格式的单一体镜像，用于 SD 卡启动
- `env.txt`：U-Boot 环境变量配置文件，定义默认启动参数

**适用开发板：**
- phytiumpi