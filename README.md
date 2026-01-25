# x10drh-rebar-nvme
ROM image for Supermicro X10DRH-CT/iT that is patched to enable NVMe boot and PCI-e ReBAR.

## Included files:
- X10.ROM - Patched ROM image
- smc-keygen.sh - A shell script that generates the BMC activation key from the BMC MAC address so you can flash from the web UI

## Files used to patch the rom (also included):
- ReBarDxe.ffs - Resizeable BAR DXE Driver from @xCuri0 on GitHub - https://github.com/xCuri0/ReBarUEFI
- NvmExpressDxe_5.ffs - NVMe DXE Driver from Ethanial on WinRaid - https://winraid.level1techs.com/t/small-nvmexpressdxe-driver/32453

## Instructions for use
Simply flash the ROM on to your board and you are good to go. I used the web flasher, but you may need to unlock it with the included keygen first.

## Keygen Usage
Just run ./smc-keygen.sh with the BMC MAC address as the first argument. Both `:` and `-` seperators will work, as will no seperator.

## Notes
- To set the maximum BAR size, use the ReBarState tool from @xCuri0. If you do not do this, ReBar will not work correctly.
- The keygen is very simple, it just takes the BMC MAC address from the board, generates an HMAC using the raw bytes of the MAC address and a secret key extracted from the BMC, truncates it to 24 bytes, then breaks it up into 4 byte groups so you can enter it into the web ui. The algorithm has never changed, so this still works on the latest firmware. It's commented so you can pick it apart if you wish.
