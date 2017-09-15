connect -url tcp:127.0.0.1:3121
source /home/johannes/median.demonstrator/FSBL/ZynqberryMinimalDesign_wrapper/ps7_init.tcl
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "JTAG-ONB4 251633002518A"} -index 0
loadhw -hw /home/johannes/median.demonstrator/FSBL/ZynqberryMinimalDesign_wrapper/system.hdf -mem-ranges [list {0x40000000 0xbfffffff}]
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "JTAG-ONB4 251633002518A"} -index 0
stop
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "JTAG-ONB4 251633002518A"} -index 0
rst -processor
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "JTAG-ONB4 251633002518A"} -index 0
dow /home/johannes/median.demonstrator/FSBL/FSBL/Debug/FSBL.elf
configparams force-mem-access 0
bpadd -addr &main
