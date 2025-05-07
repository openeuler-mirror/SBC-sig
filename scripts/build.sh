#!/bin/bash

set -e

usage() {
    echo "Usage: $0 --board BOARD_TYPE --in-docker [other_args...]"
    echo Options: 
    echo "--in-docker           Build images in Docker."
    echo "--board BOARD_TYPE    Supported boards:"
    echo "  - rpi (Build a Raspberry Pi image without kernel compilation)"
    echo "  - rpi-custom (Build a Raspberry Pi image using a custom kernel compiled)"
    for config in "${RK_BOARDS[@]}"; do
        echo "  - $config"
    done
    exit 1
}

cur_dir=$(cd $(dirname $0);pwd)
rk_board_dir=$cur_dir/rockchip/boards

BOARD=""
HELP=false
IN_DOCKER=false
ARGS=()
RK_BOARDS=()
SUB_SCRIPT=""

while IFS= read -r -d '' file; do
    RK_BOARDS+=("$(basename "$file" .conf)")
done < <(find "$rk_board_dir" -type f -name "*.conf" ! -name "sample.conf" -print0 | sort -z)

if [ $# -eq 0 ]; then
    usage
fi

while [[ $# -gt 0 ]]; do
    case "$1" in
        --board)
            BOARD="$2"
            shift 2
            ;;
        --in-docker)
            IN_DOCKER=true
            shift
            ;;
        --help)
            HELP=true
            ARGS+=("--help")
            shift
            ;;
        *)
            ARGS+=("$1")
            shift
            ;;
    esac
done

if [ -z "$BOARD" ]; then
    if ! $HELP; then
        echo "Error: --board parameter is required"
    fi
    usage
fi

case "$BOARD" in
    rpi)
        if $IN_DOCKER; then
            SUB_SCRIPT="$cur_dir/raspberrypi/build-image-docker.sh"
        else
            SUB_SCRIPT="$cur_dir/raspberrypi/build-image.sh"
        fi
        ;;
    rpi-custom)
        if $IN_DOCKER; then
            SUB_SCRIPT="$cur_dir/raspberrypi/build-image-docker.sh"
        else
            SUB_SCRIPT="$cur_dir/raspberrypi/build-image-common.sh"
        fi   
        ;;
    *)
        for item in "${RK_BOARDS[@]}"; do
            if [ "$item" == "$BOARD" ]; then
                if $IN_DOCKER; then
                    SUB_SCRIPT="$cur_dir/rockchip/build-image-docker.sh"
                else
                    SUB_SCRIPT="$cur_dir/rockchip/build.sh"
                fi   
                ARGS+=("--board")
                ARGS+=("$BOARD")
                break
            fi
        done
        ;;
esac

if [ -z "$SUB_SCRIPT" ]; then
    echo "Error: Unknown board type '$BOARD'"
    usage
fi

echo "Running: $SUB_SCRIPT ${ARGS[@]}"
"$SUB_SCRIPT" "${ARGS[@]}"
