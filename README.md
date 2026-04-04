# DebianWSL
Forked from [yuk7/AlpineWSL](https://github.com/yuk7/AlpineWSL)

Debian GNU/Linux on WSL (Windows 10 1803 or later)
based on [wsldl](https://github.com/yuk7/wsldl)

![screenshot](https://github.com/arfshl/debianWSL/raw/main/screenshot.png)

[![Build amd64](https://github.com/arfshl/DebianWSL/actions/workflows/build-amd64.yml/badge.svg)](https://github.com/arfshl/DebianWSL/actions/workflows/build-amd64.yml)
[![Build arm64](https://github.com/arfshl/DebianWSL/actions/workflows/build-arm64.yml/badge.svg)](https://github.com/arfshl/DebianWSL/actions/workflows/build-arm64.yml)
[![Build sid amd64](https://github.com/arfshl/DebianWSL/actions/workflows/build-sid-amd64.yml/badge.svg)](https://github.com/arfshl/DebianWSL/actions/workflows/build-sid-amd64.yml)
[![Build sid arm64](https://github.com/arfshl/DebianWSL/actions/workflows/build-sid-arm64.yml/badge.svg)](https://github.com/arfshl/DebianWSL/actions/workflows/build-sid-arm64.yml)
[![Build testing amd64](https://github.com/arfshl/DebianWSL/actions/workflows/build-testing-amd64.yml/badge.svg)](https://github.com/arfshl/DebianWSL/actions/workflows/build-testing-amd64.yml)
[![Build testing arm64](https://github.com/arfshl/DebianWSL/actions/workflows/build-testing-arm64.yml/badge.svg)](https://github.com/arfshl/DebianWSL/actions/workflows/build-testing-arm64.yml)
[![Github All Releases](https://img.shields.io/github/downloads/arfshl/debianWSL/total.svg?style=flat-square)](https://github.com/arfshl/debianWSL/releases/latest)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
![License](https://img.shields.io/github/license/arfshl/debianWSL.svg?style=flat-square)

### [Download](https://github.com/arfshl/debianWSL/releases/latest)


## Requirements
* Windows 10 1803 April 2018 Update x64/arm64 or later.
* Windows Subsystem for Linux feature is enabled.

## Install
#### 1. [Download](https://github.com/arfshl/debianWSL/releases/latest) installer zip that matches your arch (amd64 and arm64)

#### 2. Extract all files in zip file to same directory

#### 3.Run debian.exe to Extract rootfs and Register to WSL
Exe filename is using to the instance name to register.
If you rename it, you can register with a different name and have multiple installs.


## How-to-Use(for Installed Instance)
#### exe Usage
```dos
Usage :
    <no args>
      - Open a new shell with your default settings.

    run <command line>
      - Run the given command line in that instance. Inherit current directory.

    runp <command line (includes windows path)>
      - Run the given command line in that instance after converting its path.

    config [setting [value]]
      - `--default-user <user>`: Set the default user of this instance to <user>.
      - `--default-uid <uid>`: Set the default user uid of this instance to <uid>.
      - `--append-path <true|false>`: Switch of Append Windows PATH to $PATH
      - `--mount-drive <true|false>`: Switch of Mount drives
      - `--default-term <default|wt|flute>`: Set default type of terminal window.

    get [setting]
      - `--default-uid`: Get the default user uid in this instance.
      - `--append-path`: Get true/false status of Append Windows PATH to $PATH.
      - `--mount-drive`: Get true/false status of Mount drives.
      - `--wsl-version`: Get the version os the WSL (1/2) of this instance.
      - `--default-term`: Get Default Terminal type of this instance launcher.
      - `--lxguid`: Get WSL GUID key for this instance.

    backup [contents]
      - `--tar`: Output backup.tar to the current directory.
      - `--reg`: Output settings registry file to the current directory.

    clean
      - Uninstall that instance.

    help
      - Print this usage message.
```


#### How to uninstall instance
```dos
>debian.exe clean

```

### Other WSL distributions

![AlpineWSL-Edge](https://github-readme-stats-fast.vercel.app/api/pin/?username=arfshl&repo=alpinewsl-edge&theme=transparent)
![VoidWSL](https://github-readme-stats-fast.vercel.app/api/pin/?username=arfshl&repo=voidwsl&theme=transparent)
![ubuntu-latest-WSL](https://github-readme-stats-fast.vercel.app/api/pin/?username=arfshl&repo=ubuntu-latest-wsl&theme=transparent)
![devuanwsl](https://github-readme-stats-fast.vercel.app/api/pin/?username=arfshl&repo=devuanwsl&theme=transparent)
![trisquelwsl](https://github-readme-stats-fast.vercel.app/api/pin/?username=arfshl&repo=trisquelwsl&theme=transparent)