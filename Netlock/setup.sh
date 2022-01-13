initialised_pak=false
restart_default=false
script_dir='/usr/local/bin'
default_editor='vim'
package='netlock'
dirname=${PWD##*/}
documentationurl='https://github.com/remcoeijsackers/Netlock'
usedshell=$(ps -p $$ -ocomm=)
filename=`basename "$0"`
exp_file="netlock.sh"
source netlock/src/checks.sh 

# -e needed for bash colour output
if [ $usedshell = "/bin/zsh" ] || [ $usedshell = "sh" ] || [ $usedshell = "zsh" ] || [ $usedshell = "/bin/sh" ]
then 
  colr=""
else
  colr="-e"
	read_assist="-p"
fi

check_install_status() {
	if  ! command -v netlock; then
		echo "Netlock is installed, uninstall?"
	fi
		printf "install now? y/n"
		read answer
		if [ $answer = 'y' ]
			then
				uninstall_netlock
			else
				echo 'Stopping Netlock uninstall.'
				exit 0
		fi
	fi
}

uninstall_netlock () {
	rmdir --ignore-fail-on-non-empty $script_dir/${script_container}
}

#make a script globally exc
make_global() {
	new_scriptname="$package"
	script_container="$dirname"
	cp -R $PWD/* $script_dir/
	chmod +x $script_dir/${script_container}/"${new_scriptname}.sh"
	if  [ $usedshell = "/bin/zsh" ] || [ $usedshell = "sh" ] || [ $usedshell = "zsh" ] || [ $usedshell = "/bin/sh" ]
	then
		# add alias for script
		echo "alias $package='${script_container}/${new_scriptname}.sh'" >> ~/.zshrc
	elif  [ $usedshell = "/bin/bash" ] || [ $usedshell = "bash" ]
	then
		# add alias for script
		echo "alias $package='${script_container}/${new_scriptname}.sh'" >> ~/.bashrc
	else 
		_list_rc
	fi
}

restart_shell() {
	echo ""
	echo "Package $package initialised. for shell: $usedshell."
	echo "Use '$package -h' to get more info."
	echo "Or read the documentation at: $documentationurl"
	echo $'Restarting shell. \n'
	if  [ $usedshell = "/bin/zsh" ] || [ $usedshell = "sh" ] || [ $usedshell = "zsh" ] || [ $usedshell = "/bin/sh" ]
	then
		exec zsh
	elif  [ $usedshell = "/bin/bash" ] || [ $usedshell = "bash" ]
	then
		exec bash
	else 
		exec $usedshell
	fi
}

_list_rc () {
		echo "shellrc file not found. current shell: $usedshell"
		echo "rc files found:"
		find ~/ -maxdepth 1 -name '*rc'
		exit 1
}

setup_package () {
	check_install_status
	check_tools_availability
    make_global
	restart_shell
}

setup_package

