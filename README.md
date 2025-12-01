### About:

This repo contains complete environment for building, testing and developing official Linux Kernel code.

### Usage:

Run scripts from 'scripts' directory without parameters to check for available options.

### Todo:

- Put vars like LINUX_STABLE and LINUX_MAINLINE i separate script which will be sourced by all others
- When exiting from make_linux always check ret val and always exit with retval

- test_rc.sh just one parameter
- integrate repo tool, to clone this repo and then to clone driver projects into drver_projects directory

- finish test_rc to work and to contain some real-world test scenario

- add config and qemu for arch64
