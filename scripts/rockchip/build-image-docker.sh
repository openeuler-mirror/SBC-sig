#!/bin/bash

set -e

__usage="
Usage: build-image-docker [OPTIONS]
Build board image.

Options:
  --board BOARD_CONFIG             Required! The config of target board in the boards folder.
  -d, --docker DOCKER_FILE         The URL/path of the Docker image, which defaults to https://repo.openeuler.org/openEuler-20.03-LTS-SP1/docker_img/aarch64/openEuler-docker.aarch64.tar.xz
  -n, --name IMAGE_NAME            The board image name to be built.
  -k, --kernel KERNEL_URL          The URL of kernel source's repository, which defaults to https://gitee.com/openeuler/rockchip-kernel.git.
  -b, --branch KERNEL_BRANCH       The branch name of kernel source's repository, which defaults to openEuler-22.03-LTS-SP3.
  -c, --config KERNEL_DEFCONFIG    The name/path of defconfig file when compiling kernel, which defaults to openeuler_rockchip_defconfig.
  -r, --repo REPO_INFO             Required! The URL/path of target repo file or list of repo's baseurls which should be a space separated list.
  -s, --spec SPEC                  The image's specification: headless, xfce, ukui, dde or the file path of rpmlist. The default is headless.
  --cores N                        The number of cpu cores to be used during making.
  -h, --help                       Show command help.
"

help()
{
    echo "$__usage"
    exit $1
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
        elif [ "x$1" == "x-d" -o "x$1" == "x--docker" ]; then
            docker_file=`echo $2`
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

ERROR(){
    echo `date` - ERROR, $* | tee -a ${log_dir}/${builddate}.log
}

LOG(){
    echo `date` - INFO, $* | tee -a ${log_dir}/${builddate}.log
}

cur_dir=$(cd $(dirname $0);pwd)

docker_file="https://repo.openeuler.org/openEuler-22.03-LTS-SP3/docker_img/aarch64/openEuler-docker.aarch64.tar.xz"

workdir=${cur_dir}/build

buildid=$(date +%Y%m%d%H%M%S)
builddate=${buildid:0:8}

make_cores=$(nproc)
log_dir=${workdir}/log
if [ ! -d ${log_dir} ];then mkdir -p ${log_dir}; fi

parseargs "$@" || help $?

if [ "x${docker_file:0:4}" == "xhttp" ]; then
    wget ${docker_file} -P ${workdir}/
elif [ -f $docker_file ]; then
    cp ${docker_file} ${workdir}/
else
    echo `date` - ERROR, docker file $docker_file can not be found.
    exit 2
fi

if [ "x$repo_file" == "x" ] ; then
    echo `date` - ERROR, \"-r REPO_INFO or --repo REPO_INFO\" missing.
    help 2
fi

docker_file_name=${docker_file##*/}
docker_img_name=`docker load --input ${workdir}/${docker_file_name}`
docker_img_name=${docker_img_name##*: }

LOG build board image with docker: ${docker_file}.

(echo "FROM $docker_img_name" && grep -v FROM ${cur_dir}/configs/Dockerfile) | \
    docker build -t ${docker_img_name}-${buildid} \
    --build-arg board=${board} \
    --build-arg docker_file=${docker_file} \
    --build-arg name=${name} \
    --build-arg kernel_url=${kernel_url} \
    --build-arg branch=${branch} \
    --build-arg default_defconfig=${default_defconfig} \
    --build-arg repo_file=${repo_file} \
    --build-arg spec_param=${spec_param} \
    --build-arg make_cores=${make_cores} \
    --no-cache -f- ${cur_dir}/configs
    
echo docker run --rm --privileged=true \
    -v ${cur_dir}:/work \
    ${docker_img_name}-${buildid}
docker run --rm --privileged=true \
    -v ${cur_dir}:/work \
    ${docker_img_name}-${buildid}
chmod -R a+r ${workdir}
docker image rm ${docker_img_name}-${buildid}
LOG
LOG Done.
