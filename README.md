# Netlock
Monitor network traffic and disable hardware when a threshhold in bytes is reached.

## Installation

in the repo root run;
```bash
sudo ./Netlock/setup.sh
```
**Note:** if you experience issues after installation, please restart the shell (or open a new one)

## Usage

### Tests
**Test if interface has a network connection**

*netlock -t interface*
```bash
netlock -t en0
```

### Interface state
**Disable all network interfaces**
```bash
netlock -n
```
**Enable all network interfaces**
```bash
netlock -d
```

### Monitoring
**Monitor without limits**

*netlock -m interface bytes-out bytes-in*
```bash
netlock -m en0
```
**Monitor, disable network hardware when limit is reached**

**Note:** The limit is defined in bytes.

*netlock -m interface bytes-out bytes-in*
```bash
netlock -m en0 5 5
```

**Monitor, disable all network hardware when limit is reached**

**Note:** The limit is defined in bytes.

*netlock -m interface bytes-out bytes-in safe*
```bash
netlock -m en0 5 5 safe
```

**Monitor, clean output**

will return an output of just the bytes, no formatting. 

usefull for piping into other utilities.
```bash
netlock -c en0 out
```
---
## Options
- -v version: display version info
- -h help: display help
- -t test connection: test if connected to the internet
  - Arg1: Network Interface ('en0')
- -n nuke hardware: disconnect all interfaces
- -d denuke hardware: reconnect all interfaces
- -m monitor traffic
  - Arg1: Network Interface
  - Arg2: (optional) Bytes Out limit (Interface will be disabled if limit is reached)
  - Arg3: (optional) Bytes In limit  (Interface will be disabled if limit is reached)
  - Arg4: (optional) 'safe'  turns off all network interfaces if limit is reached.
- -c clean output: get clean output from an interface
  - Arg1: Network Interface ('en0')
  - Arg2: in or outgoing traffic ('in' 'out')

---
