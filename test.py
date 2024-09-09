import subprocess
import json
import os
import pathlib

omni_test_result = dict()

# Download repository from github
try:
    result = subprocess.run(["git", "clone", os.getenv('GITHUB_URL'), "my_program"],
                            stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE,
                            text=True)
    if result.returncode == 0:
        print(result.stdout)
    else:
        raise result.stderr
except Exception as e:
    raise f"An error occurred: {str(e)}"
        
# Try to run the 

import pathlib

# (1) Write to output file
output_dir = "/results"
output_file = "your-result.txt"

# Create the directory if it doesn't exist
pathlib.Path(output_dir).mkdir(parents=True, exist_ok=True)

# Write the result to the file
result = str(omni_test_result)
file_path = os.path.join(output_dir, output_file)
with open(file_path, "w") as file:
    file.write(result)

# (2) Check if the file exists
if os.path.isfile(file_path):
    print("File exists")
else:
    print("File does not exist")
# (2) Write to Nucleus
# Make sure to replace `localhost` with the IP address or hostname of the machine running Nucleus.
# result = omni.client.write_file("omniverse://nucleus.tpe1.local/Users/NTU/result/result.txt", result.encode())

  
