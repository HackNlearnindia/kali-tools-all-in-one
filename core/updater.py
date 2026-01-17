import subprocess, os

subprocess.call(["sudo","apt","update"])
subprocess.call(["sudo","apt","upgrade","-y"])

# Update GitHub tools
if os.path.exists("/opt"):
    for d in os.listdir("/opt"):
        p = "/opt/"+d
        if os.path.isdir(p) and os.path.exists(p+"/.git"):
            subprocess.call(["git","-C",p,"pull"])
