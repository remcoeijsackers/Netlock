#!/bin/bash
hardware_disconnect() {
    interfaces=$(ifconfig -l)
    for x in $interfaces
    do 
        echo "Interface disconnected:" $x
        sudo ifconfig $x down 
    done
    exit 0
}

hardware_connect() {
    interfaces=$(ifconfig -l)
    for x in $interfaces 
    do 
        echo "Interface connected:" $x
        sudo ifconfig $x up
    done
    exit 0
}
