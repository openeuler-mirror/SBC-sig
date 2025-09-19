#!/bin/bash
set -e
set -x

__usage="
Usage: build [OPTIONS]
Build openEuler bootable images.
The target bootable compressed images will be generated in the build/YYYY-MM-DD folder of the directory where the build script is located.

Options: 
  --board BOARD_CONFIG                 Required! The config of target board in the boards folder, which defaults to firefly-rk3399.
  -n, --name IMAGE_NAME                The openEuler image name to be built.
  -k, --kernel KERNEL_URL              The URL of kernel source's repository, which defaults to https://gitee.com/openeuler/rockchip-kernel.git.
  -b, --branch KERNEL_BRANCH           The branch name of kernel source's repository, which defaults to openEuler-20.03-LTS.
  -c, --config KERNEL_DEFCONFIG        The name/path of defconfig file when compiling kernel, which defaults to openeuler_rockchip_defconfig.
  -r, --repo REPO_INFO                 The URL/path of target repo file or list of repo's baseurls which should be a space separated list.
  -s, --spec SPEC                      The image's specification: headless, xfce, ukui, dde, gnome, devstation or the file path of rpmlist. The default is headless.
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
    nonfree_bin_dir=${cur_dir}/bin/rockchip
    workdir=${cur_dir}/build
    name=${branch}-${board}-aarch64-alpha1
    make_cores=$(nproc)
}

save_param() {
    if [ -f ${workdir}/.param_last ]; then
        rm ${workdir}/.param_last
    fi
    if [ -f ${workdir}/.param ]; then
        mv ${workdir}/.param ${workdir}/.param_last
    fi
    echo "board=$board
default_defconfig=$default_defconfig
ubootconfig=$ubootconfig
dtb_name=$dtb_name
platform=$platform
branch=$branch
repo_file=$repo_file
kernel_url=$kernel_url
spec_param=$spec_param" > ${workdir}/.param
}

oe_deppkg_install() {
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

cur_dir=$(cd $(dirname $0);pwd)

default_param
parseargs "$@" || help $?

source ${cur_dir}/boards/${board}.conf

LOG "Selected board: ${board}."

LOG "Board config: ${board}."
LOG "U-Boot config: ${ubootconfig}."
LOG "DeviceTree name: ${dtb_name}."
LOG "Target platform: ${platform}."

used_param
if [ ! -d ${workdir} ]; then
    mkdir ${workdir}
fi

# Firefly Toolchain Repo
aarch64_toolchain_base_url="https://gitee.com/openeuler/yocto-meta-openeuler/releases/download"
aarch64_toolchain_verson="toolchains-v0.1.8"

host_arch=$(arch)

save_param
log_dir=${workdir}/log
if [ ! -d ${log_dir} ];then mkdir -p ${log_dir}; fi
if [ -f ${workdir}/.done ];then
    LOG "Checking the previous build."
    if [[ $(cat ${workdir}/.done | grep u-boot) == "u-boot" && \
    $(cat ${workdir}/.done | grep bootimg) == "bootimg" && \
    $(cat ${workdir}/.done | grep rootfs) == "rootfs" && \
    $(cat ${workdir}/.done | grep image) == "image" ]];then
        LOG "Found complete build, clean build flag."
        rm ${workdir}/.done
        touch ${workdir}/.done
    fi
else
    oe_deppkg_install
    if [[ "${host_arch}" == "x86_64" && "${arch}" == "arm64" ]];then
        LOG "Cloning linux arm64 cross compile toolchain for x86_64..."
        if [[ -d ${workdir}/openeuler_gcc_arm64le && ! -f ${workdir}/openeuler_gcc_arm64le/.done ]];then
            rm -rf ${workdir}/openeuler_gcc_arm64le
        fi
        
        cd ${workdir}

        i=$((1))
        get_toolchain() {
            local block="$(printf $1)"
            echo "${aarch64_toolchain_base_url}/${aarch64_toolchain_verson}/${block}_openeuler_gcc_arm64le.tar.gz"
        }
        while wget "$(get_toolchain "$i")"; do
            i=$((i + 1))
        done

        cat *_openeuler_gcc_arm64le.tar.gz >> openeuler_gcc_arm64le.tar.gz
        tar -zxvf openeuler_gcc_arm64le.tar.gz

        rm *openeuler_gcc_arm64le.tar.gz
    else
        LOG "You are running this script on a ${host_arch} mechine, progress...."
    fi
    touch ${workdir}/.done
fi

if [[ $(cat ${workdir}/.done | grep u-boot) != "u-boot" ]];then
    bash ${cur_dir}/build_u-boot.sh
fi

if [[ $(cat ${workdir}/.done | grep bootimg) != "bootimg" ]];then
    bash ${cur_dir}/build_boot.sh
fi

if [[ $(cat ${workdir}/.done | grep rootfs) != "rootfs" ]];then
    if [[ "${host_arch}" == "x86_64" && "${arch}" == "arm64" ]];then
        LOG "You are running this script on a ${host_arch} mechine, installing qemu-user-static...."
        sudo rpm -ivh ${nonfree_bin_dir}/qemu-user-static-aarch64-x86_64.rpm
    fi
    LOG "You are running this script on a ${host_arch} mechine, start building rootfs...."
    bash ${cur_dir}/build_rootfs.sh
fi

bash ${cur_dir}/gen_image.sh -n ${name} --board ${board}
