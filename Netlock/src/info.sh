HELP() {
    echo "
================================================================
 Netlock
================================================================
 SYNOPSIS
    Netlock [-vht:ndsm:c:] args ...

 DESCRIPTION
    Monitor network traffic and disable hardware when a treshhold is reached.

 OPTIONS
  -v version: display version info
  -h help: display help
  -t test connection: test if connected to the internet
    Arg1: Interface ('en0')
  -n nuke hardware: disconnect all interfaces
  -d denuke hardware: reconnect all interfaces
  -s open new shell with internet access
  -m monitor traffic
    Arg1: Interface
    Arg2: Bytes In limit, 0 if no limit (Interface will be disabled if limit is reached)
    Arg3: Bytes Out limit, 0 if no limit (Interface will be disabled if limit is reached)
  -c clean output: get clean output from an interface
    Arg1: Interface ('en0')
    Arg2: in or outgoing traffic ('in' 'out')

 EXAMPLES
    monitor interface en0, disable hardware if more than 3 kilobytes is used on either in or out traffic.
    netlock -m en0 3 3
    monitor interface en0, with no limits
    netlock -m en0 0 0

================================================================
- IMPLEMENTATION
-    version         Netlock 0.1.0
-    author          Remco E
-    license         GNU General Public License
================================================================ 
    "
}

USAGE() {
    echo "
================================================================
 Netlock
================================================================
  Usage: 
  -v version: display version info
  -h help: display help
  -t test connection: test if connected to the internet
    Arg1: Interface ('en0')
  -n nuke hardware: disconnect all interfaces
  -d denuke hardware: reconnect all interfaces
  -s open new shell with internet access
  -m monitor traffic
    Arg1: Interface
    Arg2: Bytes Out limit, 0 if no limit (Interface will be disabled if limit is reached)
    Arg3: Bytes In limit, 0 if no limit (Interface will be disabled if limit is reached)
  -c clean output: get clean output from an interface
    Arg1: Interface ('en0')
    Arg2: in or outgoing traffic ('in' 'out')
    "
}

HEADER() {
  echo "
================================================================
 Netlock Monitor. 
 Monitoring interface: $1 $2
================================================================
"
}