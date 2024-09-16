import omni.client

# Log in to the server
omni.client.connect("omniverse://nucleus.tpe1.local/")
try:
    # Download the file
    source_path = "omniverse://nucleus.tpe1.local/Users/result/result.txt"
    destination_path = "result/"

    omni.client.copy(source_path, destination_path)
except:
    raise RuntimeError()