import json, os
from categories import get_category

tools = []

# System commands
for c in os.popen("compgen -c").read().split():
    tools.append({
        "name": c,
        "path": c,
        "category": get_category(c)
    })

# External tools (HOME + /opt)
for base in [os.path.expanduser("~"), "/opt"]:
    if os.path.exists(base):
        for d in os.listdir(base):
            p = os.path.join(base, d)
            if os.path.isdir(p):
                tools.append({
                    "name": d,
                    "path": p,
                    "category": get_category(d)
                })

os.makedirs("data", exist_ok=True)
with open("data/tools.json","w") as f:
    json.dump(tools, f, indent=2)
