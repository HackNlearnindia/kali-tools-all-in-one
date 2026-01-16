# Kali Tools All In One
Framework Name: HackNlearn India

This is an educational automation project for Kali Linux.
It scans Kali tools, opens documentation in Chrome,
suggests fixes for errors, and loads educational GitHub labs.

🟢 STEP 1: FRESH RE-INSTALL (GITHUB SE)
git clone https://github.com/HackNlearnindia/kali-tools-all-in-one.git


Folder me jao:

cd kali-tools-all-in-one

🟢 STEP 2: REQUIRED TOOLS + LINE FIX (VERY IMPORTANT)
sudo apt update
sudo apt install dos2unix git -y
find . -type f -name "*.sh" -exec dos2unix {} \;

🟢 STEP 3: EXECUTION PERMISSION DO
chmod +x run.sh
chmod +x core/*.sh

🟢 STEP 4: PROJECT RUN KARO 🚀
bash run.sh


🔴 PROBLEM CONFIRMED

Error:

$'\r': command not found


👉 Matlab:

run.sh (aur core/*.sh) Windows CRLF format me hain

Kali ko Linux LF chahiye

✅ ONE-SHOT FINAL FIX (COPY–PASTE ONLY)
🟢 STEP 1: Project folder me ho (confirm)
cd ~/kali-tools-all-in-one

🟢 STEP 2: dos2unix install (agar already hai to bhi OK)
sudo apt update
sudo apt install dos2unix -y

🟢 STEP 3: FORCE FIX – SAB .sh FILES

⚠️ Ye sabse important command hai

find . -type f -name "*.sh" -print0 | xargs -0 dos2unix


👉 Ye command:

run.sh

core/menu.sh

core/*.sh
sabko pure Linux format me convert karegi.

🟢 STEP 4: Execute permission do
chmod +x run.sh
chmod +x core/*.sh

🟢 STEP 5: AB RUN KARO 🚀
bash run.sh


⚠ Educational Purpose Only
Author: HackNlearn India



