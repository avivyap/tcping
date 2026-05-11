#!/bin/bash


# tcping.sh ip

#  Three-Way Handshake
# SYN -> SYN/ACK -> ACK

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"
orangeColour="\e[38;5;208m\033[1m"
whiteColour="\e[0;97m\033[1m"
whiteUltra="\e[38;5;231m"

trap ctrl_c INT
function ctrl_c(){

	echo -e "${redColour}[!] Saliendo...${endColour}"
	tput cnorm; exit 1
}


function helpPanel(){

	echo -e "\n${yellowColour}[+]${endColour} Use: ./tcping.sh -i <IP-TARGET> -p <PORT>\n"
	echo -e "\t${purpleColour}i)${endColour} specify the ip you want to tcping${endColour}\n"
	echo -e "\t${purpleColour}p)${endColour} specify the port that you want to know if it is open ${endColour}\n"
	tput cnorm
}

function tcping(){

	local regex='^([0-9]{1,3}\.){3}[0-9]{1,3}$'
	local regex_port='^([1-9][0-9]{0,3}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5])$'

	if [[ $ip =~ $regex ]]; then
		if [[ $port =~ $regex_port ]]; then


			for i in {1..2};do ### seguir configurando el bucle para hacer varios tcping


				if timeout 2 bash -c "</dev/tcp/$ip/$port" 2>/dev/null;then

					echo -e "\n${greenColour}[+]${endColour}${purpleColour} Host accessible on port $port seq=$ip{endColour}\n"
				else

					echo -e "\n${redColour}[!]${endColour}${purpleColour} Host reachable on port $port seq=$ip\n"

				fi

				sleep 1
			done
		else
			echo -e "\n${redColour}[!]${endColour}${grayColour} You must enter a valid port${endColour}\n"
			tput cnorm; exit 1
		fi

	else

		echo -ne "\n${redColour}[!]${endColour}${grayColour} You must enter a valid IP${endColour}\n"
		tput cnorm; exit 1

	fi
	tput cnorm

}

tput civis
declare -i parametro=0;while getopts ":i:p:" arg;do

	case $arg in
		i) ip=$OPTARG; let parametro+=1;;
		p) port=$OPTARG; let parametro+=1;;
	esac
done

if [[ $parametro == "0" || $parametro == "1" ]];then

	helpPanel

else
	tcping

fi
