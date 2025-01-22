SLMGR.VBS /CPKY
SLMGR.VBS /CKMS
Net stop Sppsvc
CD C:\Windows\System32\SPP\Store\2.0
Ren Tokens.dat Tokens.old
SLMGR.VBS /RILC
changepk.exe /ProductKey VK7JG-NPHTM-C97JM-9MPGT-3V66T