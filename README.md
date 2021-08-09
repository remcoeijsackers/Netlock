# Netlock
Monitor traffic and disable hardware when a treshhold is reached.

## Options
- -v version: display version info
- -h help: display help
- -t test connection: test if connected to the internet
  - Arg1: Interface ('en0')
- -n nuke hardware: disconnect all interfaces
- -d denuke hardware: reconnect all interfaces
- -m monitor traffic
  - Arg1: Interface
  -  Arg2: Bytes Out limit, 0 if no limit (Interface will be disabled if limit is reached)
  - Arg3: Bytes In limit, 0 if no limit (Interface will be disabled if limit is reached)
- -c clean output: get clean output from an interface
  - Arg1: Interface ('en0')
  - Arg2: in or outgoing traffic ('in' 'out')

---
## Example 

```bash
#Monitor without limits
netlock -m en0 0 0

#Monitor, disable hardware when limit is reached
netlock -m en0 5 5

#Monitor, clean output
netlock -c en0 out
```

---
