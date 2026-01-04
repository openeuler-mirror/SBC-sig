#!/bin/bash
set -e
set +x

__usage="
Usage: build_rootfs [OPTIONS]
Build openEuler rootfs image.
Run in root user.
The target rootfs.img will be generated in the build folder of the directory where the build_rootfs.sh script is located.

Options: 
  --board, BOARD_CONFIG         Required! The config of target board in the boards folder, which defaults to firefly-rk3399.
  -r, --repo REPO_INFO          The URL/path of target repo file or list of repo's baseurls which should be a space separated list.
  -b, --branch KERNEL_BRANCH    The branch name of kernel source's repository, which defaults to openEuler-20.03-LTS.
  -s, --spec SPEC               The image's specification: headless, xfce, ukui, dde, gnome, devstation or the file path of rpmlist. The default is headless.
  -h, --help                    Show command help.
"

help()
{
    echo "$__usage"
    exit $1
}

default_param() {
    board=firefly-rk3399
    repo_file="https://raw.atomgit.com/src-openeuler/openEuler-repos/raw/openEuler-20.03-LTS/generic.repo"
    workdir=${cur_dir}/build
    tmp_dir=${workdir}/tmp
    branch=openEuler-20.03-LTS
    rootfs_arch=aarch64
    nonfree_bin_dir=${cur_dir}/bin
    config_dir=${cur_dir}/configs/rockchip
    rootfs_dir=${workdir}/rootfs
    log_dir=${workdir}/log
    rootfs_mnt=${workdir}/rootfs_tmp
}

local_param(){
    if [ -f ${workdir}/.param ]; then
        board=$(cat ${workdir}/.param | grep board)
        board=${board:6}

        repo_file=$(cat ${workdir}/.param | grep repo_file)
        repo_file=${repo_file:10}

        branch=$(cat ${workdir}/.param | grep branch)
        branch=${branch:7}

        spec_param=$(cat ${workdir}/.param | grep spec_param)
        spec_param=${spec_param:11}

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
        elif [ "x$1" == "x-r" -o "x$1" == "x--repo" ]; then
            repo_file=`echo $2`
            shift
            shift
        elif [ "x$1" == "x-b" -o "x$1" == "x--branch" ]; then
            branch=`echo $2`
            shift
            shift
        elif [ "x$1" == "x-s" -o "x$1" == "x--spec" ]; then
            spec_param=`echo $2`
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
    if [ -d ${rootfs_mnt} ]; then
        if grep -q "${rootfs_mnt} " /proc/mounts ; then
            umount ${rootfs_mnt}
        fi
    fi
    if [ -d ${rootfs_mnt} ]; then
        rm -rf ${rootfs_mnt}
    fi
    set -e
}

UMOUNT_ALL(){
    set +e
    if grep -q "${rootfs_dir}/dev " /proc/mounts ; then
        umount -l ${rootfs_dir}/dev
    fi
    if grep -q "${rootfs_dir}/proc " /proc/mounts ; then
        umount -l ${rootfs_dir}/proc
    fi
    if grep -q "${rootfs_dir}/sys " /proc/mounts ; then
        umount -l ${rootfs_dir}/sys
    fi
    set -e
}

root_need() {
    if [[ $EUID -ne 0 ]]; then
        echo "Error:This script must be run as root!" 1>&2
        exit 1
    fi
}

INSTALL_PACKAGES(){
    tmp_repo_info=$2
    chroot ${rootfs_dir}/ dnf ${tmp_repo_info} --disablerepo="*" makecache --nogpgcheck
    for item in $(cat $1)
    do
        chroot ${rootfs_dir}/ dnf ${tmp_repo_info} --disablerepo="*" install -y $item --nogpgcheck
        if [ $? == 0 ]; then
            LOG install $item.
        else
            ERROR can not install $item.
        fi
    done
    if [ "x${board}" == "xraspberrypi" ] && [ -z "${kernel_url}"  ]; then
        chroot ${rootfs_dir}/ dnf ${tmp_repo_info} --disablerepo="*" install -y raspberrypi-kernel --nogpgcheck
        if [ $? == 0 ]; then
            LOG install raspberrypi-kernel.
        else
            ERROR can not install raspberrypi-kernel.
        fi
    fi
}

build_rootfs() {
    if [ ! -d ${tmp_dir} ]; then
        mkdir -p ${tmp_dir}
    else
        rm -rf ${tmp_dir}/*
    fi

    if [ "x$spec_param" == "xheadless" ] || [ "x$spec_param" == "x" ]; then
        :
    elif [ "x$spec_param" == "xxfce" ] || [ "x$spec_param" == "xukui" ] || [ "x$spec_param" == "xdde" ] || [ "x$spec_param" == "xgnome" ] || [ "x$spec_param" == "xdevstation" ]; then
        CONFIG_RPM_LIST=${config_dir}/rpmlist-${spec_param}
    elif [ -f ${spec_param} ]; then
        cp ${spec_param} ${tmp_dir}/
        spec_file_name=${spec_param##*/}
        CONFIG_RPM_LIST=${tmp_dir}/${spec_file_name}
    else
        echo `date` - ERROR, please check your params in option -s or --spec.
        exit 2
    fi
    echo $(pwd)

    if [ "x$repo_file" == "x" ] ; then
        echo `date` - ERROR, \"-r REPO_INFO or --repo REPO_INFO\" missing.
        help 2
    elif [ "x${repo_file:0:4}" == "xhttp" ]; then
        if [ "x${repo_file:0-5}" == "x.repo" ]; then
            wget ${repo_file} -P ${tmp_dir}/
            repo_file_name=${repo_file##*/}
            repo_file=${tmp_dir}/${repo_file_name}
        else
            repo_file_name=tmp.repo
            repo_file_tmp=${tmp_dir}/${repo_file_name}
            index=1
            for baseurl in ${repo_file// / }
            do
                echo [repo${index}] >> ${repo_file_tmp}
                echo name=repo${index} to build ${board} image >> ${repo_file_tmp}
                echo baseurl=${baseurl} >> ${repo_file_tmp}
                echo enabled=1 >> ${repo_file_tmp}
                echo gpgcheck=0 >> ${repo_file_tmp}
                echo >> ${repo_file_tmp}
                index=$(($index+1))
            done
            repo_file=${repo_file_tmp}
        fi
    else
        if [ ! -f $repo_file ]; then
            echo `date` - ERROR, repo file $repo_file can not be found.
            exit 2
        else
            cp $repo_file ${tmp_dir}/
            repo_file_name=${repo_file##*/}
            repo_file=${tmp_dir}/${repo_file_name}
        fi
    fi

    repo_info_names=`cat ${repo_file} | grep "^\["`
    repo_baseurls=`cat ${repo_file} | grep "^baseurl="`
    index=1
    for repo_name in ${repo_info_names}
    do
        repo_name_list[$index]=${repo_name:1:-1}
        index=$((index+1))
    done
    index=1
    for baseurl in ${repo_baseurls}
    do
        repo_info="${repo_info} --repofrompath ${repo_name_list[$index]}-tmp,${baseurl:8}"
        index=$((index+1))
    done
    
    os_release_name="openEuler-release"
    dnf ${repo_info} --disablerepo="*" --downloaddir=${tmp_dir}/ download ${os_release_name} --forcearch ${rootfs_arch}
    if [ $? != 0 ]; then
        ERROR "Fail to download ${os_release_name}!"
        exit 2
    fi
    os_release_name=`ls -r ${tmp_dir}/${os_release_name}*.rpm 2>/dev/null| head -n 1`
    if [ -z "${os_release_name}" ]; then
        ERROR "${os_release_name} can not be found!"
        exit 2
    else
        LOG "Success to download ${os_release_name}."
    fi

    LOG "make rootfs for ${repo_file} begin..."
    trap 'UMOUNT_ALL' EXIT
    if [ -d ${rootfs_dir} ]; then
        UMOUNT_ALL
        rm -rf ${rootfs_dir}
    fi
    mkdir ${rootfs_dir}

    mkdir -p ${rootfs_dir}/var/lib/rpm
    rpm --root  ${rootfs_dir}/ --initdb
    rpm -ivh --nodeps --root ${rootfs_dir}/ ${os_release_name} --ignorearch

    mkdir -p ${rootfs_dir}/etc/rpm
    chmod a+rX ${rootfs_dir}/etc/rpm
    echo "%_install_langs en_US" > ${rootfs_dir}/etc/rpm/macros.image-language-conf
    echo ${repo_info}
    dnf ${repo_info} --disablerepo="*" --installroot=${rootfs_dir}/ install -y dnf yum --nogpgcheck --forcearch ${rootfs_arch}
    
    cp -L /etc/resolv.conf ${rootfs_dir}/etc/resolv.conf
    
    mount --bind /dev ${rootfs_dir}/dev
    mount -t proc /proc ${rootfs_dir}/proc
    mount -t sysfs /sys ${rootfs_dir}/sys
    set +e
    INSTALL_PACKAGES ${CONFIG_RPM_LIST} "${repo_info}"
    cat ${rootfs_dir}/etc/systemd/timesyncd.conf | grep "^NTP=*"
    if [ $? -ne 0 ]; then
        sed -i -e '/^#NTP=/cNTP=0.cn.pool.ntp.org' ${rootfs_dir}/etc/systemd/timesyncd.conf
        sed -i -e 's/#FallbackNTP=/FallbackNTP=1.asia.pool.ntp.org 2.asia.pool.ntp.org /g' ${rootfs_dir}/etc/systemd/timesyncd.conf
    fi
    set -e

    rm -rf ${rootfs_dir}/*.core
    
    cp -Lp ${config_dir}/resolv.conf ${rootfs_dir}/etc/resolv.conf

    if [ ! -d ${rootfs_dir}/etc/sysconfig/network-scripts ]; then mkdir "${rootfs_dir}/etc/sysconfig/network-scripts"; fi
    cp -Lp ${config_dir}/ifcfg-eth0 ${rootfs_dir}/etc/sysconfig/network-scripts/ifcfg-eth0

    LOG "Configure network done."

    if [ "x${board}" == "xraspberrypi" ]; then
        mkdir -p ${rootfs_dir}/lib/udev/rules.d
        if [ ! -d ${rootfs_dir}/usr/share/licenses/raspi ]; then mkdir -p ${rootfs_dir}/usr/share/licenses/raspi; fi
        cp ${config_dir}/hosts ${rootfs_dir}/etc/hosts
        cp ${config_dir}/*.rules ${rootfs_dir}/lib/udev/rules.d/
        cp ${config_dir}/LICENCE.* ${rootfs_dir}/usr/share/licenses/raspi/
    fi

    if [ ! -d ${rootfs_dir}/etc/rc.d/init.d ]; then mkdir -p ${rootfs_dir}/etc/rc.d/init.d; fi
    cp -Lp ${config_dir}/extend-root.sh ${rootfs_dir}/etc/rc.d/init.d/extend-root.sh
    chmod +x ${rootfs_dir}/etc/rc.d/init.d/extend-root.sh
    echo net.ipv4.conf.wlan0.rp_filter=0 >> ${rootfs_dir}/etc/sysctl.conf

    cp -Lp ${config_dir}/chroot.sh ${rootfs_dir}/chroot.sh
    chmod +x ${rootfs_dir}/chroot.sh

    chroot ${rootfs_dir} /bin/bash -c "echo 'Y' | /chroot.sh ${spec_param}"

    LOG "Set NTP and auto expand rootfs done."

    echo "LABEL=rootfs  / ext4    defaults,noatime 0 0" > ${rootfs_dir}/etc/fstab
    echo "LABEL=boot  /boot vfat    defaults,noatime 0 0" >> ${rootfs_dir}/etc/fstab
    LOG "Set fstab done."

    POST_BOARD_OVERLAY

    UMOUNT_ALL
    rm ${rootfs_dir}/chroot.sh
    LOG "make rootfs for ${repo_file} end."

}

mk_rootfsimg() {
    trap 'LOSETUP_D_IMG' EXIT
    rootfs_size=`du -sh --block-size=1MiB ${rootfs_dir} | cut -f 1 | xargs`
    mod_size=`du -sh --block-size=1MiB ${workdir}/kernel/kernel-modules/lib/modules | cut -f 1 | xargs`
    size=$(($rootfs_size+$mod_size+1100))
    rootfs_img=${workdir}/rootfs.img
    dd if=/dev/zero of=${rootfs_img} bs=1MiB count=$size status=progress && sync
    mkfs.ext4 -L rootfs ${workdir}/rootfs.img

    if [ -d ${rootfs_mnt} ];then rm -rf ${rootfs_mnt}; fi
    mkdir ${rootfs_mnt}
    mount ${workdir}/rootfs.img ${rootfs_mnt}

    rsync -avHAXq ${rootfs_dir}/* ${rootfs_mnt}
    sync
    sleep 10

    LOSETUP_D_IMG

    if [ -f ${workdir}/rootfs.img ]; then
        LOG "make rootfs image done."
    else
        ERROR "make rootfs image failed!"
        exit 2
    fi

    LOG "clean rootfs directory."
    rm -rf ${rootfs_dir}
}
set -e
root_need
cur_dir=$(cd $(dirname $0);pwd)
default_param
local_param
parseargs "$@" || help $?

if [ "x${board}" == "xraspberrypi" ]; then
    config_dir=${cur_dir}/configs/raspberrypi
fi
CONFIG_RPM_LIST=${config_dir}/rpmlist

POST_BOARD_OVERLAY() {
    echo "Initial POST_BOARD_OVERLAY function" # It will be overwritten by board.conf.
}

if [[ "x$arch" == "arm64" ]]; then
    rootfs_arch="aarch64"
fi

if [ ! -d ${workdir} ]; then
    mkdir ${workdir}
fi

source ${cur_dir}/boards/${board}.conf

if [ ! -d ${log_dir} ];then mkdir -p ${log_dir}; fi
if [ ! -f ${workdir}/.done ];then
    touch ${workdir}/.done
fi
sed -i 's/rootfs//g' ${workdir}/.done
LOG "build rootfs..."
if [ -d ${rootfs_dir} ]; then
    if [[ -f ${workdir}/rootfs.img && $(cat ${workdir}/.done | grep rootfs) == "rootfs" ]];then
        if [ -f ${workdir}/.param_last ];then
            last_branch=$(cat ${workdir}/.param_last | grep branch)
            last_branch=${last_branch:7}

            last_board=$(cat ${workdir}/.param_last | grep board)
            last_board=${last_board:6}

            last_repo_file=$(cat ${workdir}/.param_last | grep repo_file)
            last_repo_file=${last_repo_file:10}

            last_spec_param=$(cat ${workdir}/.param_last | grep spec_param)
            last_spec_param=${last_spec_param:11}

            if [[ ${last_branch} != ${branch} || ${last_board} != ${board} || ${last_repo_file} != ${repo_file} || ${last_spec_param} != ${spec_param} ]]; then
                build_rootfs
                mk_rootfsimg
            fi
        fi
    else
        build_rootfs
        mk_rootfsimg
    fi
else
    build_rootfs
    mk_rootfsimg
fi
LOG "The rootfs.img is generated in the ${workdir}."
echo "rootfs" >> ${workdir}/.done
