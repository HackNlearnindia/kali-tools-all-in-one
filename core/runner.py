import sys
import os
import subprocess

tool_path = sys.argv[1]

def run(cmd):
    subprocess.call(cmd)

# ===============================
# SYSTEM COMMAND
# ===============================
if os.system(f"which {tool_path} > /dev/null 2>&1") == 0:
    run([tool_path])
    sys.exit(0)

# ===============================
# DIRECTORY BASED TOOL
# ===============================
os.chdir(tool_path)

# One-time permission fix
run(["chmod", "-R", "+x", "."])

# ===============================
# PYTHON TOOL
# ===============================
py_files = [f for f in os.listdir(".") if f.endswith(".py") and f != "__init__.py"]

if py_files:
    print("[+] Python tool detected")

    # Create venv if missing
    if not os.path.exists(".venv"):
        run(["python3", "-m", "venv", ".venv"])

    python_bin = ".venv/bin/python"

    # Ensure pip exists
    run([python_bin, "-m", "ensurepip", "--upgrade"])
    run([python_bin, "-m", "pip", "install", "--upgrade", "pip"])

    # Install dependencies
    if os.path.exists("requirements.txt"):
        run([python_bin, "-m", "pip", "install", "-r", "requirements.txt"])
    else:
        # Common fallback
        run([python_bin, "-m", "pip", "install", "flask", "requests"])

    # Run selected python file
    run([python_bin, py_files[0]])
    sys.exit(0)

# ===============================
# NODEJS TOOL
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
