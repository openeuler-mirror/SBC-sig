#!/bin/bash
set -e
set -x

__usage="
Usage: build_boot [OPTIONS]
Build openEuler SBCs boot image.
The target boot.img will be generated in the build folder of the directory where the build_boot.sh script is located.

Options: 
  --board BOARD_CONFIG                  Required! The config of target board in the boards folder, which defaults to firefly-rk3399.
  -b, --branch KERNEL_BRANCH            The branch name of kernel source's repository, which defaults to openEuler-20.03-LTS.
  -k, --kernel KERNEL_URL               Required! The URL of kernel source's repository.
  -c, --config KERNEL_DEFCONFIG         The name/path of defconfig file when compiling kernel, which defaults to openeuler_rockchip_defconfig.
  --cores N                             The number of cpu cores to be used during making.
  -h, --help                            Show command help.
"

help()
{
    echo "$__usage"
    exit $1
}

default_param() {
    workdir=${cur_dir}/build
    branch=openEuler-20.03-LTS
    default_defconfig=openeuler_rockchip_defconfig
    board=firefly-rk3399
    dtb_name=rk3399-firefly
    platform=rockchip
    kernel_url="https://atomgit.com/openeuler/rockchip-kernel.git"
    boot_dir=${workdir}/boot
    log_dir=${workdir}/log
    make_cores=$(nproc)
}

local_param(){
    if [ -f ${workdir}/.param ]; then
        branch=$(cat ${workdir}/.param | grep branch)
        branch=${branch:7}

        default_defconfig=$(cat ${workdir}/.param | grep default_defconfig)
        default_defconfig=${default_defconfig:18}

        board=$(cat ${workdir}/.param | grep board)
        board=${board:6}

        kernel_url=$(cat ${workdir}/.param | grep kernel_url)
        kernel_url=${kernel_url:11}
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
        elif [ "x$1" == "x-b" -o "x$1" == "x--branch" ]; then
            branch=`echo $2`
            shift
            shift
        elif [ "x$1" == "x-c" -o "x$1" == "x--config" ]; then
            default_defconfig=`echo $2`
            shift
            shift
        elif [ "x$1" == "x-k" -o "x$1" == "x--kernel" ]; then
            kernel_url=`echo $2`
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

LOSETUP_D_IMG(){
    set +e
    if [ -d ${workdir}/boot_emmc ]; then
        if grep -q "${workdir}/boot_emmc " /proc/mounts ; then
            umount ${workdir}/boot_emmc
        fi
    fi
    if [ -d ${workdir}/boot_emmc ]; then
        rm -rf ${workdir}/boot_emmc
    fi
    set -e
}

clone_and_check_kernel_source() {
    pushd ${workdir}
    if [ -d kernel ]; then
        if [ -f ${workdir}/.param_last ]; then
            last_branch=$(cat ${workdir}/.param_last | grep branch)
            last_branch=${last_branch:7}

            last_default_defconfig=$(cat ${workdir}/.param_last | grep default_defconfig)
            last_default_defconfig=${last_default_defconfig:18}

            last_dtb_name=$(cat ${workdir}/.param_last | grep dtb_name)
            last_dtb_name=${last_dtb_name:9}
            
            last_platform_name=$(cat ${workdir}/.param_last | grep platform)
            last_platform_name=${last_platform_name:9}

            last_kernel_url=$(cat ${workdir}/.param_last | grep kernel_url)
            last_kernel_url=${last_kernel_url:11}

            pushd ${workdir}/kernel
            git remote -v update
            lastest_kernel_version=$(git rev-parse @{u})
            local_kernel_version=$(git rev-parse @)
            popd

            if [[ ${last_branch} != ${branch} || \
            ${last_default_defconfig} != ${default_defconfig} || \
            ${last_dtb_name} != ${dtb_name} || \
            ${last_kernel_url} != ${kernel_url} || \
            ${lastest_kernel_version} != ${local_kernel_version} ]]; then
                if [ -d ${workdir}/kernel ];then rm -rf ${workdir}/kernel; fi
                if [ -d ${workdir}/boot ];then rm -rf ${workdir}/boot; fi
                if [ -f ${workdir}/boot.img ];then rm ${workdir}/boot.img; fi
                git clone --depth=1 -b $branch $kernel_url kernel
                LOG "clone kernel source done."
            fi
        fi
    else
        git clone --depth=1 -b $branch $kernel_url kernel
        LOG "clone kernel source done."
    fi
    popd
}

make_kernel(){
    LOG "make kernel(${default_defconfig}) begin..."
    kernel_dir_tmp=$1
    pushd "${kernel_dir_tmp}"

    if [ -f ${cur_dir}/configs/common/${kernel_defconfig} ];then
        LOG "use local kernel defconfig: ${kernel_defconfig}"
        cp ${cur_dir}/configs/common/${kernel_defconfig} arch/arm64/configs
    fi

    if [ -n "${kernel_defconfig}" ]; then
        if [ "x${kernel_defconfig:0:1}" != "x/" ]; then
            if [ ! -f arch/arm64/configs/${kernel_defconfig} ]; then
                ERROR "config file ${kernel_defconfig} can not be found in kernel source".
                exit 2
            fi
            kernel_defconfig=arch/arm64/configs/${kernel_defconfig}
        fi
    fi

    make distclean
    kernel_ver=""
    if [ "x${board}" == "xraspberrypi" ]; then
        kernel_ver=$(awk '/^VERSION = / {v=$3} /^PATCHLEVEL = / {p=$3} /^SUBLEVEL = / {s=$3} /^EXTRAVERSION = / {e=$3} END {print v"."p"."s (e ? "-" e : "") "+"}' Makefile)
        if [ -z "${kernel_defconfig}" ]; then
            if [ "x${branch}" == "xOLK-6.6" ]; then
                make ARCH=arm64 -j${make_cores} O=output/v8 bcm2711_defconfig
                make ARCH=arm64 -j${make_cores} O=output/v8 KERNELRELEASE=${kernel_ver}-v8

                make ARCH=arm64 -j${make_cores} O=output/2712 bcm2712_defconfig
                make ARCH=arm64 -j${make_cores} O=output/2712 KERNELRELEASE=${kernel_ver}-2712

                cp output/2712/arch/arm64/boot/Image arch/arm64/boot/Image
                cp output/2712/arch/arm64/boot/dts/${platform}/${dtb_name}.dtb arch/arm64/boot/dts/${platform}/${dtb_name}.dtb
                LOG "make kernel(bcm2711_defconfig, bcm2712_defconfig) for Raspberry Pi end."
                return
            else
                kernel_defconfig="arch/arm64/configs/bcm2711_defconfig"
            fi
        fi
    fi

    cp ${kernel_defconfig} .config
    make ARCH=arm64 olddefconfig
    kernel_defconfig=${kernel_defconfig##*/}
    make ARCH=arm64 -j${make_cores}
    LOG "make kernel(${default_defconfig}) end."
    popd
}

install_kernel() {
    if [ ! -f ${workdir}/kernel/arch/arm64/boot/Image ]; then
        ERROR "kernel Image can not be found!"
        exit 2
    else
        LOG "make kernel done."
    fi
    if [ -d ${workdir}/kernel/kernel-modules ];then rm -rf ${workdir}/kernel/kernel-modules; fi
    if [ -d ${boot_dir} ];then rm -rf ${boot_dir}; fi
    mkdir -p ${boot_dir}
    mkdir -p ${workdir}/kernel/kernel-modules
    pushd ${workdir}/kernel

    if [ "x${board}" == "xraspberrypi" ]; then
        mkdir -p ${boot_dir}/overlays
        if [ -z "${kernel_defconfig}" ] && [ "x${branch}" == "xOLK-6.6" ]; then
            rpi_version=("v8" "2712")
            for rpi in "${rpi_version[@]}"; do
                pushd output/${rpi}
                make ARCH=arm64 -j${make_cores} modules_install INSTALL_MOD_PATH=${workdir}/kernel/kernel-modules
                cp arch/arm64/boot/Image ${boot_dir}/Image-${rpi}
                cp .config ${boot_dir}/config-${rpi}
                cp System.map ${boot_dir}/System.map-${rpi}
                popd
            done
            mv ${boot_dir}/Image-v8 ${boot_dir}/kernel8.img
            mv ${boot_dir}/Image-2712 ${boot_dir}/kernel_2712.img
            cp output/2712/arch/arm64/boot/dts/${platform}/*.dtb ${boot_dir}
            cp output/2712/arch/arm64/boot/dts/overlays/*.dtb* ${boot_dir}/overlays/
        else
            make ARCH=arm64 -j${make_cores} modules_install INSTALL_MOD_PATH=${workdir}/kernel/kernel-modules
            cp arch/arm64/boot/Image ${boot_dir}/kernel8.img
            cp .config ${boot_dir}/config
            cp System.map ${boot_dir}/System.map
            cp arch/arm64/boot/dts/${platform}/*.dtb ${boot_dir}
            cp arch/arm64/boot/dts/overlays/*.dtb* ${boot_dir}/overlays/
        fi
    else
        make ARCH=arm64 install INSTALL_PATH=${boot_dir}
        make ARCH=arm64 -j${make_cores} modules_install INSTALL_MOD_PATH=${workdir}/kernel/kernel-modules
        cp arch/arm64/boot/Image ${boot_dir}
        cp arch/arm64/boot/dts/${platform}/*.dtb ${boot_dir}
    fi
    rm -rf ${workdir}/kernel/kernel-modules/lib/modules/*/source ${workdir}/kernel/kernel-modules/lib/modules/*/build
    LOG "prepare kernel done."
    popd
}

mk_boot() {
    LOG "start make bootimg..."
    if [ "x${board}" != "xraspberrypi" ]; then

        LOG "start gen initrd..."
        dracut --no-kernel ${boot_dir}/initrd.img
        LOG "gen initrd done."

        LOG "gen extlinux config for $dtb_name"
        if [ "${platform}" == "rockchip" ];then
            bootargs=${rockchip_bootargs}
        elif [ "${platform}" == "phytium" ];then
            bootargs=${phytium_bootargs}
        elif [ "${platform}" == "allwinner" ];then
            bootargs=${allwinner_bootargs}
        elif [ "${platform}" == "amlogic" ];then
            bootargs=${amlogic_bootargs}
        elif [ "${platform}" == "cix" ];then
            bootargs=${cix_bootargs}
        else
            echo "Unsupported platform"
            exit 2
        fi

        if [ "x${bootmode}" == "xextlinux" ]; then
            mkdir -p ${boot_dir}/extlinux
            cp ${cur_dir}/configs/common/extlinux.conf ${boot_dir}/extlinux
            sed -i "s|BOOTARGS|${bootargs}|g" ${boot_dir}/extlinux/extlinux.conf
            sed -i "s|DEVICETREE|${dtb_name}.dtb|g" ${boot_dir}/extlinux/extlinux.conf
            LOG "gen extlinux config done."
        elif [ "x${bootmode}" == "xgrub" ]; then
            echo ${bootargs} \
            >> ${boot_dir}/grub-cmdline.txt
            LOG "save grub cmdline done."
        else
            echo "Unsupported bootmode"
            exit 2
        fi
        
    fi
    dd if=/dev/zero of=${workdir}/boot.img bs=1M count=${boot_size} status=progress
    mkfs.vfat -n boot ${workdir}/boot.img
    if [ -d ${workdir}/boot_emmc ];then rm -rf ${workdir}/boot_emmc; fi
    mkdir ${workdir}/boot_emmc
    mount ${workdir}/boot.img ${workdir}/boot_emmc/
    cp -r ${boot_dir}/* ${workdir}/boot_emmc/
    umount ${workdir}/boot.img
    rmdir ${workdir}/boot_emmc

    if [ -f ${workdir}/boot.img ]; then
        LOG "make boot image done."
    else
        ERROR "make boot image failed!"
        exit 2
    fi

    LOG "clean boot directory."
    rm -rf ${boot_dir}
}

kernel_defconfig=""
cur_dir=$(cd $(dirname $0);pwd)

default_param
local_param
parseargs "$@" || help $?

source ${cur_dir}/boards/${board}.conf

rockchip_bootargs="earlyprintk console=ttyS2,1500000 rw root=UUID=614e0000-0000-4b53-8000-1d28000054a9 rootfstype=ext4 init=/sbin/init rootwait"
phytium_bootargs="console=ttyAMA1,115200 earlycon=pl011,0x2800d000 rw root=UUID=614e0000-0000-4b53-8000-1d28000054a9 rootfstype=ext4 rootwait cma=256m"
allwinner_bootargs="console=tty0 console=ttyS0,115200 rw root=UUID=614e0000-0000-4b53-8000-1d28000054a9 rootfstype=ext4 rootwait earlycon clk_gnore_unused"
amlogic_bootargs="console=ttyAML0,115200 console=tty1 consoleblank=0 root=UUID=614e0000-0000-4b53-8000-1d28000054a9 rootwait rootfstype=ext4 splash=verbose coherent_pool=2M loglevel=8"
cix_bootargs="root=UUID=614e0000-0000-4b53-8000-1d28000054a9 loglevel=0 acpi=off kasan=off rootwait rw pcie_aspm=off console=tty0 console=ttyAMA2 splash=verbose"

if [ -n "${default_defconfig}" ]; then
    if [ ! -f $default_defconfig ] ; then
        LOG "kernel defconfig is : ${default_defconfig}"
        kernel_defconfig=$default_defconfig
    else
        LOG "use local kernel defconfig..."
        cp $default_defconfig ${workdir}/
        kernel_defconfig=${workdir}/${default_defconfig##*/}
    fi
elif [ "x${board}" != "xraspberrypi" ]; then
    LOG "default_defconfig is missing"
    exit 1
fi

host_arch=$(arch)

if [[ "${host_arch}" == "x86_64" && "${arch}" == "arm64" ]];then
    LOG "You are running this script on a ${host_arch} mechine, use cross compile...."
    export CROSS_COMPILE="${workdir}/openeuler_gcc_arm64le/bin/aarch64-openeuler-linux-gnu-"
else
    LOG "You are running this script on a ${host_arch} mechine, progress...."
fi

if [ ! -d ${workdir} ]; then
    mkdir ${workdir}
fi

if [ ! -d ${log_dir} ];then mkdir -p ${log_dir}; fi
if [ ! -f ${workdir}/.done ];then
    touch ${workdir}/.done
fi
sed -i 's/bootimg//g' ${workdir}/.done
LOG "build boot..."

if [ "x${board}" == "xraspberrypi" ] && [ -z "${kernel_url}"  ]; then
    LOG "build an empty boot.img for Raspberry Pi."
    rm -rf ${workdir}/kernel || LOG "remove kernel source."
    dd if=/dev/zero of=${workdir}/boot.img bs=1M count=10 status=progress
    mkfs.vfat -n boot ${workdir}/boot.img
    LOG "The boot.img is generated in the ${workdir}."
    echo "bootimg" >> ${workdir}/.done
    exit 0
fi

clone_and_check_kernel_source

if [[ -f ${workdir}/kernel/arch/arm64/boot/dts/${platform}/${dtb_name}.dtb && -f ${workdir}/kernel/arch/arm64/boot/Image ]];then
    LOG "kernel is the latest"
else
    make_kernel ${workdir}/kernel
fi
if [[ -f ${workdir}/boot.img && $(cat ${workdir}/.done | grep bootimg) == "bootimg" ]]; then
    LOG "boot is the latest"
else
    trap 'LOSETUP_D_IMG' EXIT
    LOSETUP_D_IMG
    install_kernel
    mk_boot
fi
LOG "The boot.img is generated in the ${workdir}."
echo "bootimg" >> ${workdir}/.done
