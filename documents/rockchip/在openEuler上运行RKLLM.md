- [描述](#描述)
- [在 openEuler 上运行 RKLLM](#在-openeuler-上运行-rkllm)
  - [下载 RKLLM 示例模型和示例代码](#下载-rkllm-示例模型和示例代码)
  - [安装 RKLLM 运行环境到系统](#安装-rkllm-运行环境到系统)
  - [运行 Qwen2 VL 示例](#运行-qwen2-vl-示例)
  - [运行 DeepSeek R1 Distill Qwen 模型](#运行-deepseek-r1-distill-qwen-模型)

# 描述

本文档介绍如何在 openEuler 的 Rockchip 设备上使用 RKNPU 运行 LLM。

参考的官方文档：

https://github.com/airockchip/rknn-llm/blob/main/doc/Rockchip_RKLLM_SDK_CN_1.2.1.pdf

Rockchip 提供的官方模型性能基准测试结果参考：

https://github.com/airockchip/rknn-llm/blob/main/benchmark.md

内核需求：需要支持 RKNPU 的内核，且 RKNPU 版本不低于 0.9.8。

可以通过以下命令来查看 RKNPU 版本。

```
[root@openEuler ~]# cat /sys/kernel/debug/rknpu/version
RKNPU driver: v0.9.8
```

测试设备：

1. Armsom Sige5 (RK3576)

openEuler 版本：openEuler 22.03 LTS SP3

镜像构建命令如下：

```
sudo bash build.sh --board armsom-sige5 \
            -n openEuler-22.03-LTS-SP3-Armsom-Sige5-aarch64-alpha1 \
            -k https://github.com/armbian/linux-rockchip.git \
            -b rk-6.1-rkr5.1 \
            -c rockchip_linux_defconfig \
            -r https://atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-22.03-LTS-SP3/generic.repo \
            -s headless
```

2. Firefly ROC-RK3588S-PC (RK3588S)

openEuler 版本：openEuler 22.03 LTS SP3

镜像构建命令如下：

```
sudo bash build.sh --board firefly-roc-rk3588s-pc \
            -n openEuler-22.03-LTS-SP3-Station-M3-aarch64-alpha1 \
            -k https://github.com/armbian/linux-rockchip.git \
            -b rk-6.1-rkr5.1 \
            -c rockchip_linux_defconfig \
            -r https://atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-22.03-LTS-SP3/generic.repo \
            -s headless
```

将上面构建成功的 openEuler 镜像刷写到开发板，之后就可以按照下面的文档安装 RKNPU 并运行推理。

# 在 openEuler 上运行 RKLLM

## 下载 RKLLM 示例模型和示例代码

### 下载模型

通过 Rockchip 官方提供的网盘地址下载模型：

网盘地址：https://meta.box.lenovo.com/v/link/view/ad7482f6712844b48902f07287ed3359

密码：`rkllm`

### 下载代码

经过测试，能在 openEuler 上运行的 SDK 版本为 1.2.1。

#### 通过 Github 下载代码

通过本操作可以从 Github 上下载 SDK 代码。

```
git clone --depth=1 https://github.com/airockchip/rknn-llm -b release-v1.2.1
```

#### 通过 Rockchip 官方提供的网盘地址下载代码

通过本操作可以从 Rockchip 官方提供的网盘地址下载 SDK 代码。

网盘地址：https://meta.zbox.filez.com/v/link/view/32d1fc76de7241a4a3c99f4829c25ac7

密码：`rkllm`

路径为：`SDK/1.2.1`

下载之后将其解压，得到文件夹 `rknn-llm`

## 安装 RKLLM 运行环境到系统

运行以下命令将 `rkllm` 运行环境安装到系统：

```
cp rknn-llm/rkllm-runtime/Linux/librkllm_api/include/rkllm.h /usr/include
cp rknn-llm/rkllm-runtime/Linux/librkllm_api/aarch64/librkllmrt.so /lib
cp rknn-llm/rkllm-runtime/Linux/librkllm_api/aarch64/librkllmrt.so /lib64
```

## 运行 Qwen2 VL 示例

对应的部署参考示例为：

https://github.com/airockchip/rknn-llm/tree/main/examples/Qwen2-VL_Demo

对于 `RK3576`，需要从网盘中下载以下模型：

```
1. rkllm_model_zoo/1.2.1/RK3576/Qwen2.5-VL-3B_Instruct/qwen2.5-vl-3b-w4a16_level1_rk3576.rkllm
2. rkllm_model_zoo/1.2.1/RK3576/Qwen2.5-VL-3B_Instruct/qwen2_5_vl_3b_vision_rk3576.rknn
```

对于 `RK3588`，需要从网盘中下载以下模型：

```
1. rkllm_model_zoo/1.2.1/RK3588/Qwen2.5-VL-3B_Instruct/qwen2.5-vl-3b-w8a8_level1_rk3588.rkllm
2. rkllm_model_zoo/1.2.1/RK3588/Qwen2.5-VL-3B_Instruct/qwen2_5_vl_3b_vision_rk3588.rknn
```

### 修改示例代码

进入示例源码位置

```
cd rknn-llm/examples/Qwen2-VL_Demo/deploy/src
```

修改以下文件：

```
main.cpp
```

#### 参数配置  

1. 启用多轮对话模式

   将 `keep_history` 参数设置为1可保留对话历史记录，避免每轮对话后缓存被清除。  
   如需手动清除缓存，请调用 `rkllm_clear_kv_cache` 函数：

   ```  
   rkllm_infer_params.keep_history = 0;  
   rkllm_clear_kv_cache(llmHandle, 1, nullptr, nullptr);  
   ```  

2. 自定义聊天模板  

   新版模型内置了提示词格式化模板，支持通过以下函数修改系统提示词、前缀和后缀内容：

   ```  
   rkllm_set_chat_template(llmHandle,   
      "<|im_start|>system\nYou are a helpful assistant.<|im_end|>\n",   
      "<|im_start|>user\n",   
      "<|im_end|>\n<|im_start|>assistant\n"  
   );  
   ```

### 编译运行 C++ Demo

进入 C++ 示例代码位置

```
cd rknn-llm/examples/Qwen2-VL_Demo/deploy
```

设置变量使用 openEuler 系统内的 GCC

```
GCC_COMPILER=aarch64-linux-gnu
```

创建和进入编译目录

```
mkdir build && cd build
```

编译前配置

```
cmake .. \
    -DCMAKE_CXX_COMPILER=aarch64-linux-gnu-g++ \
    -DCMAKE_C_COMPILER=aarch64-linux-gnu-gcc \
    -DCMAKE_BUILD_TYPE=Release -DCMAKE_SYSTEM_NAME=Linux \
    -DCMAKE_SYSTEM_PROCESSOR=aarch64
```

编译示例代码

```
make -j$(nproc)
make install
```

进入安装目录：

```
cd ../install/demo_Linux_aarch64
```

将网盘下载的以下两个模型文件放到当前目录：

对于 RK3576:

```
1. rkllm_model_zoo/1.2.1/RK3576/Qwen2.5-VL-3B_Instruct/qwen2.5-vl-3b-w4a16_level1_rk3576.rkllm
2. rkllm_model_zoo/1.2.1/RK3576/Qwen2.5-VL-3B_Instruct/qwen2_5_vl_3b_vision_rk3576.rknn
```

对于 RK3588:

```
1. rkllm_model_zoo/1.2.1/RK3588/Qwen2.5-VL-3B_Instruct/qwen2.5-vl-3b-w8a8_level1_rk3588.rkllm
2. rkllm_model_zoo/1.2.1/RK3588/Qwen2.5-VL-3B_Instruct/qwen2_5_vl_3b_vision_rk3588.rknn
```

设置使用当前目录下 `lib` 文件夹中提供的库

```
export LD_LIBRARY_PATH=./lib
```

对于 `RK3576` 开发板，运行 `rknn-llm/scripts/fix_freq_rk3576.sh` 来固定频率，使模型能够以最大性能运行，需要为开发板提供良好的散热条件。

如果是 `RK3588` 开发板，则需要运行 `rknn-llm/scripts/fix_freq_rk3588.sh`

运行结果如下：

```
[root@openEuler scripts]# bash fix_freq_rk3576.sh
NPU available frequencies:
300000000 400000000 500000000 600000000 700000000 800000000 900000000 950000000
Fix NPU max frequency:
950000000
CPU available frequencies:
408000 600000 816000 1008000 1200000 1416000 1608000 1800000 2016000 
408000 600000 816000 1008000 1200000 1416000 1608000 1800000 2016000 2208000 
Fix CPU max frequency:
2016000
2208000
GPU available frequencies:
cat: /sys/class/devfreq/27800000.gpu/cur_freq: No such file or directory
cat: /sys/class/devfreq/27800000.gpu/available_frequencies: No such file or directory
Fix GPU max frequency:
fix_freq_rk3576.sh: line 34: /sys/class/devfreq/27800000.gpu/governor: No such file or directory
fix_freq_rk3576.sh: line 35: /sys/class/devfreq/27800000.gpu/userspace/set_freq: No such file or directory
cat: /sys/class/devfreq/27800000.gpu/cur_freq: No such file or directory
DDR available frequencies:
528000000 1068000000 1560000000 2112000000
Fix DDR max frequency:
2112000000
```

由于 openEuler 使用的内核配置未开启 GPU 对应的模块，所以会出现以下 GPU 频率设置的错误，但是不会影响模型推理：

```
GPU available frequencies:
cat: /sys/class/devfreq/27800000.gpu/cur_freq: No such file or directory
cat: /sys/class/devfreq/27800000.gpu/available_frequencies: No such file or directory
Fix GPU max frequency:
fix_freq_rk3576.sh: line 34: /sys/class/devfreq/27800000.gpu/governor: No such file or directory
fix_freq_rk3576.sh: line 35: /sys/class/devfreq/27800000.gpu/userspace/set_freq: No such file or directory
cat: /sys/class/devfreq/27800000.gpu/cur_freq: No such file or directory
```

#### 纯文本测试

对于 RK3576，通过以下命令来运行 `qwen2.5-vl-3b-w4a16_level1` 模型的纯文本测试

```
./llm qwen2.5-vl-3b-w4a16_level1_rk3576.rkllm 128 512
```

对于 RK3588，通过以下命令来运行 `qwen2.5-vl-3b-w4a16_level1` 模型的纯文本测试

```
./llm qwen2.5-vl-3b-w8a8_level1_rk3588.rkllm 128 512
```

在 RK3576 上，输出如下：

```
[root@openEuler demo_Linux_aarch64]# ./llm qwen2.5-vl-3b-w4a16_level1_rk3576.rkllm 128 512
rkllm init start
I rkllm: rkllm-runtime version: 1.2.1, rknpu driver version: 0.9.8, platform: RK3576
I rkllm: loading rkllm model from qwen2.5-vl-3b-w4a16_level1_rk3576.rkllm
I rkllm: rkllm-toolkit version: 1.2.1, max_context_limit: 4096, npu_core_num: 2, target_platform: RK3576, model_dtype: W4A16
I rkllm: Enabled cpus: [4, 5, 6, 7]
I rkllm: Enabled cpus num: 4
I rkllm: Using mrope
rkllm init success
main: Model loaded in  3862.66 ms

**********************可输入以下问题对应序号获取回答/或自定义输入********************

[0] 把下面的现代文翻译成文言文: 到了春风和煦，阳光明媚的时候，湖面平静，没有惊涛骇浪，天色湖光相连，一片碧绿，广阔无际；沙洲上的鸥鸟，时而飞翔，时而停歇，美丽的鱼游来游去，岸上与小洲上的花草，青翠欲滴。
[1] 以咏梅为题目，帮我写一首古诗，要求包含梅花、白雪等元素。
[2] 上联: 江边惯看千帆过
[3] 把这句话翻译成中文: Knowledge can be acquired from many sources. These include books, teachers and practical experience, and each has its own advantages. The knowledge we gain from books and formal education enables us to learn about things that we have no opportunity to experience in daily life. We can also develop our analytical skills and learn how to view and interpret the world around us in different ways. Furthermore, we can learn from the past by reading books. In this way, we won't repeat the mistakes of others and can build on their achievements.
[4] 把这句话翻译成英文: RK3588是新一代高端处理器，具有高算力、低功耗、超强多媒体、丰富数据接口等特点

*************************************************************************

I rkllm: reset chat template:
I rkllm: system_prompt: <|im_start|>system\nYou are a helpful assistant.<|im_end|>\n
I rkllm: prompt_prefix: <|im_start|>user\n
I rkllm: prompt_postfix: <|im_end|>\n<|im_start|>assistant\n
W rkllm: Calling rkllm_set_chat_template will disable the internal automatic chat template parsing, including enable_thinking. Make sure your custom prompt is complete and valid.

user:
```

此时可以进行问答：

```
user: 把这句话翻译成英文:openEuler面向数字基础设施四大核心场景（服务器、云计算、边缘计算、嵌入式），全面支持ARM、x86、RISC-V、loongArch、PowerPC、SW-64等多样性计算架构
robot: OpenEuler supports four core scenarios in digital infrastructure (server, cloud computing, edge computing, embedded), fully supporting ARM, x86, RISC-V, loongArch, PowerPC, and other diversity of computing architectures such as SW-64.
```

在 RK3588 上，输出如下：

```
[root@openEuler demo_Linux_aarch64]# ./llm qwen2.5-vl-3b-w8a8_level1_rk3588.rkllm 128 512
rkllm init start
I rkllm: rkllm-runtime version: 1.2.1, rknpu driver version: 0.9.8, platform: RK3588
I rkllm: loading rkllm model from qwen2.5-vl-3b-w8a8_level1_rk3588.rkllm
I rkllm: rkllm-toolkit version: 1.2.1, max_context_limit: 4096, npu_core_num: 3, target_platform: RK3588, model_dtype: W8A8
I rkllm: Enabled cpus: [4, 5, 6, 7]
I rkllm: Enabled cpus num: 4
I rkllm: Using mrope
rkllm init success
main: Model loaded in  3400.27 ms

**********************可输入以下问题对应序号获取回答/或自定义输入********************

[0] 把下面的现代文翻译成文言文: 到了春风和煦，阳光明媚的时候，湖面平静，没有惊涛骇浪，天色湖光相连，一片碧绿，广阔无际；沙洲上的鸥鸟，时而飞翔，时而停歇，美丽的鱼游来游去，岸上与小洲上的花草，青翠欲滴。
[1] 以咏梅为题目，帮我写一首古诗，要求包含梅花、白雪等元素。
[2] 上联: 江边惯看千帆过
[3] 把这句话翻译成中文: Knowledge can be acquired from many sources. These include books, teachers and practical experience, and each has its own advantages. The knowledge we gain from books and formal education enables us to learn about things that we have no opportunity to experience in daily life. We can also develop our analytical skills and learn how to view and interpret the world around us in different ways. Furthermore, we can learn from the past by reading books. In this way, we won't repeat the mistakes of others and can build on their achievements.
[4] 把这句话翻译成英文: RK3588是新一代高端处理器，具有高算力、低功耗、超强多媒体、丰富数据接口等特点

*************************************************************************

I rkllm: reset chat template:
I rkllm: system_prompt: <|im_start|>system\nYou are a helpful assistant.<|im_end|>\n
I rkllm: prompt_prefix: <|im_start|>user\n
I rkllm: prompt_postfix: <|im_end|>\n<|im_start|>assistant\n
W rkllm: Calling rkllm_set_chat_template will disable the internal automatic chat template parsing, including enable_thinking. Make sure your custom prompt is complete and valid.

user: 
```

此时可以问答：

```
user: 把这句话翻译成英文:openEuler面向数字基础设施四大核心场景（服务器、云计算、边缘计算、嵌入式），全面支持ARM、x86、RISC-V、loongArch、PowerPC、SW-64等多样性计算架构
robot: OpenEuler supports the four core scenarios of digital infrastructure (servers, cloud computing, edge computing, and embedded systems) with full support for ARM, x86, RISC-V, LoongArch, PowerPC, and SW-64, among others.
```

#### imgenc 测试和多模态测试

对于 RK3576，运行以下代码进行 `imgenc` 测试：

```
./imgenc qwen2_5_vl_3b_vision_rk3576.rknn demo.jpg 3
```

对于 RK3588，运行以下代码进行 `imgenc` 测试：

```
./imgenc qwen2_5_vl_3b_vision_rk3588.rknn demo.jpg 3
```

对于 RK3576，运行以下代码进行多模态测试：

```
./demo demo.jpg qwen2_5_vl_3b_vision_rk3576.rknn qwen2.5-vl-3b-w4a16_level1_rk3576.rkllm 128 512 3
```

对于 RK3588，运行以下代码进行多模态测试：

```
./demo demo.jpg qwen2_5_vl_3b_vision_rk3588.rknn qwen2.5-vl-3b-w8a8_level1_rk3588.rkllm 128 512 3
```

以上两个测试会出现段错误。经测试，在 Ubuntu 24.04 上测试也会出现相同情况，所以不是由于 openEuler 导致的此错误。

## 运行 DeepSeek R1 Distill Qwen 模型

在本部分将会运行 `DeepSeek R1 Distill Qwen 1.5B` 和 `DeepSeek R1 Distill Qwen 7B` 模型。

对应的部署参考示例为：

https://github.com/airockchip/rknn-llm/tree/main/examples/DeepSeek-R1-Distill-Qwen-1.5B_Demo

### 模型下载

对于 RK3576，需要从网盘中下载以下两个文件：

```
1. rkllm_model_zoo/1.1.4/RK3576/DeepSeek_R1_Distill/DeepSeek-R1-Distill-Qwen-1.5B_W4A16_RK3576.rkllm
2. rkllm_model_zoo/1.1.4/RK3576/DeepSeek_R1_Distill/DeepSeek-R1-Distill-Qwen-7B_W4A16_RK3576.rkllm
```

对于 RK3588，需要从网盘中下载以下两个文件：

```
1. rkllm_model_zoo/1.1.4/RK3588/DeepSeek_R1_Distill/DeepSeek-R1-Distill-Qwen-1.5B_W8A8_RK3588.rkllm
2. rkllm_model_zoo/1.1.4/RK3588/DeepSeek_R1_Distill/DeepSeek-R1-Distill-Qwen-7B_W8A8_RK3588.rkllm
```

### 编译运行 C++ Demo

#### 配置及编译示例代码

进入 C++ 示例代码位置

```
cd rknn-llm/examples/DeepSeek-R1-Distill-Qwen-1.5B_Demo/deploy
```

设置变量使用 openEuler 系统内的 GCC

```
GCC_COMPILER=aarch64-linux-gnu
```

创建和进入编译目录

```
mkdir build && cd build
```

编译前配置

```
cmake .. \
    -DCMAKE_CXX_COMPILER=aarch64-linux-gnu-g++ \
    -DCMAKE_C_COMPILER=aarch64-linux-gnu-gcc \
    -DCMAKE_BUILD_TYPE=Release -DCMAKE_SYSTEM_NAME=Linux \
    -DCMAKE_SYSTEM_PROCESSOR=aarch64
```

编译示例代码

```
make -j$(nproc)
make install
```

进入安装目录：

```
cd ../install/demo_Linux_aarch64
```

将从网盘中下载的 `DeepSeek R1 Distill Qwen 1.5B` 和 `DeepSeek R1 Distill Qwen 7B` 模型放到当前目录

对于 RK3576:

```
1. rkllm_model_zoo/1.1.4/RK3576/DeepSeek_R1_Distill/DeepSeek-R1-Distill-Qwen-1.5B_W4A16_RK3576.rkllm
2. rkllm_model_zoo/1.1.4/RK3576/DeepSeek_R1_Distill/DeepSeek-R1-Distill-Qwen-7B_W4A16_RK3576.rkllm
```

对于 RK3588:

```
1. rkllm_model_zoo/1.1.4/RK3588/DeepSeek_R1_Distill/DeepSeek-R1-Distill-Qwen-1.5B_W8A8_RK3588.rkllm
2. rkllm_model_zoo/1.1.4/RK3588/DeepSeek_R1_Distill/DeepSeek-R1-Distill-Qwen-7B_W8A8_RK3588.rkllm
```

设置使用本目录中 lib 文件夹下提供的库

```
export LD_LIBRARY_PATH=./lib
```

设置 RKLLM 日志等级为 `1`

```
export RKLLM_LOG_LEVEL=1
```

对于 `RK3576` 开发板，运行 `rknn-llm/scripts/fix_freq_rk3576.sh` 来固定频率，使模型能够以最大性能运行，需要为开发板提供良好的散热条件。

如果是 `RK3588` 开发板，则需要运行 `rknn-llm/scripts/fix_freq_rk3588.sh`

```
bash fix_freq_rk3576.sh
```

#### 运行 DeepSeek R1 Distill Qwen 1.5B 模型

对于 RK3576，通过以下命令来运行 DeepSeek R1 Distill Qwen 1.5B 模型

```
./llm_demo DeepSeek-R1-Distill-Qwen-1.5B_W4A16_RK3576.rkllm 2048 4096
```

输出如下：

```
[root@openEuler demo_Linux_aarch64]# ./llm_demo DeepSeek-R1-Distill-Qwen-1.5B_W4A16_RK3576.rkllm 2048 4096
rkllm init start
I rkllm: rkllm-runtime version: 1.2.1, rknpu driver version: 0.9.8, platform: RK3576
I rkllm: loading rkllm model from DeepSeek-R1-Distill-Qwen-1.5B_W4A16_RK3576.rkllm
I rkllm: rkllm-toolkit version: unknown, max_context_limit: 4096, npu_core_num: 2, target_platform: RK3576, model_dtype: W4A16
I rkllm: Enabled cpus: [4, 5, 6, 7]
I rkllm: Enabled cpus num: 4
rkllm init success

**********************可输入以下问题对应序号获取回答/或自定义输入********************

[0] 现有一笼子，里面有鸡和兔子若干只，数一数，共有头14个，腿38条，求鸡和兔子各有多少只？
[1] 有28位小朋友排成一行,从左边开始数第10位是学豆,从右边开始数他是第几位?

*************************************************************************


user:
```

当出现 `user:` 时，可以进行问答：

```
user: 把这句话翻译成英文:openEuler面向数字基础设施四大核心场景（服务器、云计算、边缘计算、嵌入式），全面支持ARM、x86、RISC-V、loongArch、PowerPC、SW-64等多样性计算架构       
robot: <think>
嗯，用户给了一个任务，让我把一段中文翻译成英文。这段话是关于OpenEuler面向数字基础设施四大核心场景（服务器、云计算、边缘计算、嵌入式）的全面支持，包括ARM、x86、RISC-V、LoongArch、PowerPC和SW-64这些计算架构。

首先，我需要理解用户的需求。看起来这是一个技术文档或者产品说明的一部分，可能用于向外部展示或向客户介绍OpenEuler的技术能力。所以翻译要准确，同时保持专业性，因为涉及到计算机科学和技术领域。

接下来，我要分解原文的结构。原文分为两部分：首先是面向四大核心场景的支持，然后是具体支持的计算架构列表。因此，在翻译时，我需要确保每个部分都清晰明了，并且用正确的术语来表达。

第一部分：“面向数字基础设施四大核心场景（服务器、云计算、边缘计算、嵌入式）”。这里有几个关键点：OpenEuler，数字基础设施，四大核心场景，以及具体的计算架构。所以，翻译时要准确传达这些概念，比如“four core computing scenarios”对应英文中的“four core computing scenarios”。

第二部分：“全面支持ARM、x86、RISC-Veronese、LoongArch、PowerPC、SW-64等多样性计算架构”。这里需要列出多个计算架构，并且说明它们的多样性。因此，我需要用连字符连接这些架构名称，同时确保每个都用正确的缩写或全称。

在翻译过程中，要注意术语的一致性。比如，“ARM”是Arithmetic Runtime Environment，而“x86”是x86-平台，所以要准确使用英文词汇。对于RISC-V、LoongArch、PowerPC和SW-64，它们的缩写分别是“RISC-V”，“LoongArch”，“Power Platform”（可能需要确认），“SW-64”是Software-Defined Platform。

另外，用户提到“全面支持”，所以翻译时要表现出全面性，比如“comprehensive support”。

最后，检查整个句子的流畅性和专业性，确保没有遗漏任何关键信息，并且用词准确。这样用户在使用这段翻译时，能够清晰传达OpenEuler的技术能力和服务范围。
</think>

The OpenEuler platform provides comprehensive support for four core computing scenarios: servers, cloud computing, edge computing, and embedded systems. It offers extensive support for a variety of compute architectures including ARM, x86, RISC-V, LoongArch, PowerPlatform, and SW-64.
```

对于 RK3588，通过以下命令来运行 DeepSeek R1 Distill Qwen 1.5B 模型

```
./llm_demo DeepSeek-R1-Distill-Qwen-1.5B_W8A8_RK3588.rkllm 2048 4096
```

输出如下：

```
[root@openEuler demo_Linux_aarch64]# ./llm_demo DeepSeek-R1-Distill-Qwen-1.5B_W8A8_RK3588.rkllm 2048 4096
rkllm init start
I rkllm: rkllm-runtime version: 1.2.1, rknpu driver version: 0.9.8, platform: RK3588
I rkllm: loading rkllm model from DeepSeek-R1-Distill-Qwen-1.5B_W8A8_RK3588.rkllm
I rkllm: rkllm-toolkit version: unknown, max_context_limit: 4096, npu_core_num: 3, target_platform: RK3588, model_dtype: W8A8
I rkllm: Enabled cpus: [4, 5, 6, 7]
I rkllm: Enabled cpus num: 4
rkllm init success

**********************可输入以下问题对应序号获取回答/或自定义输入********************

[0] 现有一笼子，里面有鸡和兔子若干只，数一数，共有头14个，腿38条，求鸡和兔子各有多少只？
[1] 有28位小朋友排成一行,从左边开始数第10位是学豆,从右边开始数他是第几位?

*************************************************************************


user: 
```

当出现 `user:` 时，可以进行问答：

```
user: 把这句话翻译成英文:openEuler面向数字基础设施四大核心场景（服务器、云计算、边缘计算、嵌入式），全面支持ARM、x86、RISC-V、loongArch、PowerPC、SW-64等多样性计算架构
robot: <think>
嗯，用户让我把一段中文翻译成英文。这段话是关于OpenEuler面向数字基础设施的四大核心场景：服务器、云计算、边缘计算和嵌入式系统。同时，它支持ARM、x86、RISC-V、Longix、PowerPC和SW-64这些架构。

首先，我需要准确理解每个部分的意思。四大核心场景包括服务器、云计算、边缘计算和嵌入式系统。这些都是数字基础设施的重要组成部分，分别对应不同的应用场景。然后是OpenEuler的支持的多种计算架构，这可能意味着它能够处理各种不同的硬件平台，以适应不同需求。

接下来，我要考虑翻译的关键点。比如，“面向”这个词，通常在技术文档中用来强调支持的功能或架构。所以“全面支持”可以译为“comprehensive support”。数字基础设施方面，应该用如“digital infrastructure”这样的词汇。

然后是每个核心场景的名称，中文里通常是“server”，“cloud computing”，“边缘计算”和“embedded systems”。在英文中，这些分别对应为“server”, “cloud computing”, “edge computing”和“embedded systems”。

接下来是各种计算架构。ARM、x86、RISC-V、Longix、PowerPC和SW-64都是不同的处理器架构，中文里通常用“architectures”，所以翻译成“architectures”比较合适。

最后，整个句子的结构需要保持流畅和专业性。可能需要调整一些连接词，比如“全面支持”可以译为“comprehensive support”，而“核心场景”则是“core scenarios”。

综合以上分析，我应该先逐句翻译，确保每个部分都准确传达原意，并且整体语序自然。同时，注意术语的准确性，避免直译导致的误解。

现在，开始逐句翻译：

1. “面向数字基础设施四大核心场景（服务器、云计算、边缘计算、嵌入式系统）”可以译为“Comprehensive support for OpenEuler digital infrastructure core scenarios (server, cloud computing, edge computing, embedded systems)”。

2. 接下来是支持的多样性计算架构：“全面支持ARM、x86、RISC-V、Longix、PowerPC和SW-64等多样性计算架构”可以译为“Comprehensive support for a variety of compute architectures including ARM, x86, RISC-V, Longix, PowerPC, and SW-64”。

这样组合起来，整个句子就完整了。检查一下是否有遗漏或不通顺的地方，确保翻译准确且自然。

最后，再通读一遍，看看有没有更好的表达方式，比如调整一些连接词或者术语的使用，以提升整体流畅度和专业性。
</think>

Comprehensive support for OpenEuler digital infrastructure core scenarios (server, cloud computing, edge computing, embedded systems) is available across a variety of compute architectures including ARM, x86, RISC-V, Longix, PowerPC, and SW-64.
```

#### DeepSeek R1 Distill Qwen 1.5B 模型性能分析

在每一次对话完成之后，会输出对模型的性能分析

在 RK3576 上，输出如下：

```
I rkllm: --------------------------------------------------------------------------------------
I rkllm:  Model init time (ms)  11067.79                                                                   
I rkllm: --------------------------------------------------------------------------------------
I rkllm:  Stage         Total Time (ms)  Tokens    Time per Token (ms)      Tokens per Second      
I rkllm: --------------------------------------------------------------------------------------
I rkllm:  Prefill       524.64           64        8.20                     121.99                 
I rkllm:  Generate      43402.61         531       81.74                    12.23                  
I rkllm: --------------------------------------------------------------------------------------
I rkllm:  Peak Memory Usage (GB)
I rkllm:  1.11        
I rkllm: --------------------------------------------------------------------------------------
```

在 RK3588 上，输出如下：

```
I rkllm: --------------------------------------------------------------------------------------
I rkllm:  Model init time (ms)  6110.45                                                                    
I rkllm: --------------------------------------------------------------------------------------
I rkllm:  Stage         Total Time (ms)  Tokens    Time per Token (ms)      Tokens per Second      
I rkllm: --------------------------------------------------------------------------------------
I rkllm:  Prefill       213.42           58        3.68                     271.76                 
I rkllm:  Generate      40298.16         615       65.53                    15.26                  
I rkllm: --------------------------------------------------------------------------------------
I rkllm:  Peak Memory Usage (GB)
I rkllm:  1.71        
I rkllm: --------------------------------------------------------------------------------------
```

#### DeepSeek R1 Distill Qwen 1.5B 模型内存占用情况

对于 RK3576，加载模型前：

```
[root@openEuler ~]# free -m
               total        used        free      shared  buff/cache   available
Mem:            7935         238        4139          25        3667        7696
Swap:              0           0           0
```

对于 RK3576，加载模型后：

```
[root@openEuler ~]# free -m
               total        used        free      shared  buff/cache   available
Mem:            7935        1364        2133         970        5493        6571
Swap:              0           0           0
```

对于 RK3588，加载模型前：

```
[root@openEuler demo_Linux_aarch64]# free -m
               total        used        free      shared  buff/cache   available
Mem:            7927         318        7331           2         361        7608
Swap:              0           0           0
```

对于 RK3588，加载模型后：

```
[root@openEuler demo_Linux_aarch64]# free -m
               total        used        free      shared  buff/cache   available
Mem:            7927        2067        4083        1568        3426        5859
Swap:              0           0           0
```

#### 运行 DeepSeek R1 Distill Qwen 7B 模型

在 RK3576 上，通过以下命令来运行 DeepSeek R1 Distill Qwen 7B 模型

```
./llm_demo DeepSeek-R1-Distill-Qwen-7B_W4A16_RK3576.rkllm 2048 4096
```

输出如下：

```
[root@openEuler demo_Linux_aarch64]# ./llm_demo DeepSeek-R1-Distill-Qwen-7B_W4A16_RK3576.rkllm 2048 4096
rkllm init start
I rkllm: rkllm-runtime version: 1.2.1, rknpu driver version: 0.9.8, platform: RK3576
I rkllm: loading rkllm model from DeepSeek-R1-Distill-Qwen-7B_W4A16_RK3576.rkllm
I rkllm: rkllm-toolkit version: 1.1.4b7, max_context_limit: 4096, npu_core_num: 2, target_platform: RK3576, model_dtype: W4A16
I rkllm: Enabled cpus: [4, 5, 6, 7]
I rkllm: Enabled cpus num: 4
rkllm init success

**********************可输入以下问题对应序号获取回答/或自定义输入********************

[0] 现有一笼子，里面有鸡和兔子若干只，数一数，共有头14个，腿38条，求鸡和兔子各有多少只？
[1] 有28位小朋友排成一行,从左边开始数第10位是学豆,从右边开始数他是第几位?

*************************************************************************


user:
```

当出现 `user:` 时，可以进行问答：

```
user: 把这句话翻译成英文:openEuler面向数字基础设施四大核心场景（服务器、云计算、边缘计算、嵌入式），全面支持ARM、x86、RISC-V、loongArch、PowerPC、SW-64等多样性计算架构       
robot: 嗯，用户让我把一段中文翻译成英文。看起来是关于openEuler的数字基础设施支持情况。首先，我需要仔细阅读并理解原文内容。

原文提到的是openEuler面向四个核心场景：服务器、云计算、边缘计算和嵌入式设备，全面支持多种计算架构。这些架构包括ARM、x86、RISC-V、loongArch、PowerPC、SW-64等等。

我的目标是准确传达出每个部分的信息，同时确保术语的正确翻译。比如，“数字基础设施”可以译为“digital infrastructure”，而“嵌入式”则是“embedded devices”。

接下来，我需要处理每个具体的架构名称，确保它们在英文中有对应的正确术语。例如，ARM指的是ARM架构，x86是Intel x86架构，RISC-V是RISC Reduced Instruction Set Computer架构，loongArch是中国的某种多核处理器架构，PowerPC则是IBM的架构，SW-64可能是指某种64位的超级 widening。

在翻译过程中，我需要确保每个术语都准确无误，并且保持原文的信息完整。此外，句子的流畅性和专业性也很重要，特别是在技术文档中，准确性是关键。

最后，我会检查整个翻译是否符合英文的技术文档标准，是否有遗漏或错误的地方，确保用户的需求得到满足。
</think>

openEuler is designed to support the digital infrastructure's four core scenarios: server, cloud computing, edge computing, and embedded devices. It provides comprehensive support for diverse computing architectures such as ARM, x86, RISC-V, loongArch, PowerPC, SW-64, etc., ensuring compatibility across various computational needs.
```

在 RK3588 上，通过以下命令来运行 DeepSeek R1 Distill Qwen 7B 模型

```
./llm_demo DeepSeek-R1-Distill-Qwen-7B_W8A8_RK3588.rkllm 2048 4096
```

输出如下：

```
[root@openEuler demo_Linux_aarch64]# ./llm_demo DeepSeek-R1-Distill-Qwen-7B_W8A8_RK3588.
rkllm 2048 4096
rkllm init start
I rkllm: rkllm-runtime version: 1.2.1, rknpu driver version: 0.9.8, platform: RK3588
I rkllm: loading rkllm model from DeepSeek-R1-Distill-Qwen-7B_W8A8_RK3588.rkllm
I rkllm: rkllm-toolkit version: unknown, max_context_limit: 4096, npu_core_num: 3, target_platform: RK3588, model_dtype: W8A8
I rkllm: Enabled cpus: [4, 5, 6, 7]
I rkllm: Enabled cpus num: 4
rkllm init success

**********************可输入以下问题对应序号获取回答/或自定义输入********************

[0] 现有一笼子，里面有鸡和兔子若干只，数一数，共有头14个，腿38条，求鸡和兔子各有多少只？
[1] 有28位小朋友排成一行,从左边开始数第10位是学豆,从右边开始数他是第几位?

*************************************************************************


user: 
```

当出现 `user:` 时，可以进行问答：

```
user: 把这句话翻译成英文:openEuler面向数字基础设施四大核心场景（服务器、云计算、边缘计算、嵌入式），全面支持ARM、x86、RISC-V、loongArch、PowerPC、SW-64等多样性计算架构
robot: 嗯，用户让我把一段中文翻译成英文。看起来是关于openEuler的数字基础设施支持和计算架构。首先，我需要理解原文的意思。

原文提到“openEuler面向数字基础设施四大核心场景”，这四个场景包括服务器、云计算、边缘计算和嵌入式系统。然后，它说全面支持ARM、x86、RISC-V、loongArch、PowerPC、SW-64等多样性计算架构。

我应该先翻译这些关键术语。比如，“数字基础设施”可以译为“digital infrastructure”，而“四大核心场景”则是“four core scenarios”。接下来，每个具体的场景要准确对应，比如“服务器”是“servers”，云计算是“cloud computing”，边缘计算是“edge computing”，嵌入式是“embedded systems”。

然后是计算架构部分。ARM、x86这些缩写需要正确翻译，比如ARM是“ARM”，x86是“x86”。RISC-V是指RISC-V。loongArch是龙架构，应该译为“LongArch”，PowerPC是帕罗奥图处理器，直接音译为“PowerPC”，SW-64则是“SW-64”。

接下来，句子结构要流畅。原文的主干是“openEuler面向...四大核心场景，全面支持...计算架构”。翻译时可以调整为被动语态，比如“openEuler is designed to support”。

最后，检查整个翻译是否准确传达了原意，确保术语正确无误，并且句子结构清晰。
</think>

openEuler is designed to support four core scenarios in digital infrastructure: servers, cloud computing, edge computing, and embedded systems. It provides comprehensive support for diverse computing architectures such as ARM, x86, RISC-V, LongArch, PowerPC, and SW-64.
```

#### DeepSeek R1 Distill Qwen 7B 模型性能分析

在每一次对话完成之后，会输出对模型的性能分析

对于 RK3576，输出如下：

```
I rkllm: --------------------------------------------------------------------------------------
I rkllm:  Model init time (ms)  7138.85                                                                    
I rkllm: --------------------------------------------------------------------------------------
I rkllm:  Stage         Total Time (ms)  Tokens    Time per Token (ms)      Tokens per Second      
I rkllm: --------------------------------------------------------------------------------------
I rkllm:  Prefill       1470.13          64        22.97                    43.53                  
I rkllm:  Generate      93812.50         344       272.71                   3.67                   
I rkllm: --------------------------------------------------------------------------------------
I rkllm:  Peak Memory Usage (GB)
I rkllm:  3.97        
I rkllm: --------------------------------------------------------------------------------------
```

对于 RK3588，输出如下：

```
I rkllm: --------------------------------------------------------------------------------------
I rkllm:  Model init time (ms)  27383.87                                                                   
I rkllm: --------------------------------------------------------------------------------------
I rkllm:  Stage         Total Time (ms)  Tokens    Time per Token (ms)      Tokens per Second      
I rkllm: --------------------------------------------------------------------------------------
I rkllm:  Prefill       877.90           60        14.63                    68.35                  
I rkllm:  Generate      94886.94         388       244.55                   4.09                   
I rkllm: --------------------------------------------------------------------------------------
I rkllm:  Peak Memory Usage (GB)
I rkllm:  7.05        
I rkllm: --------------------------------------------------------------------------------------
```

#### DeepSeek R1 Distill Qwen 7B 模型内存占用情况

对于 RK3576，加载模型前：

```
[root@openEuler ~]# free -m
               total        used        free      shared  buff/cache   available
Mem:            7935         247        1761          25        6036        7688
Swap:              0           0           0
```

对于 RK3588，加载模型后：

```
[root@openEuler ~]# free -m
               total        used        free      shared  buff/cache   available
Mem:            7935        4310          43        3775        7442        3625
Swap:              0           0           0
```

对于 RK3588，加载模型前：

```
[root@openEuler ~]# free -m
               total        used        free      shared  buff/cache   available
Mem:            7927         319        7243           2         448        7608
Swap:              0           0           0
```

对于 RK3588，加载模型后：

```
[root@openEuler ~]# free -m
               total        used        free      shared  buff/cache   available
Mem:            7927        7586          48        6945        7319         340
Swap:              0           0           0
```