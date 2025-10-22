# 介绍
[Hailo](https://hailo.ai/) 是一家领先的高性能 AI 处理器制造商，专注于为边缘计算设备设计和开发高性能、低功耗的人工智能（AI）处理器（AI 芯片）和配套软件解决方案。

[Raspberry Pi AI HAT+](https://www.raspberrypi.com/documentation/accessories/ai-hat-plus.html) 是一款内置 [Hailo AI](https://hailo.ai/products/ai-accelerators/hailo-8-m2-ai-acceleration-module/) 加速器的扩展板，专为 Raspberry Pi 5 设计。

AI HAT+ 基于 Hailo-8L 和 Hailo-8 神经网络推理加速器，分别提供 13 和 26 TOPS 两种算力型号。其中，13 TOPS 型号适用于中等工作量，性能与 [Raspberry Pi AI Kit](https://www.raspberrypi.com/documentation/accessories/ai-kit.html) 相当；26 TOPS 型号可以支持更大规模的神经网络，推理速度更快，并能更高效地并发运行多个模型。

AI HAT+ 通过 Raspberry Pi 5 的 PCIe 接口进行通信。系统启动后，Raspberry Pi 5 会自动检测板载 Hailo 加速器，并将支持的 AI 计算任务交由 NPU（神经网络处理器）执行。

基于 [Raspberry Pi 官方镜像](https://www.raspberrypi.com/software/operating-systems/) 安装和使用 Hailo NPU 相对简单，具体操作可参考 [AI Kit 与 AI HAT+ 软件](https://www.raspberrypi.com/documentation/computers/ai.html)。本文档重点介绍如何在 Raspberry Pi 的 openEuler 系统中安装并使用 Hailo NPU。

# 先决条件
本文档需要以下内容：
1. [Raspberry Pi 5](https://www.raspberrypi.com/products/raspberry-pi-5/)
2. [Raspberry Pi AI HAT+](https://www.raspberrypi.com/documentation/accessories/ai-hat-plus.html)
3. 支持 Raspberry Pi 5 的含桌面环境的 openEuler 操作系统，这里使用 [内核版本为 6.6 的 openEuler 24.03 LTS SP2 含 GNOME 桌面环境的系统镜像](https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/images/openEuler-24.03-LTS-SP2-GNOME-raspi-aarch64-alpha1.img.xz)
4. Raspberry Pi 官方摄像头，本文档中使用的是 [Raspberry Pi AI 摄像头](https://www.raspberrypi.com/documentation/accessories/ai-camera.html)

# 安装软件
Raspberry Pi Hailo AI 相关组件主要包含 hailofw、hailort、hailo-tappas-core、libcamera、rpicam-apps 五部分，下面分别介绍其编译安装过程。

## 1. hailofw
我们将 Raspberry Pi 官方软件源中 hailofw 软件包中的文件重新打包成可以直接安装到 openEuler 操作系统的 RPM 包：[hailofw-4.20.0-1.aarch64.rpm]()。安装该包后需要重启系统。

```bash
wget https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/rpms/hailofw-4.20.0-1.aarch64.rpm
rpm -i hailofw-4.20.0-1.aarch64.rpm
reboot
```

## 2. hailort
1. 安装依赖 `dnf install -y gcc gcc-c++ make cmake libatomic gstreamer1-plugins-base-devel`

2. 下载源码 `git clone -b master-openEuler https://github.com/woqidaideshi/hailort.git && cd hailort`
    这里使用的是适配到 openEuler 的 hailort 源码：<https://github.com/woqidaideshi/hailort/tree/master-openEuler>，其上游源码：<https://github.com/hailo-ai/hailort>。

3. 编译安装 `cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -DHAILO_BUILD_GSTREAMER=1 && cmake --build build --config release --target install`

4. 安装 python3-hailort
    1. 安装依赖
        ```bash
        dnf install cmake python3 pybind11-devel python3-setuptools python3-wheel python3-devel
        wget https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/rpms/python3-verboselogs-1.7-1.noarch.rpm
        rpm -i python3-verboselogs-1.7-1.noarch.rpm
        ```
    2. 编译
        ```bash
        cd hailort/libhailort/bindings/python/platform
        python3 setup.py bdist_wheel
        ```
        编译结束会在 `hailort/libhailort/bindings/python/platform/dist` 下生成 `.whl` 文件，例如这里生成文件 `hailort-5.0.0-cp311-cp311-linux_aarch64.whl`。
    3. 安装 `pip install dist/hailort-5.0.0-cp311-cp311-linux_aarch64.whl`

## 3. hailo-tappas-core
1. 安装依赖 `dnf install -y python3 ffmpeg xorg-x11-utils python3-devel python3-pip python3-setuptools python3-virtualenv gcc gcc-c++ pygobject3-devel  gobject-introspection-devel pkgconf cairo-devel gstreamer1-devel cmake gstreamer1-plugins-base-devel gstreamer1-plugins-base zeromq-devel rsync git gstreamer1-plugins-good  gstreamer1-plugins-bad-free-devel gstreamer1-plugins-bad-free gstreamer1-libav opencv gstreamer1 rapidjson-devel cairo-gobject-devel cppzmq-devel`

2. 下载源码 
    ```bash
    git clone -b master-openEuler git@github.com:woqidaideshi/tappas.git && cd tappas
    mkdir hailort
    git clone -b master-openEuler https://github.com/woqidaideshi/hailort.git hailort/sources
    ```

    这里使用的是适配到 openEuler 的 hailo-tappas-core 源码 <https://github.com/woqidaideshi/tappas/tree/master-openEuler>，其上游源码：<https://github.com/hailo-ai/tappas>。

3. 环境准备
    ```bash
    cd /usr/bin/
    ln -sf gcc gcc-12
    ln -sf g++ g++-12
    ```

4. 编译 `./install.sh --skip-hailort`

## 4. libcamera
1. 安装依赖
    ```bash
    dnf install -y python3-pip git python3-jinja2 boost-devel gnutls-devel openssl libtiff-devel pybind11-devel qt5-qtbase-devel meson cmake python3-yaml python3-ply glib2-devel gstreamer1-plugins-base-devel graphviz libdrm-devel elfutils-devel libevent-devel gstreamer1-devel gtest-devel libjpeg-devel lttng-ust-devel python3-devel SDL2-devel systemd-devel libyaml-devel meson pkgconf python3-sphinx
    wget https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/rpms/libyuv-20240704-1.aarch64.rpm
    wget https://mirror.iscas.ac.cn/eulixos/others/openeuler-raspberrypi/rpms/libyuv-devel-20240704-1.aarch64.rpm
    rpm -i libyuv-*.rpm
    ```

2. 下载源码 `git clone -b main https://github.com/woqidaideshi/libcamera.git && cd libcamera`

3. 配置构建环境 `meson setup build --buildtype=release -Dpipelines=rpi/vc4,rpi/pisp -Dipas=rpi/vc4,rpi/pisp -Dv4l2=enabled -Dgstreamer=enabled -Dtest=false -Dlc-compliance=disabled -Dcam=disabled -Dqcam=disabled -Ddocumentation=disabled -Dpycamera=enabled`

4. 编译 `ninja -C build`

5. 安装 `sudo ninja -C build install`

## 5. rpicam-apps
1. 安装依赖 `dnf install -y meson pkgconf python3 boost-devel libdrm-devel libepoxy-devel libexif-devel libjpeg-turbo-devel libpng-devel libtiff-devel libX11-devel qt5-qtbase-devel opencv ffmpeg-devel`

2. 下载源码 `git clone https://github.com/raspberrypi/rpicam-apps.git && cd rpicam-apps`

3. 设置环境变量 PKG_CONFIG_PATH
    ```bash
    echo 'export export PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig/:$PKG_CONFIG_PATH' >> ~/.bashrc
    source ~/.bashrc
    ```

4. 配置 `meson setup build -Denable_libav=enabled -Denable_drm=enabled -Denable_egl=enabled -Denable_qt=enabled -Denable_opencv=enabled -Denable_tflite=disabled -Denable_hailo=disabled`

5. 编译 `meson compile -C build`

6. 安装 `sudo meson install -C build`

7. 设置环境变量 LD_LIBRARY_PATH
    ```bash
    echo 'export LD_LIBRARY_PATH=/usr/local/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
    source ~/.bashrc
    ```
8. 查看安装结果 `rpicam-still --version`

9. 手动添加 opencv data 相关文件
    ```bash
    git clone -b 4.x https://github.com/opencv/opencv.git
    cd opencv
    mkdir -p /usr/local/share/OpenCV/
    cp -r data/haarcascades /usr/local/share/OpenCV/
    ```

10. 设置 cma
    `vi /boot/config.txt` 修改以下内容后重启系统 `reboot`。
    ```
    dtoverlay=vc4-kms-v3d-pi5,cma-512
    max_framebuffers=2
    ```

11. 人脸识别：`rpicam-hello -t 0 --lores-width 128 --lores-height 96 --post-process-file /usr/local/share/rpi-camera-assets/face_detect_cv.json`