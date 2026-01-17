import tkinter as tk
from tkinter import messagebox, simpledialog
import subprocess, json, os

GREEN = "#00ff66"
BG = "#0b0f0c"

root = tk.Tk()
root.title("HackNlearn India - Kali Tools Manager")
root.geometry("1000x600")
root.configure(bg=BG)

tools = []
current_category = "All"

def scan_tools():
    subprocess.call(["python3", "core/scanner.py"])
    load_tools()
    messagebox.showinfo("Scan", "Tool scan completed")

def load_tools():
    global tools
    tools_listbox.delete(0, tk.END)
    if not os.path.exists("data/tools.json"):
        return
    with open("data/tools.json") as f:
        tools = json.load(f)
    for i, t in enumerate(tools, 1):
        if current_category == "All" or t["category"] == current_category:
            tools_listbox.insert(
                tk.END,
                f"{i}. [{t['category']}] {t['name']}"
            )

def run_tool():
    sel = tools_listbox.curselection()
    if not sel:
        return
    name = tools_listbox.get(sel[0]).split("] ")[1]
    tool = next(t for t in tools if t["name"] == name)
    subprocess.Popen(["python3", "core/runner.py", tool["path"]])

def update_tools():
    subprocess.Popen(["python3", "core/updater.py"])

def install_tool():
    url = simpledialog.askstring("GitHub Tool", "Enter GitHub URL")
    if url:
        subprocess.Popen([
            "git","clone",url,
            "/opt/" + url.split("/")[-1].replace(".git","")
        ])

def set_category(cat):
    global current_category
    current_category = cat
    load_tools()

tk.Label(
    root,
    text="HackNlearn India - Kali Tools Manager",
    fg=GREEN, bg=BG, font=("Arial", 20, "bold")
).pack(pady=10)

top = tk.Frame(root, bg=BG)
top.pack()

for c in ["All","Web","Network","OSINT","Other"]:
    tk.Button(top, text=c, bg=GREEN,
              command=lambda x=c: set_category(x)).pack(side="left", padx=5)

frame = tk.Frame(root, bg=BG)
frame.pack(fill="both", expand=True)

tools_listbox = tk.Listbox(frame, bg="#000", fg=GREEN, font=("Courier", 12))
tools_listbox.pack(side="left", fill="both", expand=True, padx=10, pady=10)

btns = tk.Frame(frame, bg=BG)
btns.pack(side="right", fill="y")

tk.Button(btns, text="Scan Tools", command=scan_tools, bg=GREEN).pack(fill="x", pady=5)
tk.Button(btns, text="Run Tool", command=run_tool, bg=GREEN).pack(fill="x", pady=5)
tk.Button(btns, text="Update Tools", command=update_tools, bg=GREEN).pack(fill="x", pady=5)
tk.Button(btns, text="Install GitHub Tool", command=install_tool, bg=GREEN).pack(fill="x", pady=5)
tk.Button(btns, text="Exit", command=root.destroy, bg=GREEN).pack(fill="x", pady=5)

root.mainloop()
