FROM openeuler-22.03-lts-sp3:latest
ARG board="firefly-rk3399"
ARG docker_file="https://repo.openeuler.org/openEuler-22.03-LTS-SP3/docker_img/aarch64/openEuler-docker.aarch64.tar.xz"
ARG name="openEuler-22.03-LTS-SP3-firefly-rk3399-aarch64-alpha1"
ARG kernel_url="https://gitee.com/openeuler/rockchip-kernel.git"
ARG branch="openEuler-22.03-LTS-SP3"
ARG default_defconfig="openeuler_rockchip_defconfig"
ARG repo_file="https://gitee.com/src-openeuler/openEuler-repos/raw/openEuler-22.03-LTS-SP3/generic.repo"
ARG spec_param="headless"
ARG make_cores="1"

RUN dnf clean expire-cache

ENV SHELL=/bin/bash

RUN echo "cd /work && bash build.sh \
    --board ${board} \
    -n ${name} \
    -k ${kernel_url} \
    -b ${branch} \
    -c ${default_defconfig} \
    -r ${repo_file} \
    -s ${spec_param} \
    --cores ${make_cores}" >> /start-build.sh

ENTRYPOINT ["/bin/bash", "/start-build.sh"]