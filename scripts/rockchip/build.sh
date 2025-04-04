#!/bin/bash

__usage="
Usage: build [OPTIONS]
Build Rockchip bootable images.
The target bootable compressed images will be generated in the build/YYYY-MM-DD folder of the directory where the build script is located.

Options: 
  --board BOARD_CONFIG                 Required! The config of target board in the boards folder, which defaults to firefly-rk3399.
  -n, --name IMAGE_NAME                The Rockchip image name to be built.
  -k, --kernel KERNEL_URL              The URL of kernel source's repository, which defaults to https://gitee.com/openeuler/rockchip-kernel.git.
  -b, --branch KERNEL_BRANCH           The branch name of kernel source's repository, which defaults to openEuler-20.03-LTS.
  -c, --config KERNEL_DEFCONFIG        The name/path of defconfig file when compiling kernel, which defaults to openeuler_rockchip_defconfig.
  -r, --repo REPO_INFO                 The URL/path of target repo file or list of repo's baseurls which should be a space separated list.
  -s, --spec SPEC                      The image's specification: headless, xfce, ukui, dde or the file path of rpmlist. The default is headless.
  --cores N                            The number of cpu cores to be used during making.
  -h, --help                           Show command help.
"

help()
{
    echo "$__usage"
    exit $1
}

used_param() {
    echo ""
    echo "Default args"
    echo "KERNEL_DEFCONFIG     : $default_defconfig"
    echo ""    
    echo "TARGET_BOARD         : $board"
    echo ""
    echo "KERNEL_BRANCH        : $branch"
    echo ""
}

default_param() {
    default_defconfig=openeuler_rockchip_defconfig
    board=firefly-rk3399
    ubootconfig=firefly-rk3399_defconfig
    dtb_name=rk3399-firefly
    platform=rockchip
    branch=openEuler-20.03-LTS
    repo_file="https://gitee.com/src-openeuler/openEuler-repos/raw/openEuler-20.03-LTS/generic.repo"
    kernel_url="https://gitee.com/openeuler/rockchip-kernel.git"
    workdir=$(pwd)/build
    name=${branch}-${board}-aarch64-alpha1
    make_cores=$(nproc)
}

save_param() {
    if [ -f $workdir/.param_last ]; then
        rm $workdir/.param_last
    fi
    if [ -f $workdir/.param ]; then
        mv $workdir/.param $workdir/.param_last
    fi
    echo "board=$board
default_defconfig=$default_defconfig
ubootconfig=$ubootconfig
dtb_name=$dtb_name
platform=$platform
branch=$branch
repo_file=$repo_file
kernel_url=$kernel_url
spec_param=$spec_param" > $workdir/.param
}

deppkg_install() {
    dnf makecache
    dnf install git wget make gcc bison dtc m4 flex bc openssl-devel tar dosfstools rsync parted dnf-plugins-core tar kpartx diffutils dracut uboot-tools -y
}

parseargs()
{
    if [ "x$#" == "x0" ]; then
        return 0
    fi

    while [ "x$#" != "x0" ];
    do
        if [ "x$1" == "x-h" -o "x$1" == "x--help" ]; then
            return 1
        elif [ "x$1" == "x" ]; then
            shift
        elif [ "x$1" == "x--board" ]; then
            board=`echo $2`
            shift
            shift
        elif [ "x$1" == "x-n" -o "x$1" == "x--name" ]; then
            name=`echo $2`
            shift
            shift
        elif [ "x$1" == "x-k" -o "x$1" == "x--kernel" ]; then
            kernel_url=`echo $2`
            shift
            shift
        elif [ "x$1" == "x-b" -o "x$1" == "x--branch" ]; then
            branch=`echo $2`
            shift
            shift
        elif [ "x$1" == "x-c" -o "x$1" == "x--config" ]; then
            default_defconfig=`echo $2`
            shift
            shift
        elif [ "x$1" == "x-r" -o "x$1" == "x--repo" ]; then
            repo_file=`echo $2`
            shift
            shift
        elif [ "x$1" == "x-s" -o "x$1" == "x--spec" ]; then
            spec_param=`echo $2`
            shift
            shift
        elif [ "x$1" == "x--cores" ]; then
            make_cores=`echo $2`
            shift
            shift
        else
            echo `date` - ERROR, UNKNOWN params "$@"
            return 2
        fi
    done
}

buildid=$(date +%Y%m%d%H%M%S)
builddate=${buildid:0:8}

ERROR(){
    echo `date` - ERROR, $* | tee -a ${log_dir}/${builddate}.log
}

LOG(){
    echo `date` - INFO, $* | tee -a ${log_dir}/${builddate}.log
}

default_param
parseargs "$@" || help $?

LOG "Selected board: ${board}."

cur_dir=$(cd $(dirname $0);pwd)

source ${cur_dir}/boards/${board}.conf

LOG "Board config: ${board}."
LOG "U-Boot config: ${ubootconfig}."
LOG "DeviceTree name: ${dtb_name}."
LOG "Target platform: ${platform}."

used_param
if [ ! -d $workdir ]; then
    mkdir $workdir
fi
save_param
log_dir=${workdir}/log
if [ ! -d ${log_dir} ];then mkdir -p ${log_dir}; fi
if [ -f $workdir/.done ];then
    LOG "Checking the previous build."
    if [[ $(cat $workdir/.done | grep u-boot) == "u-boot" && \
    $(cat $workdir/.done | grep bootimg) == "bootimg" && \
    $(cat $workdir/.done | grep rootfs) == "rootfs" && \
    $(cat $workdir/.done | grep image) == "image" ]];then
        LOG "Found complete build, clean build flag."
        rm $workdir/.done
        touch $workdir/.done
    fi
else
    deppkg_install
    touch $workdir/.done
fi

if [[ $(cat $workdir/.done | grep u-boot) != "u-boot" ]];then
    bash build_u-boot.sh
fi

if [[ $(cat $workdir/.done | grep bootimg) != "bootimg" ]];then
    bash build_boot.sh
fi

if [[ $(cat $workdir/.done | grep rootfs) != "rootfs" ]];then
    bash build_rootfs.sh
fi

bash gen_image.sh --board ${board}
