# x10drh-rebar-nvme
ROM image for Supermicro X10DRH-CT/iT that is patched to enable NVMe boot and PCI-e ReBAR.

Included files:
- X10.ROM - Patched ROM image

Files used to patch the rom (also included):
- ReBarDxe.ffs - Resizeable BAR DXE Driver from @xCuri0 on GitHub - https://github.com/xCuri0/ReBarUEFI
- NvmExpressDxe_5.ffs - NVMe DXE Driver from Ethanial on WinRaid - https://winraid.level1techs.com/t/small-nvmexpressdxe-driver/32453

Instructions for use:
Simply flash the ROM on to your board and you are good to go. To set the maximum BAR size, use the ReBarState tool from @xCuri0. If you do not do this, ReBar will not work correctly.
