#!/usr/bin/env bash

printf "\n\n#####################\n"
printf "# pc_max32655_ble5_ctr.sh\n"
printf "#####################\n\n"

echo $0 $@
echo ""

ADI_YC=ADI
echo ADI_YC=$ADI_YC

PROJECT=BLE5_ctr
echo PROJECT=$PROJECT

bash -e ../scripts/setup_env.sh
set +e

printf "\n--- prepare repo to use\n"
MSDK_REPO=/home/$USER/ws/msdk
echo MSDK_REPO=$MSDK_REPO

cd $MSDK_REPO
MSDK_BRANCH=main
echo MSDK_BRANC=$MSDK_BRANCH

echo PWD=`pwd`
set -e

MSDK_COMMIT=
echo MSDK_COMMIT=$MSDK_COMMIT
git checkout -- .
if [ "x$MSDK_COMMIT" != "x" ]; then
    echo git checkout
fi

PC_CONNECT=
echo PC_COMMIT=$PC_COMMIT
cd ${MSDK_REPO}/Libraries/Packetcraft-${ADI_YC}
echo PWD=`pwd`
git status
if [ "x${PC_COMMIT}" != "x" ]; then
    git checkout -- .
    git checkout $PC_COMMIT
fi
cd $MSDK_REPO

printf "\n--- build and flash the project\n"

MSDK_PATH=$MSDK_REPO
OPENOCD=/home/$USER/MaximSDK/Tools/OpenOCD
TARGET=MAX32655
BOARD=EvKit_V1
#PROJECT
PORT=0409170228a0088000000000000000000000000097969906
BUILD=True
FLASH=True

# use Packetcraft controller instead of Cordio's controller
sed -i "s/\/Cordio/\/Packetcraft-${ADI_YC}/g" $MSDK_PATH/Libraries/libs.mk
#git checkout Libraries/libs.mk # use Cordio controller

git log | head -5
    echo ""
    git status

bash -e /home/$USER/ws/msdk_dev_tools/scripts/build_flash.sh \
    $MSDK_PATH   \
    $OPENOCD     \
    $TARGET      \
    $BOARD       \
    $PROJECT     \
    $PORT        \
    $BUILD       \
    $FLASH

set +e

echo "Done: pc_max32655_ble5_ctr.sh"
echo ""

