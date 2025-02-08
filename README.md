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

## Helpers 
* [Bash Shortcuts](./doc/bash_shortcuts.md)
* [Vim Cheatsheet](./doc/vim_cht.md)

