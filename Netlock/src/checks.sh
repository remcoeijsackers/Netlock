#!/bin/sh
check_tools_availability() {
	if ! command -v ifconfig -l &> /dev/null || ! command -v netstat  &> /dev/null 
        then
            echo "net-tools does not seem to be installed and is required by the package."
			echo "install now? y/n"
			read answer
			if [ $answer = 'y' ]
			then
				_install_tools
			else
				echo 'Stopping Netlock setup.'
				exit 0
			fi
    fi
}

_install_tools() {
	if [ ${uname -s} = "Darwin" ]; then
		sudo brew install net-tools -y
	elif [ ${uname -s} = "Ubuntu" ]; then
		sudo apt-get install net-tools -y
	else 
		echo "Auto install of net-tools failed. Unkown package manager."
		echo "please install net-tools manually, and run the setup again (e.g. sudo apt-get install net-tools)"
		exit 0
	fi
}

check_available_interfaces() {
    if ! echo "$(ifconfig -l)" | grep -q $1; then
        echo "Interface $1 not found."
        echo "Please choose one of the following;"
        echo "$(ifconfig -l)" 
        exit 0
    fi
}