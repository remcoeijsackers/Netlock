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

# -e needed for bash colour output
if [ $usedshell = "/bin/zsh" ] || [ $usedshell = "sh" ] || [ $usedshell = "zsh" ] || [ $usedshell = "/bin/sh" ]
then 
  colr=""
else
  colr="-e"
	read_assist="-p"
fi

#make a script globally exc
make_global() {
	if  [ $usedshell = "/bin/zsh" ] || [ $usedshell = "sh" ] || [ $usedshell = "zsh" ] || [ $usedshell = "/bin/sh" ]
	then
		#rename script for find function
		new_scriptname="$package"
		script_container="$dirname"
		#move scripts to bin
		cp -R $PWD/* $script_dir/
		chmod +x $script_dir/${script_container}/"${new_scriptname}.sh"
		# add alias for script
		echo "alias $package='${script_container}/${new_scriptname}.sh'" >> ~/.zshrc
	elif  [ $usedshell = "/bin/bash" ] || [ $usedshell = "bash" ]
	then
		#rename script for find function
		new_scriptname="$package"
		script_container="$dirname"
		#move scripts to bin
		cp -R $PWD/* $script_dir/
		chmod +x $script_dir/${script_container}/"${new_scriptname}.sh"
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

_setup_package () {
    make_global
	restart_shell
}

_setup_package

