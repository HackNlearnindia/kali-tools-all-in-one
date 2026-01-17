WEB = [
    "nmap","nikto","sqlmap","dirb","dirsearch","wpscan",
    "burpsuite","whatweb","gobuster"
]

NETWORK = [
    "wireshark","tcpdump","aircrack-ng","ettercap",
    "netdiscover","hydra"
]

OSINT = [
    "theharvester","amass","recon-ng","maltego","shodan"
]

def get_category(name):
    n = name.lower()
    if n in WEB:
        return "Web"
    if n in NETWORK:
        return "Network"
    if n in OSINT:
        return "OSINT"
    return "Other"
