#!/bin/bash


if [[ $EUID -ne 0 ]]; then
'Please run this script as root.' 1>&2
exit 1
fi

file_path=$1

if [[ (-z  "$file_path") || ($@ == "--help") || ($@ == "-h")]];then
       echo "[+] Usage: $0 [host file]
        
EXAMPLE:
$0 ~/Desktop/hosts.txt
        "
        exit 1
fi
if [ -f "$file_path" ]; then
echo "
██████╗  █████╗ ██╗██████╗ ███████╗██████╗     ███████╗ ██████╗ █████╗ ███╗   ██╗███╗   ██╗███████╗██████╗ 
██╔══██╗██╔══██╗██║██╔══██╗██╔════╝██╔══██╗    ██╔════╝██╔════╝██╔══██╗████╗  ██║████╗  ██║██╔════╝██╔══██╗
██████╔╝███████║██║██║  ██║█████╗  ██████╔╝    ███████╗██║     ███████║██╔██╗ ██║██╔██╗ ██║█████╗  ██████╔╝
██╔══██╗██╔══██║██║██║  ██║██╔══╝  ██╔══██╗    ╚════██║██║     ██╔══██║██║╚██╗██║██║╚██╗██║██╔══╝  ██╔══██╗
██║  ██║██║  ██║██║██████╔╝███████╗██║  ██║    ███████║╚██████╗██║  ██║██║ ╚████║██║ ╚████║███████╗██║  ██║
╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝
                                                                                                                                                       
                                                                                         
                                ⠀⠀⠀⠀⠀⠀⠀⣠⣤⡀⠀⠀⢀⣤⣀⠀⠀⠀⠀⠀⠀⠀
                                ⠀⠀⠀⠀⠀⣠⣾⣿⡿⠁⠀⠀⠈⢿⣿⣷⣄⠀⠀⠀⠀⠀
                                ⠀⠀⠀⢠⣾⣿⣿⡿⠀⠀⠀⠀⠀⠈⣿⣿⣿⣧⡀⠀⠀⠀
                                ⠀⠀⣰⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⡄⠀⠀
                                ⠀⣴⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⡄⠀
                                ⢠⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⠀
                                ⣾⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⡇
                                ⣿⣿⣿⣿⠟⠁⢀⡀⠀⠀⠀⠀⠀⠀⢀⡀⠈⠻⣿⣿⣿⣿
                                ⣿⣿⠟⠁⢀⣴⣿⣷⡀⠀⣴⣦⠀⢀⣾⣿⣦⡀⠈⠻⣿⣿
                                ⠟⠁⠀⣰⣿⣿⣿⣿⣿⣿⡇⢸⣿⣿⣿⣿⣿⣿⣆⠀⠈⠻
                                ⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣧⣼⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀
                                ⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃
                                ⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀
                                ⠀⠘⣿⣿⣿⣿⣿⡟⠀⠈⣿⣿⠁⠀⣿⣿⣿⣿⣿⡿⠁⠀
                                ⠀⠀⠈⠻⠿⠿⠟⠁⠀⠀⠹⠏⠀⠀⠈⠻⠿⠿⠟⠁⠀⠀
                                                                        ____    ___  
                                                                 __   _|___ \  / _ \
                                                                 \ \ / / __) || | | |
                                                                  \ V / / __/ | |_| |
                                                                   \_/ |_____(_)___/                                                                                       
"

echo -e "\n\n"

while read -r host
do
echo -e "
\n---------------------------------------------$host--------------------------------------------------------\n
"

mkdir -p $host/tcp
nmap -vv -p- --open $host -oN $host/tcp/all_tcp_ports.txt
ports=`awk '/ open / && /tcp/ {print $1}' $host/tcp/all_tcp_ports.txt | awk -F "/" '{printf "%s,",$1}' | sed 's/.$//'`

if [ -n "$ports" ];then

        nmap -sV -Pn -p$ports $host -oN $host/tcp/full_tcp.txt
        nmap -A -p$ports $host -oN $host/tcp/aggr_tcp.txt
        nmap --script vuln -p$ports $host -oN $host/tcp/nmap_vuln.txt

fi

done < $file_path







echo "
----------------------------------------------------------------------
██████╗ ███████╗███████╗██████╗     ███████╗ ██████╗ █████╗ ███╗   ██╗
██╔══██╗██╔════╝██╔════╝██╔══██╗    ██╔════╝██╔════╝██╔══██╗████╗  ██║
██║  ██║█████╗  █████╗  ██████╔╝    ███████╗██║     ███████║██╔██╗ ██║
██║  ██║██╔══╝  ██╔══╝  ██╔═══╝     ╚════██║██║     ██╔══██║██║╚██╗██║
██████╔╝███████╗███████╗██║         ███████║╚██████╗██║  ██║██║ ╚████║
╚═════╝ ╚══════╝╚══════╝╚═╝         ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═══╝
----------------------------------------------------------------------                                                                      
"

while read -r host
do
echo -e "
\n---------------------------------------------$host--------------------------------------------------------\n
"
nmap -vv -p- -Pn -sS --open $host -oN $host/tcp/all_tcp_ports_deep.txt
ports=`awk '/ open / && /tcp/ {print $1}' $host/tcp/all_tcp_ports_deep.txt | awk -F "/" '{printf "%s,",$1}' | sed 's/.$//'`
old_ports=`awk '/ open / && /tcp/ {print $1}' $host/tcp/all_tcp_ports.txt | awk -F "/" '{printf "%s,",$1}' | sed 's/.$//'`

if [ "$ports" != "$old_ports" ];then

        nmap -sV -Pn -p$ports $host -oN $host/tcp/full_tcp_deep.txt
        nmap -A -p$ports $host -oN $host/tcp/aggr_tcp_deep.txt
        nmap --script vuln -p$ports $host -oN $host/tcp/nmap_vuln_deep.txt
       



elif [ -z "$ports" ];then

        nmap -n -sn -PE $host -oN $host/ping.txt
        pin=`awk '/Host is up/ ' $host/ping.txt`
        if [ -n "$pin" ] ; then

                echo "
 :::::::: ::::::::::: ::::::::::     :::     :::    ::::::::::: :::    ::: 
:+:    :+:    :+:     :+:          :+: :+:   :+:        :+:     :+:    :+: 
+:+           +:+     +:+         +:+   +:+  +:+        +:+     +:+    +:+ 
+#++:++#++    +#+     +#++:++#   +#++:++#++: +#+        +#+     +#++:++#++ 
       +#+    +#+     +#+        +#+     +#+ +#+        +#+     +#+    +#+ 
#+#    #+#    #+#     #+#        #+#     #+# #+#        #+#     #+#    #+# 
 ########     ###     ########## ###     ### ########## ###     ###    ### 
::::    ::::   ::::::::  :::::::::  ::::::::::                             
+:+:+: :+:+:+ :+:    :+: :+:    :+: :+:                                    
+:+ +:+:+ +:+ +:+    +:+ +:+    +:+ +:+                                    
+#+  +:+  +#+ +#+    +:+ +#+    +:+ +#++:++#                               
+#+       +#+ +#+    +#+ +#+    +#+ +#+                                    
#+#       #+# #+#    #+# #+#    #+# #+#                                    
###       ###  ########  #########  ##########                             
                "
                nmap -vv -p- -sM -Pn $host -oN $host/tcp/bypass_firewall1.txt

                ports=`awk '/ open / && /tcp/ {print $1}' $host/tcp/bypass_firewall1.txt | awk -F "/" '{printf "%s,",$1}' | sed 's/.$//'`
                echo -e "\n--------------------------------------------------------------\n"
                if [ -z "$ports" ];then
                        nmap -vv -p- -Pn -f $host -oN $host/tcp/bypass_firewall2.txt
                        ports=`awk '/ open / && /tcp/ {print $1}' $host/tcp/bypass_firewall2.txt | awk -F "/" '{printf "%s,",$1}' | sed 's/.$//'`
                        echo -e "\n--------------------------------------------------------------\n"
                        if [ -z "$ports" ];then
                                nmap -vv -p- -Pn --script firewall-bypass $host -oN $host/tcp/bypass_firewall3.txt
                                ports=`awk '/ open / && /tcp/ {print $1}' $host/tcp/bypass_firewall3.txt | awk -F "/" '{printf "%s,",$1}' | sed 's/.$//'`
                                echo -e "\n--------------------------------------------------------------\n"
                                if [ -z "$ports" ];then
                                        nmap -vv -p- -Pn -D RND:10 $host -oN $host/tcp/bypass_firewall4.txt
                                        ports=`awk '/ open / && /tcp/ {print $1}' $host/tcp/bypass_firewall4.txt | awk -F "/" '{printf "%s,",$1}' | sed 's/.$//'`
                                        echo -e "\n--------------------------------------------------------------\n"
                                        if [ -z "$ports" ];then
                                                        echo "                                                           
@@@      @@@@@@@@  @@@  @@@  @@@  @@@@@@@@     @@@  @@@  @@@@@@@   
@@@     @@@@@@@@@  @@@  @@@  @@@  @@@@@@@@     @@@  @@@  @@@@@@@@  
@@!     !@@        @@!  @@!  @@@  @@!          @@!  @@@  @@!  @@@  
!@!     !@!        !@!  !@!  @!@  !@!          !@!  @!@  !@!  @!@  
!!@     !@! @!@!@  !!@  @!@  !@!  @!!!:!       @!@  !@!  @!@@!@!   
!!!     !!! !!@!!  !!!  !@!  !!!  !!!!!:       !@!  !!!  !!@!!!    
!!:     :!!   !!:  !!:  :!:  !!:  !!:          !!:  !!!  !!:       
:!:     :!:   !::  :!:   ::!!:!   :!:          :!:  !:!  :!:       
 ::      ::: ::::   ::    ::::     :: ::::     ::::: ::   ::       
:        :: :: :   :       :      : :: ::       : :  :    :        
                                                                   
                                        "
                                        else
                                                nmap -sV -Pn -p$ports $host -oN $host/tcp/full_tcp_bypass4.txt
                                                nmap -A -p$ports $host -oN $host/tcp/aggr_tcp_bypass4.txt
                                                nmap --script vuln -p$ports $host -oN $host/tcp/nmap_vuln_bypass4.txt
                                        fi



                                else
                                        nmap -sV -Pn -p$ports $host -oN $host/tcp/full_tcp_bypass3.txt
                                        nmap -A -p$ports $host -oN $host/tcp/aggr_tcp_bypass3.txt
                                        nmap --script vuln -p$ports $host -oN $host/tcp/nmap_vuln_bypass3.txt
                                fi

                        else
                                nmap -sV -Pn -p$ports $host -oN $host/tcp/full_tcp_bypass2.txt
                                nmap -A -p$ports $host -oN $host/tcp/aggr_tcp_bypass2.txt
                                nmap --script vuln -p$ports $host -oN $host/tcp/nmap_vuln_bypass2.txt
                                fi

                else
                        nmap -sV -Pn -p$ports $host -oN $host/tcp/full_tcp_bypass1.txt
                        nmap -A -p$ports $host -oN $host/tcp/aggr_tcp_bypass1.txt
                        nmap --script vuln -p$ports $host -oN $host/tcp/nmap_vuln_bypass1.txt
                fi
        else
                echo "                                                                     
██╗  ██╗ ██████╗ ███████╗████████╗    ██████╗  ██████╗ ██╗    ██╗███╗   ██╗
██║  ██║██╔═══██╗██╔════╝╚══██╔══╝    ██╔══██╗██╔═══██╗██║    ██║████╗  ██║
███████║██║   ██║███████╗   ██║       ██║  ██║██║   ██║██║ █╗ ██║██╔██╗ ██║
██╔══██║██║   ██║╚════██║   ██║       ██║  ██║██║   ██║██║███╗██║██║╚██╗██║
██║  ██║╚██████╔╝███████║   ██║       ██████╔╝╚██████╔╝╚███╔███╔╝██║ ╚████║
╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝       ╚═════╝  ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝
                "
        fi
       

fi


done < $file_path



echo "
-----------------------------------------------------------------
██╗   ██╗██████╗ ██████╗     ███╗   ███╗ ██████╗ ██████╗ ███████╗
██║   ██║██╔══██╗██╔══██╗    ████╗ ████║██╔═══██╗██╔══██╗██╔════╝
██║   ██║██║  ██║██████╔╝    ██╔████╔██║██║   ██║██║  ██║█████╗  
██║   ██║██║  ██║██╔═══╝     ██║╚██╔╝██║██║   ██║██║  ██║██╔══╝  
╚██████╔╝██████╔╝██║         ██║ ╚═╝ ██║╚██████╔╝██████╔╝███████╗
 ╚═════╝ ╚═════╝ ╚═╝         ╚═╝     ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝
-----------------------------------------------------------------                                                                 
"

while read -r host
do

mkdir -p $host/udp

portstcp=`awk '/ open / && /tcp/ {print $1}' $host/tcp/all_tcp_ports_deep.txt | awk -F "/" '{printf "%s,",$1}' | sed 's/.$//'`

if [ -z "$portstcp" ];then
        
        pin=`awk '/Host is up/ ' $host/ping.txt`
        
        if [ -n "$pin" ] ; then

                echo -e "\n---------------------------------------------$host--------------------------------------------------------\n"

                nmap -vv -p- -sU $host -oN $host/udp/all_udp_ports.txt
                portsudp=`awk '/ open / && /udp/ {print $1}' $host/udp/all_udp_ports.txt | awk -F "/" '{printf "%s,",$1}' | sed 's/.$//'`

                if [ -z "$portsudp" ];then

                        nmap -sU -Pn -sV -p$portsudp $host -oN $host/udp/full_udp.txt

                fi
        fi
else

        nmap -vv -p- -sU $host -oN $host/udp/all_udp_ports.txt
        portsudp=`awk '/ open / && /udp/ {print $1}' $host/udp/all_udp_ports.txt | awk -F "/" '{printf "%s,",$1}' | sed 's/.$//'`

        if [ -z "$portsudp" ];then

                nmap -sU -Pn -sV -p$portsudp $host -oN $host/udp/full_udp.txt

        fi
fi

done < $file_path




echo -e "\n\n"
echo "
--------------------------------------------------------------
--------------------------------------------------------------

███████╗██╗███╗   ██╗██╗███████╗██╗  ██╗███████╗██████╗ ██╗██╗
██╔════╝██║████╗  ██║██║██╔════╝██║  ██║██╔════╝██╔══██╗██║██║
█████╗  ██║██╔██╗ ██║██║███████╗███████║█████╗  ██║  ██║██║██║
██╔══╝  ██║██║╚██╗██║██║╚════██║██╔══██║██╔══╝  ██║  ██║╚═╝╚═╝
██║     ██║██║ ╚████║██║███████║██║  ██║███████╗██████╔╝██╗██╗
╚═╝     ╚═╝╚═╝  ╚═══╝╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝╚═╝
--------------------------------------------------------------
--------------------------------------------------------------
"


else 
    echo "\"$file_path\" does not exist."
fi

   
#Banners Info
# https://manytools.org/hacker-tools/ascii-banner/
# ANSI Shadow
# https://patorjk.com/software/taag/#p=display&h=2&v=3&f=Standard&t=v2.0
