- [描述](#描述)
- [在 openEuler 上安装 RKNPU 并运行推理](#在-openeuler-上安装-rknpu-并运行推理)
  - [安装 RKNPU 运行环境](#安装-rknpu-运行环境)
  - [测试 RKNPU](#测试-rknpu)
  - [安装 rknn-toolkit-lite2 Python 环境](#安装-rknn-toolkit-lite2-python-环境)
  - [运行 ResNet18 模型推理](#运行-resnet18-模型推理)
  - [测试 Dynamic Shape](#测试-dynamic-shape)

# 描述

本文档介绍如何在 openEuler 的 Rockchip 设备上使用 RKNPU。

参考的官方文档：

https://github.com/airockchip/rknn-toolkit2/blob/master/doc/02_Rockchip_RKNPU_User_Guide_RKNN_SDK_V2.3.2_CN.pdf

内核需求：需要支持 RKNPU 的内核

测试设备：Armsom Sige5 (RK3576)

openEuler 版本：openEuler 22.03 LTS SP3

镜像构建命令如下：

```
sudo bash build.sh --board armsom-sige5 \
            -n openEuler-22.03-LTS-SP3-Armsom-Sige5-aarch64-alpha1 \
            -k https://github.com/armbian/linux-rockchip.git \
            -b rk-6.1-rkr5.1 \
            -c rockchip_linux_defconfig \
            -r https://gitee.com/src-openeuler/openEuler-repos/raw/openEuler-22.03-LTS-SP3/generic.repo \
            -s headless
```

将上面构建成功的 openEuler 镜像刷写到 Armsom Sige5 (RK3576) 开发板，之后就可以按照下面的文档安装 RKNPU 并运行推理。

# 在 openEuler 上安装 RKNPU 并运行推理

## 安装 RKNPU 运行环境

安装所需要的软件包

```
dnf update && dnf install git python3-pip screen gcc g++ make cmake -y
```

下载 RKNPU 代码及软件包仓库

```
cd ~
git clone --depth=1 https://github.com/airockchip/rknn-toolkit2.git
```

安装 RKNPU 运行环境到系统

```
cd rknn-toolkit2

cp rknpu2/runtime/Linux/librknn_api/aarch64/librknnrt.so /usr/lib64
cp rknpu2/runtime/Linux/librknn_api/aarch64/librknnrt.so /usr/lib

cp rknpu2/runtime/Linux/rknn_server/aarch64/usr/bin/* /usr/bin
```

添加文件权限

```
chmod +x /usr/bin/start_rknn.sh
chmod +x /usr/bin/restart_rknn.sh
chmod +x /usr/bin/rknn_server
```

使用 `screen` 来保持 `rknn_server` 后台运行，这里也可以使用其他软件来实现，例如 `nohup`。

```
screen -S rknn_server
```

然后输入以下命令来启动 `rknn_server`：

```
start_rknn.sh
```

运行结果如下：

```
bash-5.1# start_rknn.sh
start rknn server, version:2.3.2 (1842325 build@2025-03-30T09:54:34)
I NPUTransfer(995): Starting NPU Transfer Server, Transfer version 2.2.2 (@2024-06-18T03:50:51)
```

如果使用 `screen` 命令使 `rknn_server` 保持后台运行的话，此时使用 `Ctrl A + Z` 来退出当前终端（按住 `Ctrl` 的同时，先按 `A` 再按 `Z`），让 `rknn_server` 保持后台运行。如需恢复 `rknn_server` 终端，使用 `screen -r rknn_server`。

## 测试 RKNPU

### 运行 rknn_benchmark 基准测试

进入 `rknn_benchmark` 目录

```
cd ~/rknn-toolkit2/rknpu2/examples/rknn_benchmark
```

编译并运行 `rknn_benchmark`

```
export GCC_COMPILER=/usr/bin/aarch64-linux-gnu

bash build-linux.sh -t rk3576 -a aarch64 -b Release
```

这里使用的设备是 `rk3576`，如果使用 `rk3588` 平台，将这里的 `rk3576` 改为 `rk3588` 即可。

编译过程如下：

```
[root@openEuler rknn_benchmark]# bash build-linux.sh -t rk3576 -a aarch64 -b Release
build-linux.sh -t rk3576 -a aarch64 -b Release
/usr/bin/aarch64-linux-gnu
===================================
TARGET_SOC=RK3576
TARGET_ARCH=aarch64
BUILD_TYPE=Release
BUILD_DIR=/root/rknn-toolkit2/rknpu2/examples/rknn_benchmark/build/build_RK3576_linux_aarch64_Release
CC=/usr/bin/aarch64-linux-gnu-gcc
CXX=/usr/bin/aarch64-linux-gnu-g++
===================================
-- The CXX compiler identification is GNU 10.3.1
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /usr/bin/aarch64-linux-gnu-g++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Configuring done
-- Generating done
-- Build files have been written to: /root/rknn-toolkit2/rknpu2/examples/rknn_benchmark/build/build_RK3576_linux_aarch64_Release
[ 33%] Building CXX object CMakeFiles/rknn_benchmark.dir/src/cnpy/cnpy.cpp.o
[ 66%] Building CXX object CMakeFiles/rknn_benchmark.dir/src/rknn_benchmark.cpp.o
[100%] Linking CXX executable rknn_benchmark
[100%] Built target rknn_benchmark
Consolidate compiler generated dependencies of target rknn_benchmark
[100%] Built target rknn_benchmark
Install the project...
-- Install configuration: "Release"
-- Installing: /root/rknn-toolkit2/rknpu2/examples/rknn_benchmark/install/rknn_benchmark_Linux/./rknn_benchmark
-- Set runtime path of "/root/rknn-toolkit2/rknpu2/examples/rknn_benchmark/install/rknn_benchmark_Linux/./rknn_benchmark" to "lib"
-- Installing: /root/rknn-toolkit2/rknpu2/examples/rknn_benchmark/install/rknn_benchmark_Linux/lib/librknnrt.so
```

进入编译完成的目录：

```
cd ~/rknn-toolkit2/rknpu2/examples/rknn_benchmark/install/rknn_benchmark_Linux/
```

使用 `MobileNet v1` 运行基准测试

```
./rknn_benchmark ../../../rknn_mobilenet_demo/model/RK3576/mobilenet_v1.rknn
```

测试结果如下：

```
[root@openEuler rknn_benchmark_Linux]# ./rknn_benchmark ../../../rknn_mobilenet_demo/model/RK3576/mobilenet_v1.rknn
rknn_api/rknnrt version: 2.3.2 (429f97ae6b@2025-04-09T09:09:27), driver version: 0.9.8
total weight size: 4465024, total internal size: 2157568
total dma used size: 11530240
model input num: 1, output num: 1
input tensors:
  index=0, name=input, n_dims=4, dims=[1, 224, 224, 3], n_elems=150528, size=150528, w_stride = 224, size_with_stride=150528, fmt=NHWC, type=INT8, qnt_type=AFFINE, zp=0, scale=0.007812
output tensors:
  index=0, name=MobilenetV1/Predictions/Reshape_1, n_dims=2, dims=[1, 1001], n_elems=1001, size=2002, w_stride = 0, size_with_stride=2002, fmt=UNDEFINED, type=FP16, qnt_type=AFFINE, zp=0, scale=1.000000
custom string: 
Warmup ...
   0: Elapse Time = 4.98ms, FPS = 200.72
   1: Elapse Time = 4.61ms, FPS = 216.92
   2: Elapse Time = 4.44ms, FPS = 225.17
   3: Elapse Time = 4.39ms, FPS = 228.05
   4: Elapse Time = 4.39ms, FPS = 227.74
Begin perf ...
   0: Elapse Time = 4.36ms, FPS = 229.62
   1: Elapse Time = 4.29ms, FPS = 232.88
   2: Elapse Time = 4.34ms, FPS = 230.68
   3: Elapse Time = 4.47ms, FPS = 223.71
   4: Elapse Time = 4.53ms, FPS = 220.95
   5: Elapse Time = 4.51ms, FPS = 221.68
   6: Elapse Time = 4.51ms, FPS = 221.48
   7: Elapse Time = 4.64ms, FPS = 215.75
   8: Elapse Time = 4.91ms, FPS = 203.79
   9: Elapse Time = 2.60ms, FPS = 384.91

Avg Time 4.31ms, Avg FPS = 231.771

Save output to rt_output0.npy
---- Top5 ----
0.049622 - 620
0.044678 - 645
0.032288 - 627
0.021011 - 819
0.016953 - 790
```

可以看到，在使用 `MobileNet v1` 模型进行基准测试时，推理平均时延为 4.31ms，推理平均 FPS 为 231.771。

### 测试 MobileNet 模型推理

进入 `MobileNet Demo` 目录：

```
cd rknn_mobilenet_demo
```

编译 `MobileNet Demo` 推理程序：

```
bash build-linux.sh -t rk3576 -a aarch64 -b Release
```

编译过程如下：

```
[root@openEuler rknn_mobilenet_demo]# bash build-linux.sh -t rk3576 -a aarch64 -b Release
build-linux.sh -t rk3576 -a aarch64 -b Release
/usr/bin/aarch64-linux-gnu
===================================
TARGET_SOC=RK3576
TARGET_ARCH=aarch64
BUILD_TYPE=Release
BUILD_DIR=/root/rknn-toolkit2/rknpu2/examples/rknn_mobilenet_demo/build/build_RK3576_linux_aarch64_Release
CC=/usr/bin/aarch64-linux-gnu-gcc
CXX=/usr/bin/aarch64-linux-gnu-g++
===================================
-- The C compiler identification is GNU 10.3.1
-- The CXX compiler identification is GNU 10.3.1
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/aarch64-linux-gnu-gcc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /usr/bin/aarch64-linux-gnu-g++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Found OpenCV: /root/rknn-toolkit2/rknpu2/examples/3rdparty/opencv/opencv-linux-aarch64 (found version "3.4.5") 
-- target_soc = RK3576
-- Configuring done
-- Generating done
-- Build files have been written to: /root/rknn-toolkit2/rknpu2/examples/rknn_mobilenet_demo/build/build_RK3576_linux_aarch64_Release
[ 50%] Building CXX object CMakeFiles/rknn_mobilenet_demo.dir/src/main.cc.o
[100%] Linking CXX executable rknn_mobilenet_demo
[100%] Built target rknn_mobilenet_demo
Consolidate compiler generated dependencies of target rknn_mobilenet_demo
[100%] Built target rknn_mobilenet_demo
Install the project...
-- Install configuration: "Release"
-- Installing: /root/rknn-toolkit2/rknpu2/examples/rknn_mobilenet_demo/install/rknn_mobilenet_demo_Linux/./rknn_mobilenet_demo
-- Set runtime path of "/root/rknn-toolkit2/rknpu2/examples/rknn_mobilenet_demo/install/rknn_mobilenet_demo_Linux/./rknn_mobilenet_demo" to "lib"
-- Installing: /root/rknn-toolkit2/rknpu2/examples/rknn_mobilenet_demo/install/rknn_mobilenet_demo_Linux/./model/RK3576
-- Installing: /root/rknn-toolkit2/rknpu2/examples/rknn_mobilenet_demo/install/rknn_mobilenet_demo_Linux/./model/RK3576/mobilenet_v1.rknn
-- Installing: /root/rknn-toolkit2/rknpu2/examples/rknn_mobilenet_demo/install/rknn_mobilenet_demo_Linux/./model/cat_224x224.jpg
-- Installing: /root/rknn-toolkit2/rknpu2/examples/rknn_mobilenet_demo/install/rknn_mobilenet_demo_Linux/./model/dog_224x224.jpg
-- Installing: /root/rknn-toolkit2/rknpu2/examples/rknn_mobilenet_demo/install/rknn_mobilenet_demo_Linux/lib/librknnrt.so
```

进入编译输出文件目录：

```
cd install/rknn_mobilenet_demo_Linux
```

使用 `MobileNet` 模型运行推理，测试输入 `cat_224x224.jpg` 图片：

```
./rknn_mobilenet_demo ../../model/RK3576/mobilenet_v1.rknn ../../model/cat_224x224.jpg
```

推理结果如下：

```
[root@openEuler rknn_mobilenet_demo_Linux]# ./rknn_mobilenet_demo ../../model/RK3576/mobilenet_v1.rknn ../../model/cat_224x224.jpg
model input num: 1, output num: 1
input tensors:
  index=0, name=input, n_dims=4, dims=[1, 224, 224, 3], n_elems=150528, size=150528, fmt=NHWC, type=INT8, qnt_type=AFFINE, zp=0, scale=0.007812
output tensors:
  index=0, name=MobilenetV1/Predictions/Reshape_1, n_dims=2, dims=[1, 1001, 0, 0], n_elems=1001, size=2002, fmt=UNDEFINED, type=FP16, qnt_type=AFFINE, zp=0, scale=1.000000
rknn_run
 --- Top5 ---
283: 0.415283
282: 0.175781
286: 0.158813
278: 0.060303
279: 0.043427
```

使用 `MobileNet` 模型运行推理，测试输入 `dog_224x224.jpg` 图片：

```
./rknn_mobilenet_demo ../../model/RK3576/mobilenet_v1.rknn ../../model/dog_224x224.jpg
```

推理结果如下：

```
[root@openEuler rknn_mobilenet_demo_Linux]# ./rknn_mobilenet_demo ../../model/RK3576/mobilenet_v1.rknn ../../model/dog_224x224.jpg
model input num: 1, output num: 1
input tensors:
  index=0, name=input, n_dims=4, dims=[1, 224, 224, 3], n_elems=150528, size=150528, fmt=NHWC, type=INT8, qnt_type=AFFINE, zp=0, scale=0.007812
output tensors:
  index=0, name=MobilenetV1/Predictions/Reshape_1, n_dims=2, dims=[1, 1001, 0, 0], n_elems=1001, size=2002, fmt=UNDEFINED, type=FP16, qnt_type=AFFINE, zp=0, scale=1.000000
rknn_run
 --- Top5 ---
156: 0.935059
155: 0.057037
205: 0.003881
284: 0.003119
285: 0.000172
```

## 安装 rknn-toolkit-lite2 Python 环境

进入 rknn-toolkit-lite2 Python 软件包目录：

```
cd ~/rknn-toolkit2/rknn-toolkit-lite2/packages
```

查看 `Python` 版本：

```
[root@openEuler packages]# python3 -V
Python 3.9.9
```

根据相应的版本应该安装仓库提供的对应 `cp39` 的 `rknn_toolkit_lite2` Python 软件包 `rknn_toolkit_lite2-2.3.2-cp39-cp39-manylinux_2_17_aarch64.manylinux2014_aarch64.whl`，运行以下命令：

```
pip3 install rknn_toolkit_lite2-2.3.2-cp39-cp39-manylinux_2_17_aarch64.manylinux2014_aarch64.whl
```

安装过程如下：

```
[root@openEuler packages]# pip3 install rknn_toolkit_lite2-2.3.2-cp39-cp39-manylinux_2_17_aarch64.manylinux2014_aarch64.whl
WARNING: Running pip install with root privileges is generally not a good idea. Try `pip3 install --user` instead.
Processing ./rknn_toolkit_lite2-2.3.2-cp39-cp39-manylinux_2_17_aarch64.manylinux2014_aarch64.whl
Collecting ruamel.yaml
  Downloading ruamel.yaml-0.18.14-py3-none-any.whl (118 kB)
     |████████████████████████████████| 118 kB 644 kB/s            
Collecting numpy
  Downloading numpy-2.0.2-cp39-cp39-manylinux_2_17_aarch64.manylinux2014_aarch64.whl (13.9 MB)
     |████████████████████████████████| 13.9 MB 61 kB/s             
Collecting psutil
  Downloading psutil-7.0.0-cp36-abi3-manylinux_2_17_aarch64.manylinux2014_aarch64.whl (279 kB)
     |████████████████████████████████| 279 kB 31.8 MB/s            
Collecting ruamel.yaml.clib>=0.2.7
  Downloading ruamel.yaml.clib-0.2.12-cp39-cp39-manylinux2014_aarch64.whl (636 kB)
     |████████████████████████████████| 636 kB 23.4 MB/s            
Installing collected packages: ruamel.yaml.clib, ruamel.yaml, psutil, numpy, rknn-toolkit-lite2
Successfully installed numpy-2.0.2 psutil-7.0.0 rknn-toolkit-lite2-2.3.2 ruamel.yaml-0.18.14 ruamel.yaml.clib-0.2.12
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
```

还需要安装 `opencv-python` Python 软件包：

```
[root@openEuler packages]# pip3 install opencv-python
WARNING: Running pip install with root privileges is generally not a good idea. Try `pip3 install --user` instead.
Collecting opencv-python
  Downloading opencv_python-4.12.0.88-cp37-abi3-manylinux2014_aarch64.manylinux_2_17_aarch64.whl (45.9 MB)
     |████████████████████████████████| 45.9 MB 6.0 kB/s             
Requirement already satisfied: numpy<2.3.0,>=2 in /usr/local/lib64/python3.9/site-packages (from opencv-python) (2.0.2)
Installing collected packages: opencv-python
Successfully installed opencv-python-4.12.0.88
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
```

## 运行 ResNet18 模型推理

进入 ResNet18 Demo 目录：

```
cd ~/rknn-toolkit2/rknn-toolkit-lite2/examples/resnet18
```

运行推理：

```
[root@openEuler resnet18]# python3 test.py
W rknn-toolkit-lite2 version: 2.3.2
--> Load RKNN model
done
--> Init runtime environment
I RKNN: [16:56:45.369] RKNN Runtime Information, librknnrt version: 2.3.2 (429f97ae6b@2025-04-09T09:09:27)
I RKNN: [16:56:45.369] RKNN Driver Information, version: 0.9.8
I RKNN: [16:56:45.369] RKNN Model Information, version: 6, toolkit version: 2.3.2(compiler version: 2.3.2 (839b70f037@2025-04-03T10:34:04)), target: RKNPU f2, target platform: rk3576, framework name: PyTorch, framework layout: NCHW, model inference type: static_shape
W RKNN: [16:56:45.400] query RKNN_QUERY_INPUT_DYNAMIC_RANGE error, rknn model is static shape type, please export rknn with dynamic_shapes
W Query dynamic range failed. Ret code: RKNN_ERR_MODEL_INVALID. (If it is a static shape RKNN model, please ignore the above warning message.)
done
--> Running model
resnet18
-----TOP 5-----
[812] score:0.999638 class:"space shuttle"
[404] score:0.000281 class:"airliner"
[657] score:0.000014 class:"missile"
[833] score:0.000010 class:"submarine, pigboat, sub, U-boat"
[466] score:0.000010 class:"bullet train, bullet"

done
```

## 测试 Dynamic Shape

进入 Dynamic Shape Demo 目录：

```
cd ~/rknn-toolkit2/rknn-toolkit-lite2/examples/dynamic_shape
```

运行推理：

```
[root@openEuler dynamic_shape]# python3 test.py
W rknn-toolkit-lite2 version: 2.3.2
--> Load RKNN model
done
--> Init runtime environment
I RKNN: [16:57:46.389] RKNN Runtime Information, librknnrt version: 2.3.2 (429f97ae6b@2025-04-09T09:09:27)
I RKNN: [16:57:46.389] RKNN Driver Information, version: 0.9.8
I RKNN: [16:57:46.390] RKNN Model Information, version: 6, toolkit version: 2.3.2(compiler version: 2.3.2 (839b70f037@2025-04-03T10:34:04)), target: RKNPU f2, target platform: rk3576, framework name: Caffe, framework layout: NCHW, model inference type: dynamic_shape
done
--> Running model
model: mobilenet_v2

input shape: 1,3,224,224
W The input[0] need NHWC data format, but NCHW set, the data format and data buffer will be changed to NHWC.
-----TOP 5-----
[155] score:0.937500 class:"Shih-Tzu"
[204] score:0.002548 class:"Lhasa, Lhasa apso"
[154] score:0.001890 class:"Pekinese, Pekingese, Peke"
[283] score:0.000659 class:"Persian cat"
[284] score:0.000172 class:"Siamese cat, Siamese"

input shape: 1,3,160,160
W The input[0] need NHWC data format, but NCHW set, the data format and data buffer will be changed to NHWC.
-----TOP 5-----
[155] score:0.634766 class:"Shih-Tzu"
[154] score:0.295166 class:"Pekinese, Pekingese, Peke"
[204] score:0.030182 class:"Lhasa, Lhasa apso"
[194] score:0.001085 class:"Dandie Dinmont, Dandie Dinmont terrier"
[219] score:0.000291 class:"cocker spaniel, English cocker spaniel, cocker"

input shape: 1,3,256,256
W The input[0] need NHWC data format, but NCHW set, the data format and data buffer will be changed to NHWC.
-----TOP 5-----
[155] score:0.926758 class:"Shih-Tzu"
[154] score:0.008347 class:"Pekinese, Pekingese, Peke"
[204] score:0.004559 class:"Lhasa, Lhasa apso"
[193] score:0.001019 class:"Australian terrier"
[283] score:0.000481 class:"Persian cat"

done
```