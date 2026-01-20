FROM openeuler-22.03-lts-sp3:latest

RUN dnf clean expire-cache

ENV SHELL=/bin/bash

RUN dnf install sudo -y

RUN echo "cd /work && bash build.sh \
    --board \${board} \
    -n \${name} \
    -k \${kernel_url} \
    -b \${branch} \
    -c \${default_defconfig} \
    -r \${repo_file} \
    -s \${spec_param} \
    --cores \${make_cores}" >> /start-build.sh

ENTRYPOINT ["/bin/bash", "/start-build.sh"]