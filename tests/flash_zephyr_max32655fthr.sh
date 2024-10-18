#!/usr/bin/env bash

printf "\n\n"
printf "##############################\n"
printf "# flash_zephyr_max32655fthr.sh\n"
printf "##############################\n\n"

# /home/yc/zephyrproject/zephyr/build/zephyr/zephyr.hex /home/btm-ci/Tools/openocd 042317023186ca8800000000000000000000000097969906 max32655

echo $0 $@
echo ""

PROJECT=zephyr
echo PROJECT=$PROJECT

printf "\n--- flash the project\n"

ELF_PATH=/home/$USER/ws/msdk
OPENOCD=/home/$USER/MaximSDK/Tools/OpenOCD
TARGET_LC=max32655
PORT=042317023186ca8800000000000000000000000097969906

bash -e /home/$USER/ws/msdk_dev_tools/scripts/flash.sh \
    $ELF_PATH   \
    $OPENOCD     \
    $PORT        \
    $TARGET_LC

set +e

echo "Done: pc_max32655_ble5_ctr.sh"
echo ""

