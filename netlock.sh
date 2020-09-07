#!/bin/bash
# ------------------------------------------------------------------
# [ImmortalsOnly] Netlock
#          Monitor traffic and disable hardware when a treshhold is reached.
# ------------------------------------------------------------------
VERSION=0.1
# --- Includes          --------------------------------------------
source src/info.sh
source src/util.sh
source src/hwblock.sh
source src/config.sh
source src/monitor.sh
# --- Option processing --------------------------------------------
if [ $# == 0 ] ; then
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
        HEADER $OPTARG 
        monitor $OPTARG $OPTARG $OPTARG
        exit 0;
        ;;
      "c")
        monitorclean $OPTARG $OPTARG
        exit 0;
      ;;
      *)
        echo "Unknown error while processing options"
        exit 0;
        ;;
    esac
  done


