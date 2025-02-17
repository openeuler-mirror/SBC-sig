#!/bin/bash

__usage="
Usage: build_u-boot [OPTIONS]
Build openEuler SBCs u-boot image.
The target files idbloader.img and u-boot.itb will be generated in the build/u-boot folder of the directory where the build_u-boot.sh script is located.

Options: 
  --board, BOARD            Required! The config of target board in the boards folder, which defaults to firefly-rk3399.
  --cores N                 The number of cpu cores to be used during making.
  -h, --help                Show command help.
"

help()
{
    echo "$__usage"
    exit $1
}

default_param() {
    board=firefly-rk3399
    workdir=$(pwd)/build
    u_boot_url="https://gitlab.arm.com/systemready/firmware-build/u-boot.git"
    rk3399_bl31_url="https://github.com/rockchip-linux/rkbin/raw/master/bin/rk33/rk3399_bl31_v1.36.elf"
    log_dir=$workdir/log
    nonfree_bin_dir=${workdir}/../bin
    make_cores=$(nproc)
}

local_param(){
    if [ -f $workdir/.param ]; then
        board=$(cat $workdir/.param | grep board)
        board=${board:6}
    fi
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

build_u-boot() {
    cd $workdir
    if [ -d u-boot ];then
        cd u-boot
        remote_url_exist=`git remote -v | grep "origin"`
        remote_url=`git ls-remote --get-url origin`
        if [[ ${remote_url_exist} = "" || ${remote_url} != ${u_boot_url} ]]; then
            cd ../
            rm -rf $workdir/u-boot
            git clone --depth=1 -b ${u_boot_ver} ${u_boot_url}
            if [[ $? -eq 0 ]]; then
                LOG "clone u-boot done."
            else
                ERROR "clone u-boot failed."
                exit 1
            fi
        fi
    else
        git clone --depth=1 -b ${u_boot_ver} ${u_boot_url}
        LOG "clone u-boot done."
    fi
    cd $workdir/u-boot
    if [[ -f $workdir/u-boot/u-boot.itb && -f $workdir/u-boot/idbloader.img ]];then
        LOG "u-boot is the latest"
    else
        if [ -f bl31.elf ];then rm bl31.elf; fi
        wget -O bl31.elf ${rk3399_bl31_url}
        if [ ! -f bl31.elf ]; then
            ERROR "arm-trusted-firmware(bl31.elf) can not be found!"
            exit 2
        fi
        make ARCH=arm $ubootconfig
        make ARCH=arm -j${make_cores}
        make ARCH=arm u-boot.itb -j${make_cores}
        LOG "make u-boot done."
    fi
    if [ ! -f u-boot.itb ]; then
        ERROR "make u-boot failed!"
        exit 2
    fi

}

use_prebuild_u-boot() {
    if [ -d $workdir/u-boot ]; then
        rm -rf $workdir/u-boot
    fi

    mkdir $workdir/u-boot
    if [[ "x${platform}" == "xrockchip" ]]; then
        cp ${local_uboot_dir}/* $workdir/u-boot
    elif [[ "x${platform}" == "xphytium" ]]; then
        cp ${local_uboot_dir}/fip-all-sd-boot.bin $workdir/u-boot
        mkenvimage -s 0x1000 -o $workdir/u-boot/env.bin ${local_uboot_dir}/env.txt
        dd if=$workdir/u-boot/env.bin of=$workdir/u-boot/fip-all-sd-boot.bin bs=1k seek=1472 conv=notrunc
    else
        echo "target u-boot can not found!"
        exit 2
    fi
}

set -e
u_boot_ver="v2020.10"
default_param
local_param
parseargs "$@" || help $?

source $workdir/../boards/${board}.conf

if [ ! -d $workdir ]; then
    mkdir $workdir
fi
if [ ! -d ${log_dir} ];then mkdir -p ${log_dir}; fi
if [ ! -f $workdir/.done ];then
    touch $workdir/.done
fi
sed -i 's/u-boot//g' $workdir/.done
LOG "build u-boot..."

if [ "x$ubootconfig" == "xnone" ]; then
    use_prebuild_u-boot
else
    build_u-boot
fi

LOG "The bootloader files are generated in the ${workdir}/u-boot."
echo "u-boot" >> $workdir/.done
