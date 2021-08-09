initialised_pak=false
restart_default=false
script_dir='/usr/local/bin'
default_editor='vim'
package='netlock'

red=`tput setaf 1`
cyan=`tput setaf 6`
green=`tput setaf 2`
reset=`tput sgr0`

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
		#move scripts to bin
		cp -R $PWD/* $script_dir/
		chmod +x $script_dir/$package/"${new_scriptname}.sh"
		# add alias for script
		echo "alias $package='$package/${new_scriptname}.sh'" >> ~/.zshrc
	elif  [ $usedshell = "/bin/bash" ] || [ $usedshell = "bash" ]
	then
		#rename script for find function
		new_scriptname="$package"
		#move scripts to bin
		cp -R $PWD/* $script_dir/
		chmod +x $script_dir/$package/"${new_scriptname}.sh"
		# add alias for script
		echo "alias $package='$package/${new_scriptname}.sh'" >> ~/.bashrc
	else 
		_list_rc
	fi
}

restart_shell() {
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

