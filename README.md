![image](https://user-images.githubusercontent.com/83140947/200195818-5d7b369a-0173-417d-abd8-553115a0c877.png)

# Raider Scanner v2.6
## Description
A simple tool for Pentesters that combines and runs nmap scans.
***
## Installation:

```bash
git clone git@github.com:Mr-PeterB/RaiderScanner.git
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
***
## For Host Discovery
We write into a .txt file the subnets we want to scan for alive hosts:
```
$ cat subnets.txt
192.168.1.0/24
10.6.15.0/24
10.1.0.0/16
10.6.6.0/26
```
And then run the command
```bash
sudo ./raider -d subnets.txt
```
Results:
```
$ ls
192.168.1.0_24
10.6.15.0_24
10.1.0.0_16
10.6.6.0_26
all_live_hosts.txt
```
The "all_live_hosts.txt" contains the alive hosts from all the subnets.
## For tcp scan:
We can use the following command for the previous file to perform tcp scan to all live hosts:
```bash
sudo ./raider -f all_live_hosts.txt -t
```
## For tcp and udp:
```bash
sudo ./raider -f all_live_hosts.txt -t -u
```
## Extra Tip
**If you have subnets into scope then you can run** 
```bash
sudo ./raider -d subnets.txt; ./raider -f all_live_hosts.txt -t -u
```
