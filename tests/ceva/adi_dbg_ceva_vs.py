#! /usr/bin/env python3
###############################################################################
#
#
# Copyright (C) 2023 Maxim Integrated Products, Inc., All Rights Reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL MAXIM INTEGRATED BE LIABLE FOR ANY CLAIM, DAMAGES
# OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# Except as contained in this notice, the name of Maxim Integrated
# Products, Inc. shall not be used except as stated in the Maxim Integrated
# Products, Inc. Branding Policy.
#
# The mere transfer of this software does not imply any licenses
# of trade secrets, proprietary technology, copyrights, patents,
# trademarks, maskwork rights, or any other form of intellectual
# property whatsoever. Maxim Integrated Products, Inc. retains all
# ownership rights.
#
##############################################################################
#
# Copyright 2023 Analog Devices, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
##############################################################################
"""
adi_dbg_ceva_vs.py

Description: Bare minimum example of using the BleHci class

"""

# import the max_ble_hci from the local source code repo
import sys
sys.path.append('/home/yc/ws/MAX-BLE-HCI/src')

from max_ble_hci import BleHci
from pprint import pprint
from time import sleep

# Path to serial port used for HCI
PORT = "/dev/serial/by-id/usb-FTDI_FT230X_Basic_UART_D3076YFM-if00-port0"
CEVA_BAUDRATE = 921600

def rd_circ_buf(controller, buf_addr, head, tail) -> list[int]:
    """Read the content of the circular buffer.
    """
    print(f'head: {head}, tail: {tail}')
    data = []
    batch = 40

    if head == tail:
        pass
    elif head > tail:
        len = head - tail
        
        for i in range(int(len/batch)):
            print(f'start from {tail + i}, len: {batch}')
            data1, evt = ctrl.ceva_rd_data(buf_addr + tail + i, 8, batch)
            data += data1[1:] # the first element is the length
        
        if len % batch != 0:
            print(f'start from {tail + (len - len % batch)}, len: {(len % batch)}')
            data1, evt = ctrl.ceva_rd_data(buf_addr + tail + (len - len % batch), 8, (len % batch))
            data += data1[1:] # the first element is the length
    else: # head < tail
        len = 1024 - tail
        
        for i in range(0, len, batch):
            data1, evt = ctrl.ceva_rd_data(buf_addr + tail + i, 8, batch)
            data += data1[1:] # the first element is the length
        
        if len % batch != 0:
            data1, evt = ctrl.ceva_rd_data(buf_addr + tail + (len - len % batch) + 1, 8, (len % batch) - 1)
            data += data1[1:] # the first element is the length

        len = head
        for i in range(0, len, batch):
            data1, evt = ctrl.ceva_rd_data(buf_addr + i, 8, batch)
            data += data1[1:] # the first element is the length
        
        if len % batch != 0:
            data1, evt = ctrl.ceva_rd_data(buf_addr + (len - len % batch) + 1, 8, (len % batch) - 1)
            data += data1[1:] # the first element is the length

    return data


ctrl = BleHci(port_id=PORT, baud=CEVA_BAUDRATE, flowcontrol=True)
'''
print(f"- Get debug addresses.")
addrs, evt = ctrl.ceva_get_addr()
# print(f'0x{addrs["dbg_circ_buff"]:08X}')
# print(f'0x{addrs["dbg_circ_head"]:08X}')
# print(f'0x{addrs["dbg_circ_tail"]:08X}')

print("- Get the circular buffer head")
data, evt = ctrl.ceva_rd_data(addrs['dbg_circ_head'], 8, 2)
circ_buf_head = data[1] + data[2] * 16
print(f'head: {circ_buf_head}')

print("- Get the circular buffer tail")
data, evt = ctrl.ceva_rd_data(addrs['dbg_circ_tail'], 8, 2)
circ_buf_tail = data[1] + data[2] * 16
print(f'tail: {circ_buf_tail}')
'''
#buffer = rd_circ_buf(ctrl, addrs['dbg_circ_buff'], circ_buf_head, circ_buf_tail)
buffer = rd_circ_buf(ctrl, 0x001D1FFC, 40, 0)
hex_format = [format(element, '02X') for element in buffer]
print(hex_format)
hex_format = [format(element, 'd') for element in buffer]
print(hex_format)