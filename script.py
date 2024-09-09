import subprocess
import json
import requests
import os
import pathlib
import pathlib


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
        
# Try to run the docker file
try:
    result = subprocess.run(["bash", "/my_program/run.sh"],
                            stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE,
                            text=True)
    if result.returncode == 0:
        print(result.stdout)
    else:
        raise result.stderr
except Exception as e:
    raise f"An error occurred: {str(e)}"



# Send a GET request to the Flask app running in Docker
response = requests.get('http://localhost:8000/run-script')
omni_result = response.json()

# (1) Write to output file
output_dir = "/results"
output_file = "result.json"

# Create the directory if it doesn't exist
pathlib.Path(output_dir).mkdir(parents=True, exist_ok=True)

file_path = os.path.join(output_dir, output_file)
with open(file_path, "w") as file:
    json.dump(omni_result, file_path, indent=4)

