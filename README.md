# Introduction

this process aim to restore my environment starting from a minimal installation of arch linux.

# Consideration on installation

cleaned the framework with 

```bash
sudo dd if=/dev/zero of=/dev/nvme0n1 bs=1M status=progress
```

I have used archinstall, 
- made a partition with ext4
- added linux-firmware as additional package ( as arch wiki for Framwork Pc)
- PipeWire as audio
- Minimal Setup
- Copied connection to iso

# Requirements

You only need git and ansible package to get started.

layout.css.devPixelsPerPx a 1.20 for Firefox


# Bluetooth 

Check the Bluetooth service:

```bash
systemctl status bluetooth
```

If it’s not active/running, enable and start it:
```bash
sudo systemctl enable bluetooth
sudo systemctl start bluetooth
```
## Pair and connect 
```bash 
bluetoothctl
```

enable bluetooth agents 

```bash 
power on
agent on
default-agent
```

start scanning 
```bash
scan on
```

pair 
```bash
pair XX:XX:XX:XX:XX:XX
```

trust and reconnect

```bash
trust XX:XX:XX:XX:XX:XX
connect XX:XX:XX:XX:XX:XX
```

stop scanning 

```bash
scan off
```
## Helpers 
* [Bash Shortcuts](./doc/bash_shortcuts.md)

