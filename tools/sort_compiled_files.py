# Open the input file for reading
with open('../tests/test_openocd_bad.log', 'r') as file:
    # Read all lines from the file
    lines = file.readlines()

# Filter lines that contain the pattern "- CC /"
filtered_lines = [line for line in lines if '- CC /' in line]

# Sort the filtered lines
sorted_lines = sorted(filtered_lines)

# Open the output file for writing
with open('test_openocd_bad.sorted.txt', 'w') as output_file:
    # Write the sorted lines to the output file
    output_file.writelines(sorted_lines)

print("Sorting completed. Check the test.sorted.txt file.")


