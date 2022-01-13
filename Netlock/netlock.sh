#!/bin/bash
# ------------------------------------------------------------------
# [Remco Eijsackers] Netlock
#          Monitor traffic and disable hardware when a treshhold is reached.
# ------------------------------------------------------------------
VERSION=0.1.1
# --- Includes          --------------------------------------------
source netlock/src/info.sh
source netlock/src/util.sh
source netlock/src/hwblock.sh
source netlock/src/config.sh
source netlock/src/monitor.sh
source netlock/src/checks.sh
# --- Option processing --------------------------------------------
if [ $# == 0 ] ; then
    check_tools_availability
    USAGE
    exit 1;
fi
while getopts "vhtndsm:c:" optname
  do
    case "$optname" in
      "v")
        echo " Netlock $VERSION"
        exit 0;
        ;;
      "h")
        HELP
        exit 0;
        ;;
      "?")
        echo "Unknown option $OPTARG"
        exit 0;
        ;;
      ":")
        echo "No argument value for option $OPTARG"
        exit 0;
        ;;
      "t")
        ping_test
        usage_test $OPTARG
        exit 0;
        ;;
      "n")
        hardware_disconnect
        if $CON_CHECKS; then
          ping_test
          usage_test $OPTARG
        fi
        exit 0;
        ;;
      "d")
        hardware_connect
        if $CON_CHECKS; then
          ping_test
          usage_test $OPTARG
        fi
        exit 0;
        ;;
      "m")
        if  check_available_interfaces $2; then
          if [ $# -eq 5 ] && [ $5 == "safe" ];
            then
              HEADER $2 "Safe -- disable all network interfaces on Threshold"
              monitor $2 $3 $4 true
          elif [ $# -eq 4 ];
            then
              HEADER $2 "Threshold -- disable the network interface on Threshold"
              monitor $2 $3 $4 false
          elif [ $# -eq 2 ];
            then 
              HEADER  $2 "Monitor only"
              monitor $2 0 0 false
          fi
        fi
        exit 0;
        ;;
      "c")
        if  check_available_interfaces $2; then
          monitorclean $OPTARG $OPTARG
        fi
        exit 0;
      ;;
      "u")
        uninstall_netlock
        exit 0;
      ;;
      *)
        echo "Unknown error while processing options"
        exit 0;
        ;;
    esac
  done


