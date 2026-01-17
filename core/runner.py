import os
import sys
import subprocess

tool_path = sys.argv[1]

def run(cmd, shell=False):
    subprocess.call(cmd, shell=shell)

# Always use bash
os.environ["SHELL"] = "/bin/bash"

# ===============================
# SYSTEM COMMAND
# ===============================
if os.path.isfile(tool_path) is False and os.system(f"which {tool_path} > /dev/null 2>&1") == 0:
    run([tool_path])
    sys.exit(0)

# ===============================
# DIRECTORY TOOL
# ===============================
os.chdir(tool_path)

# One-time permission fix
run("chmod -R +x .", shell=True)

# ===============================
# PYTHON TOOL (KALI SAFE)
# ===============================
py_files = [f for f in os.listdir(".") if f.endswith(".py") and f != "__init__.py"]

if py_files:
    print("[+] Python tool detected")

    # Install dependencies using SYSTEM pip
    if os.path.exists("requirements.txt"):
        run(["sudo", "pip3", "install", "-r", "requirements.txt"])
    else:
        run(["sudo", "pip3", "install", "flask", "requests"])

    # Run python file
    run(["python3", py_files[0]])
    sys.exit(0)

# ===============================
# NODE TOOL
# ===============================
if os.path.exists("package.json"):
    print("[+] NodeJS tool detected")
    run(["npm", "install"])
    run(["npm", "start"])
    sys.exit(0)

# ===============================
# SHELL TOOL
# ===============================
sh_files = [f for f in os.listdir(".") if f.endswith(".sh")]

if sh_files:
    run(["bash", sh_files[0]])
    sys.exit(0)

# ===============================
# FALLBACK
# ===============================
print("[-] No runnable file found")
