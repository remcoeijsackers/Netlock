#!/bin/bash
hardware_disconnect() {
    interfaces=$(ifconfig -l)
    outp=""
    for x in $interfaces
    do 
        outp+="${x}, "
        sudo ifconfig $x down 
    done
    echo "Interfaces disconnected: $outp"
    exit 0
}

hardware_connect() {
    interfaces=$(ifconfig -l)
    outp=""
    for x in $interfaces 
    do 
        outp+="${x}, "
        sudo ifconfig $x up
    done
    echo "Interfaces connected: $outp"
    exit 0
}
