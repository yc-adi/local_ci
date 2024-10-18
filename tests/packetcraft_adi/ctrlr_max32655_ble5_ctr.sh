#!/usr/bin/env bash

printf "\n\n"
printf "############################\n"
printf "# ctrlr_max32655_ble5_ctr.sh\n"
printf "############################\n\n"

echo $0 $@
echo ""

ADI_YC=ADI
echo ADI_YC=$ADI_YC

PROJECT=BLE5_ctr
echo PROJECT=$PROJECT

/usr/bin/bash -e ../scripts/setup_env.sh
set +e

printf "\n--- prepare repo to use\n"
MSDK_REPO=/home/$USER/ws/msdk
echo MSDK_REPO=$MSDK_REPO

cd $MSDK_REPO
MSDK_BRANCH=main
echo MSDK_BRANC=$MSDK_BRANCH

echo PWD=`pwd`
set -e

PC_COMMIT=
echo PC_COMMIT=$PC_COMMIT
cd ${MSDK_REPO}/Libraries/Packetcraft-${ADI_YC}
echo PWD=`pwd`
set -x
git status
if [ "x${PC_COMMIT}" != "x" ]; then
    git checkout -- .
    git checkout $PC_COMMIT
fi
set +x

cd ${MSDK_REPO}/Libraries/Packetcraft-${ADI_YC}
cd controller/build/ble5-ctr/gcc
echo PWD=`pwd`

printf "\n--- build and flash the project\n"

OPENOCD=/home/$USER/MaximSDK/Tools/OpenOCD
TARGET=MAX32655
BOARD=EvKit_V1
#PROJECT
PORT=0409170228a0088000000000000000000000000097969906
BUILD=False
FLASH=True

# Build the maxim platform
export PLATFORM=maxim
make clean
make -j8

PATH=${MSDK_REPO}/Libraries/Packetcraft-${ADI_YC}/controller/build/ble5-ctr/gcc/bin
ELF=ble5-ctr.elf
/usr/bin/bash -e /home/$USER/ws/msdk_dev_tools/scripts/flash.sh \
    $PATH       \
    $ELF        \
    $OPENOCD    \
    $PORT       \
    max32655

set +e

echo "Done: pc_max32655_ble5_ctr.sh"
echo ""

