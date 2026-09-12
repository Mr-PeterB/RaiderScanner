<div align="center">
  <img src="https://user-images.githubusercontent.com/83140947/200195818-5d7b369a-0173-417d-abd8-553115a0c877.png" alt="Raider Scanner Logo">
  
  # 🏴‍☠️ Raider Scanner v3.4

  ![Version](https://img.shields.io/badge/version-v3.4-blue.svg)
  ![Bash](https://img.shields.io/badge/language-bash-green.svg)
  ![Platform](https://img.shields.io/badge/platform-linux-lightgrey.svg)
</div>
## 📖 Description
**Raider** is a streamlined automation tool designed for Pentesters. It combines multiple reconnaissance phases into a single, cohesive workflow, saving time and keeping your output organized.

### ✨ Features:
* **Host Discovery:** Fast, firewall-evading ping sweeps across multiple subnets/VLANs.
* **Port Scanning:** Automated TCP and UDP Nmap scans on discovered hosts.
* **Web Reconnaissance:** Automated integration with WhatWeb and EyeWitness.
* **SSH Spraying:** Test private keys against all discovered active hosts.
* **Nessus Parsing:** Format and grep outputs cleanly for Nessus imports.

---
## ⚙️ Installation

Clone the repository and create a symbolic link so you can run it from anywhere:
```bash
git clone git@github.com:Mr-PeterB/RaiderScanner.git
sudo ln -s $(pwd)/RaiderScanner/raider /usr/local/bin/
```
***
## 🖥️ Usage & Help Menu:
```
USAGE:
        raider [options]

OPTIONS:

    Host Discovery:
        -d, --discovery    Find alive hosts across specified subnets.
        -f, --file <file>  Input file containing subnets (one per line).
                           Format example:
                             10.0.1.0/24
                             192.168.1.0/24
        -e, --extended     Use extended discovery techniques if ICMP (ping) is blocked.
        --ee               Perform live host discovery by doing port scan.

    Port Scanning:
        -f, --file <file>  Input file containing target hosts (one per line).
        -t, --tcp          Perform TCP port scans.
        -u, --udp          Perform UDP port scans.
        -r, --restore      Restore the previous scanning session.

    SSH Authentication:
        -f, --file <file>  Input file containing target hosts (one per line).
        -i, --identity     Path to the private SSH key file (e.g., id_rsa).
        -s, --ssh <user>   The username to use for SSH authentication.

    Web Reconnaissance:
        -f, --file <file>  Input file containing target hosts (one per line).
        -w, --web          Run WhatWeb and EyeWitness to gather and organize web pages.

    Output Formatting:
        --nessus           Format and grep discovered hosts/ports for Nessus import.

    Global Options:
        -h, --help         Display this help menu and exit.

EXAMPLES:

    Discover Live Hosts (VLANs):
        raider -f subnets.txt -d
        raider -f subnets.txt -d -e

    Port Scanning (TCP / UDP):
        raider -f hosts.txt -t
        raider -f hosts.txt -u
        raider -f hosts.txt -t -u

    Restore TCP/UDP scan:
        raider -r

    SSH Spraying:
        raider -f hosts.txt -s root -i ~/.ssh/id_rsa

    Web Scanning:
        raider -f all_live_hosts.txt -w

    Format for Nessus:
        raider -f all_live_hosts.txt --nessus
```
***

## 📡 1. Host Discovery
First, create a *.txt* file containing the subnets you want to scan for live hosts:
```
$ cat subnets.txt
192.168.1.0/24
10.6.15.0/24
10.1.0.0/16
10.6.6.0/26
```
Then, run the discovery command. (Note: Requires sudo for raw packet privileges).
```bash
sudo raider -f subnets.txt -d
```
📝 Results:
```
$ ls
192.168.1.0_24
10.6.15.0_24
10.1.0.0_16
10.6.6.0_26
all_live_hosts.txt
```
The tool automatically generates an *all_live_hosts.txt* file containing a consolidated list of every active IP found across all subnets.

## 🚪 2. TCP Port Scan
You can pass the consolidated output file directly back into Raider to perform a TCP scan on the live hosts:
```bash
sudo raider -f all_live_hosts.txt -t
```
## ⚡ 3. TCP & UDP Port Scan
```bash
sudo raider -f all_live_hosts.txt -t -u
```
## 💡 4. Pro-Tip: Chaining Commands
If you have multiple subnets in scope, you can chain the host discovery and port scanning commands together to fully automate your initial network reconnaissance in one line:
```bash
sudo raider -f subnets.txt -d; sudo raider -f all_live_hosts.txt -t -u
```
