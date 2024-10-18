#!/usr/bin/env bash

echo
echo "######################"
echo "# max32655_ble5_ctr.sh"
echo "######################"
echo 
echo $0 $@
echo

PROJECT=BLE5_ctr

bash -e ../scripts/setup_env.sh
set +e

echo "--- prepare repo to use"
MSDK_REPO=/home/$USER/ws/msdk
echo MSDK_REPO=$MSDK_REPO

cd $MSDK_REPO
MSDK_BRANCH=main
echo MSDK_BRANC=$MSDK_BRANCH

#CON_PORT=/dev/serial/by-id/usb-FTDI_FT230X_Basic_UART_DT03OGQ4-if00-port0
CON_PORT=/dev/serial/by-id/usb-FTDI_FT230X_Basic_UART_D307NU7M-if00-port0       # y10
echo CON_PORT=$CON_PORT

#HCI_PORT=/dev/serial/by-id/usb-FTDI_FT230X_Basic_UART_D3073IDG-if00-port0
HCI_PORT=/dev/serial/by-id/usb-FTDI_FT230X_Basic_UART_DT03OGQ4-if00-port0       # y10
echo HCI_PORT=$HCI_PORT

echo "--- build and flash the project"

MSDK_PATH=$MSDK_REPO
OPENOCD=/home/$USER/MaximSDK/Tools/OpenOCD
TARGET=MAX32655
BOARD=EvKit_V1
#PROJECT
PORT=0409170228a0088000000000000000000000000097969906   # 1
BUILD=True
FLASH=True
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

echo "Done: max32655_ble5_ctr.sh"
echo ""

