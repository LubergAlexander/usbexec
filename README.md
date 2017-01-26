## Description

This was my 1st attempt to lock my mac when the YubiKey was removed. 

Since LaunchEvents don't have the detach event, i converted this SW to a more generic util.

It executes any command after a vendor and product USB IDs is connected.
 
As a base example, it listens for a YubiKey 1st gen to be connected.

## Install

#### Connect the target device and run this command:
```bash
$ system_profiler SPUSBDataType
```

look for "Product ID" and "Vendor ID",
edit org.profundos.usbexec.plist and update those values (idProduct and idVendor)

#### Install everything in you mac. Run this:
```bash
$ ./install
```

#### Check if everything is OK. Run:
```bash
$ tail -F $HOME/.usbexec/usbexec.log
```

Connect and disconnect your USB Device.
Look for:
```bash
Received event: com.apple.device-attach: 4294987900
Events Purger called!
Executing commands... -from_daemon
```


#### Add your commands here:
```bash
$ vi $HOME/.usbexec/commands
```

## How it works

The main plist file will launch the utility 'usbexec' which consumes the USB attach event (necessary,
otherwise launchd will re-launch usbexec every 10 seconds), and then calls your commands.

## Notes

The detach event is not reliable, see [yklock](https://github.com/dbcm/yklock)

## DEBUG
```
$ ./tmux
```
