import os
import shutil

# Define the source directories
source_dirs = [
    '/home/yc/ws/msdk/Examples/MAX32655/Bluetooth/BLE5_ctr/obj',
    '/home/yc/ws/msdk/Examples/MAX32655/Bluetooth/BLE5_ctr/build'
]

# Define the target directory
target_dir = '/home/yc/ws/msdk/Libraries/Packetcraft-ADI/bin/max32655_baremetal_T2_softfp'

# Walk through each source directory
for source_dir in source_dirs:
    for root, dirs, files in os.walk(source_dir):
        for file in files:
            # Check if the file is a .o or .d file
            if file.endswith('.o') or file.endswith('.d'):
                # Full file path
                source_file = os.path.join(root, file)
                # Target file path
                target_file = os.path.join(target_dir, file)
                # Move the file to the target directory, replacing it if it exists
                shutil.move(source_file, target_file)
                print(f"Moved {source_file} to {target_file}")

print("File transfer completed.")

