![image](https://user-images.githubusercontent.com/83140947/200195818-5d7b369a-0173-417d-abd8-553115a0c877.png)

# Raider Scanner v2.3
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
```
USAGE:

        raider [options]

OPTIONS:
        Host Discovery:
        -d, --discovery Find alive hosts on several subnets.
                        (Read a text file with the subnets in it
                         Format: 10.0.1.0/24
                                 192.168.1.0/24
                                 10.11.55.0/24)
        Port Scanning:
        -f, --file      The file with hosts (one by one in line)
        -t, --tcp       Use tcp scans
        -u, --udp       Use udp scans
        -r, --restore   Restore the previous session
        -h, --help      Help Menu

EXAMPLES:
raider -d subnets.txt
raider -r
raider  -f hostses.txt -t
raider -f hostes -t -u
```
