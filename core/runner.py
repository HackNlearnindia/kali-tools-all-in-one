import sys, os, subprocess

path = sys.argv[1]

# If system command
if os.system(f"which {path} > /dev/null 2>&1") == 0:
    subprocess.Popen([path])
    sys.exit()

# Folder based tool
os.chdir(path)

# Permission fix (one time)
subprocess.call(["chmod","-R","+x","."])

# Python tool
if any(f.endswith(".py") for f in os.listdir(".")):
    if not os.path.exists(".venv"):
        subprocess.call(["python3","-m","venv",".venv"])
    subprocess.call([".venv/bin/pip","install","flask"])
    py = [f for f in os.listdir(".") if f.endswith(".py")][0]
    subprocess.call([".venv/bin/python", py])
    sys.exit()

# NodeJS tool
if os.path.exists("package.json"):
    subprocess.call(["npm","install"])
    subprocess.call(["npm","start"])
    sys.exit()

# Shell tool
sh = [f for f in os.listdir(".") if f.endswith(".sh")]
if sh:
    subprocess.call(["bash", sh[0]])
