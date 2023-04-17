![image](https://user-images.githubusercontent.com/83140947/200195818-5d7b369a-0173-417d-abd8-553115a0c877.png)

# Raider Scanner v2.0
## Description
A simple tool for Pentesters that combines and runs nmap scans.
***
## Installation:
```
git clone https://github.com/Mr-PeterB/RaiderScanner.git
sudo ln -s $(pwd)/RaiderScanner/raider /usr/local/bin/
```
***
## Usage:
raider [hosts file]

USAGE:

        raider [options]

OPTIONS:
        -f, --file      The file with hosts
        -t, --tcp       Use tcp scans
        -u, --udp       Use udp scans
        -r, --restore   Restore the previous session
        -h, --help      Help Menu

EXAMPLES:
raider -r
raider  -f [hosts file] -t
raider -f [hosts file] -t -u
