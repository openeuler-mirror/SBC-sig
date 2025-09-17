# 开发板兼容性列表
[English](./compatibility-list.en.md) | 简体中文

>![](public_sys-resources/icon-notice.gif) **须知：**  
>1. 下表所列的树莓派开发板（除树莓派 5 外）均支持 openEuler 的全部发行版本，此处仅展示其当前支持的最新版本。
>2. 下表中的 `支持程度` 指 openEuler 社区对开发板的支持水平，按照高到低分为以下三个等级：
>    - `官方支持`：内核已完成对 openEuler 的适配，社区官方发布并维护的镜像，提供完整的系统支持和更新保障。
>    - `社区支持`：内核已完成对 openEuler 的适配，社区提供对应的内核源码仓库，用户需要基于该内核源码和 openEuler 软件源构建镜像。
>    - `基本支持`：内核尚未适配到 openEuler，用户需使用开发板的上游内核源码，并结合 openEuler 软件源构建镜像。


<table><thead align="left"><tr>
<th class="cellrowborder" valign="top" width="10%"><p><strong>硬件型号</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>CPU</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>操作系统</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>支持程度</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>备注</strong></p></th>
</tr></thead>
<tbody>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://www.raspberrypi.com/products/raspberry-pi-5/">Raspberry Pi 5</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Broadcom BCM2712</p></td>
<td class="cellrowborder" valign="top" width="10%"><p><a href="https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP2/raspi_img/">openEuler 24.03 LTS SP2</a>（<a href="https://gitee.com/openeuler/raspberrypi-kernel/tree/OLK-6.6/">内核版本 6.6</a>）<br><a href="https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP1/raspi_img/">openEuler 24.03 LTS SP1</a>（<a href="https://gitee.com/openeuler/raspberrypi-kernel/tree/OLK-6.6/">内核版本 6.6</a>）</p></td>
<td class="cellrowborder" valign="top" width="10%"><a style="color:green" href="https://repo.openeuler.org/openEuler-24.03-LTS-SP2/raspi_img/">官方支持</a></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./raspberrypi/images.md">下载镜像</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://www.raspberrypi.com/products/raspberry-pi-4-model-b/">Raspberry Pi 4B</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Broadcom BCM2711</p></td>
<td class="cellrowborder" valign="top" width="10%"><p><a href="https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP2/raspi_img/">openEuler 24.03 LTS SP2</a>（<a href="https://gitee.com/openeuler/raspberrypi-kernel/tree/OLK-6.6/">内核版本 6.6</a>）<br><a href="./raspberrypi/images.md">历史版本</a></p></td>
<td class="cellrowborder" valign="top" width="10%"><a style="color:green" href="https://repo.openeuler.org/openEuler-24.03-LTS-SP2/raspi_img/">官方支持</a></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./raspberrypi/images.md">下载镜像</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://www.raspberrypi.com/products/raspberry-pi-400/">Raspberry Pi 400</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Broadcom BCM2711</p></td>
<td class="cellrowborder" valign="top" width="10%"><p><a href="https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP2/raspi_img/">openEuler 24.03 LTS SP2</a>（<a href="https://gitee.com/openeuler/raspberrypi-kernel/tree/OLK-6.6/">内核版本 6.6</a>）<br><a href="./raspberrypi/images.md">历史版本</a></p></td>
<td class="cellrowborder" valign="top" width="10%"><a style="color:green" href="https://repo.openeuler.org/openEuler-24.03-LTS-SP2/raspi_img/">官方支持</a></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./raspberrypi/images.md">下载镜像</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://www.raspberrypi.com/products/raspberry-pi-3-model-b-plus/">Raspberry Pi 3B+</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Broadcom BCM2837B0</p></td>
<td class="cellrowborder" valign="top" width="10%"><p><a href="https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP2/raspi_img/">openEuler 24.03 LTS SP2</a>（<a href="https://gitee.com/openeuler/raspberrypi-kernel/tree/OLK-6.6/">内核版本 6.6</a>）<br><a href="./raspberrypi/images.md">历史版本</a></p></td>
<td class="cellrowborder" valign="top" width="10%"><a style="color:green" href="https://repo.openeuler.org/openEuler-24.03-LTS-SP2/raspi_img/">官方支持</a></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./raspberrypi/images.md">下载镜像</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://www.raspberrypi.com/products/raspberry-pi-3-model-b/">Raspberry Pi 3B</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Broadcom BCM2837</p></td>
<td class="cellrowborder" valign="top" width="10%"><p><a href="https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP2/raspi_img/">openEuler 24.03 LTS SP2</a>（<a href="https://gitee.com/openeuler/raspberrypi-kernel/tree/OLK-6.6/">内核版本 6.6</a>）<br><a href="./raspberrypi/images.md">历史版本</a></p></td>
<td class="cellrowborder" valign="top" width="10%"><a style="color:green" href="https://repo.openeuler.org/openEuler-24.03-LTS-SP2/raspi_img/">官方支持</a></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./raspberrypi/images.md">下载镜像</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://wiki.t-firefly.com/zh_CN/Firefly-RK3399/index.html">Firefly RK3399</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Rockchip RK3399</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 24.03 LTS（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-24.03-LTS/">内核版本 6.6</a>）<br>openEuler 22.03 LTS SP3（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-22.03-LTS-SP3/">内核版本 5.10</a>）<br>openEuler 22.03 LTS SP2（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-22.03-LTS-SP2/">内核版本 5.10</a>）<br>openEuler 20.03 LTS（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-20.03-LTS/">内核版本 4.19</a>）</p></td>
<td class="cellrowborder" valign="top" width="10%"><p style="color:yellow">社区支持</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#firefly-rk3399">构建完整镜像</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://docs.radxa.com/rock4/rock4ab">Radxa Rock Pi 4A</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Rockchip RK3399</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 22.03 LTS（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-22.03-LTS/">内核版本 5.10</a>）<br>openEuler 20.03 LTS（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-20.03-LTS/">内核版本 4.19</a>）</p></td>
<td class="cellrowborder" valign="top" width="10%"><p style="color:yellow">社区支持</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#radxa-rockpi-4a">构建完整镜像</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://wiki.t-firefly.com/zh_CN/ROC-RK3566-PC/">Firefly ROC-RK3566-PC</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Rockchip RK3566</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 24.03 LTS（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-24.03-LTS/">内核版本 6.6</a>）<br>openEuler 22.03 LTS SP3（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-22.03-LTS-SP3/">内核版本 5.10</a>）<br>openEuler 22.03 LTS SP2（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-22.03-LTS-SP2/">内核版本 5.10</a>）</p></td>
<td class="cellrowborder" valign="top" width="10%"><p style="color:yellow">社区支持</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#firefly-roc-rk3566-pc">构建完整镜像</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://wiki.t-firefly.com/zh_CN/ROC-RK3568-PC-SE/">Firefly ROC-RK3568-PC-SE</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Rockchip RK3568</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 22.03 LTS SP3（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-22.03-LTS-SP3/">内核版本 5.10</a>）<br>openEuler 22.03 LTS SP2（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-22.03-LTS-SP2/">内核版本 5.10</a>）</p></td>
<td class="cellrowborder" valign="top" width="10%"><p style="color:yellow">社区支持</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#firefly-roc-rk3568-pc-se">构建完整镜像</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://wiki.t-firefly.com/zh_CN/ROC-RK3568-PC/">Firefly ROC-RK3568-PC</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Rockchip RK3568</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 22.03 LTS SP3（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-22.03-LTS-SP3/">内核版本 5.10</a>）<br>openEuler 22.03 LTS SP2（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-22.03-LTS-SP2/">内核版本 5.10</a>）</p></td>
<td class="cellrowborder" valign="top" width="10%"><p style="color:yellow">社区支持</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#firefly-roc-rk3568-pc">构建完整镜像</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://docs.armsom.org/armsom-sige5">BananaPi Armsom-Sige5</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Rockchip RK3576</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 22.03 LTS SP3（<a href="https://github.com/armbian/linux-rockchip/tree/rk-6.1-rkr5.1">内核版本 6.1</a>）</p></td>
<td class="cellrowborder" valign="top" width="10%"><p style="color:yellow">基本支持</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#bananapi-armsom-sige5">构建完整镜像</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://wiki.dshanpi.org/docs/DshanPi-A1/intro">100ASK DShanPi A1</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Rockchip RK3576</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 22.03 LTS SP3（<a href="https://github.com/dshanpi/dshanpi-a1-linux-kernel/tree/rk-6.1">内核版本 6.1</a>）</p></td>
<td class="cellrowborder" valign="top" width="10%"><p style="color:yellow">基本支持</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#100ask-dshanpi-a1">构建完整镜像</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://wiki.t-firefly.com/zh_CN/Core-3588J/index.html">Firefly ITX-3588J</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Rockchip RK3588</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 22.03 LTS SP3（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-22.03-LTS-SP3/">内核版本 5.10</a>）</p></td>
<td class="cellrowborder" valign="top" width="10%"><p style="color:yellow">社区支持</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#firefly-itx-3588j">构建完整镜像</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://wiki.t-firefly.com/zh_CN/ROC-RK3588S-PC/index.html">Firefly ROC-RK3588S-PC</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Rockchip RK3588</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 22.03 LTS SP3（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-22.03-LTS-SP3/">内核版本 5.10</a>）<br>openEuler 22.03 LTS SP2（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-22.03-LTS-SP2/">内核版本 5.10</a>）</p></td>
<td class="cellrowborder" valign="top" width="10%"><p style="color:yellow">社区支持</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#firefly-roc-rk3588s-pc">构建完整镜像</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://docs.radxa.com/rock5/rock5b">Radxa Rock-5B</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Rockchip RK3588</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 22.03 LTS SP3（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-22.03-LTS-SP3/">内核版本 5.10</a>）<br>openEuler 22.03 LTS SP2（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-22.03-LTS-SP2/">内核版本 5.10</a>）</p></td>
<td class="cellrowborder" valign="top" width="10%"><p style="color:yellow">社区支持</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#radxa-rock-5b">构建完整镜像</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://www.phytium.com.cn/homepage/phytium_pie/">Phytium Pi 4GB</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Phytium</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 24.03 LTS（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-24.03-LTS/">内核版本 6.6</a>）<br>openEuler 22.03 LTS SP3（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-22.03-LTS-SP3/">内核版本 5.10</a>）</p></td>
<td class="cellrowborder" valign="top" width="10%"><p style="color:yellow">社区支持</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#phytium-pi-4gb">构建完整镜像</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="http://www.orangepi.cn/orangepiwiki/index.php/Orange_Pi_Zero_2">Orange Pi Zero 2</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Allwinner H616</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 24.03 LTS（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-24.03-LTS/">内核版本 6.6</a>）<br>openEuler 20.03 LTS（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-20.03-LTS/">内核版本 4.19</a>）</p></td>
<td class="cellrowborder" valign="top" width="10%"><p style="color:yellow">社区支持</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#orange-pi-zero-2">构建完整镜像</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://wiki.sipeed.com/hardware/zh/longan/h618/lpi3h/1_intro.html">Longan Pi 3H</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>Allwinner H618</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>openEuler 24.03 LTS（<a href="https://gitee.com/openeuler/rockchip-kernel/tree/openEuler-24.03-LTS/">内核版本 6.6</a>）</p></td>
<td class="cellrowborder" valign="top" width="10%"><p style="color:yellow">社区支持</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="./rockchip/构建完整镜像命令列举.md#longan-pi-3h">构建完整镜像</a></td>
</tr>
</tbody>
</table>