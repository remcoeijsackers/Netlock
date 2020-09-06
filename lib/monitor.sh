#!/bin/bash
# monitor the total network usage
source lib/util.sh 
source lib/hwblock.sh
monitor() {
  #Current usage, interface is the first argument
  echo "interface: $1, limit_in: $3, limit_out: $2"
  sleep 1
  current_bytes_out=$(netstat -ib | grep -e "$1" -m 1 | awk '{print $10}')
  cb_out=$(($current_bytes_out))
  current_bytes_in=$(netstat -ib | grep -e "$1" -m 1 | awk '{print $7}')
  cb_in=$(($current_bytes_in))
  while true
  do
    #outgoing traffic
    new_bytes_out=$(netstat -ib | grep -e "$1" -m 1 | awk '{print $10}')
    nb_out=$((new_bytes_out))
    total_bytes_out="$(($nb_out-$cb_out))"
    kilo_bytes_out="$(($total_bytes_out/1000))"
    mon_out=$(printf %.3f "$total_bytes_out"e-3)
    #incomming traffic
    new_bytes_in=$(netstat -ib | grep -e "$1" -m 1 | awk '{print $7}')
    nb_in=$((new_bytes_in))
    total_bytes_in="$(($nb_in-$cb_in))"
    kilo_bytes_in="$(($total_bytes_in/1000))"
    mon_in=$(printf %.3f "$total_bytes_in"e-3)
    overwrite "B OUT:" $mon_out "B IN:" $mon_in
    #traffic limits in the arguments
    limit_out=$2
    limit_in=$3
    #Disable the hardware when the limit is reached
    if (( $limit_out > 0 && $limit_in > 0 )); then 
        if (( $kilo_bytes_out > $limit_out || $kilo_bytes_in > $limit_in )); then
            echo "Limit traffic reached. hardware $1 disabled. enable it again with -d flag"
            echo "Usage: OUT: $mon_out B - IN: $mon_in B"
            ifconfig $1 down 
            break
        fi
        break
    elif (( $limit_out > 0 )); then
        if (( $kilo_bytes_out > $limit_out )); then
            echo "Limit traffic reached. hardware $1 disabled. enable it again with -d flag"
            echo "Usage: $mon_out B - IN: $mon_in B"
            ifconfig $1 down 
            break
        fi
        break
    elif (( $limit_in > 0 )); then 
        if (( $kilo_bytes_in > $limit_in )); then 
            echo "Limit incoming traffic reached. hardware $1 disabled. enable it again with -d flag"
            echo "Usage: $mon_out B - IN: $mon_in B"
            ifconfig $1 down 
            break
        fi
        break
    fi
  done
  exit 0
}

monitorclean() {
    #Current usage, interface is the first argument
    current_bytes_out=$(netstat -ib | grep -e "$1" -m 1 | awk '{print $10}')
    cb_out=$(($current_bytes_out))
    current_bytes_in=$(netstat -ib | grep -e "$1" -m 1 | awk '{print $7}')
    cb_in=$(($current_bytes_in))
    while true
    do
        #outgoing traffic
        new_bytes_out=$(netstat -ib | grep -e "$1" -m 1 | awk '{print $10}')
        nb_out=$((new_bytes_out))
        total_bytes_out="$(($nb_out-$cb_out))"
        kilo_bytes_out="$(($total_bytes_out/1000))"
        mon_out=$(printf %.3f "$total_bytes_out"e-3)
        #incomming traffic
        new_bytes_in=$(netstat -ib | grep -e "$1" -m 1 | awk '{print $7}')
        nb_in=$((new_bytes_in))
        total_bytes_in="$(($nb_in-$cb_in))"
        kilo_bytes_in="$(($total_bytes_in/1000))"
        mon_in=$(printf %.3f "$total_bytes_in"e-3)

        if (( $2=="out")); then 
            echo $total_bytes_out
        elif (( $2=="in" )); then
            echo $total_bytes_in 
        else 
            break
        fi
    done
    exit 0
}

#test if the internet is connected
ping_test() {
  sleep 8
  ping -c 1 google.com &> /dev/null && echo "Ping success: Interface is connected" && return 1 || echo "Ping failed: Interface is disconnected" && return 0
  exit 0
}

usage_test() { # 1: interface
  echo "checking traffic.."
  #Current usage, interface is the first argument
  current_bytes_out=$(netstat -ib | grep -e "$1" -m 1 | awk '{print $10}')
  cb_out=$(($current_bytes_out))
  current_bytes_in=$(netstat -ib | grep -e "$1" -m 1 | awk '{print $7}')
  cb_in=$(($current_bytes_in))
  while true
  do
    #outgoing traffic
    new_bytes_out=$(netstat -ib | grep -e "$1" -m 1 | awk '{print $10}')
    nb_out=$((new_bytes_out))
    total_bytes_out="$(($nb_out-$cb_out))"
    kilo_bytes_out="$(($total_bytes_out/1000))"
    mon_out=$(printf %.3f "$total_bytes_out"e-3)
    #incomming traffic
    new_bytes_in=$(netstat -ib | grep -e "$1" -m 1 | awk '{print $7}')
    nb_in=$((new_bytes_in))
    total_bytes_in="$(($nb_in-$cb_in))"
    kilo_bytes_in="$(($total_bytes_in/1000))"
    mon_in=$(printf %.3f "$total_bytes_in"e-3)
    limit_test=$((1/100000))
    echo "KB In" $kilo_bytes_out "KB Out" $kilo_bytes_in
    sleep 4
    if (( "$kilo_bytes_out" > "$limit_test" || "$kilo_bytes_in" > "$limit_test")); then
        echo "Interface has Traffic"
        break
    elif (( "$kilo_bytes_out" > "$limit_test" && "$kilo_bytes_in" > "$limit_test")); then
        echo "Interface has Traffic"
        break
    elif (( "$kilo_bytes_out" <= "$limit_test" && "$kilo_bytes_in" <= "$limit_test")); then 
        echo "Interface doesn't have Traffic"
        break
    elif (( "$kilo_bytes_out" <= "$limit_test" || "$kilo_bytes_in" <= "$limit_test")); then 
        echo "Interface doesn't have Traffic"
        break
    else 
        echo "Couldn't Get accurate status"
        break
    fi
done
exit 0
}

