set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ManualClock_IBUF]

set_property PACKAGE_PIN V17 [get_ports {D[0]}]
set_property PACKAGE_PIN V16 [get_ports {D[1]}]
set_property PACKAGE_PIN W16 [get_ports {D[2]}]
set_property PACKAGE_PIN W17 [get_ports {D[3]}]
set_property PACKAGE_PIN W15 [get_ports {D[4]}]
set_property PACKAGE_PIN V15 [get_ports {D[5]}]
set_property PACKAGE_PIN W14 [get_ports {D[6]}]
set_property PACKAGE_PIN W13 [get_ports {D[7]}]
set_property PACKAGE_PIN U1  [get_ports {CountEnable}]
set_property PACKAGE_PIN T1  [get_ports {CounterInputEnable}]
set_property PACKAGE_PIN R2  [get_ports {ClockSelect}]

set_property PACKAGE_PIN U16 [get_ports {Q[0]}]
set_property PACKAGE_PIN E19 [get_ports {Q[1]}]
set_property PACKAGE_PIN U19 [get_ports {Q[2]}]
set_property PACKAGE_PIN V19 [get_ports {Q[3]}]
set_property PACKAGE_PIN W18 [get_ports {Q[4]}]
set_property PACKAGE_PIN U15 [get_ports {Q[5]}]
set_property PACKAGE_PIN U14 [get_ports {Q[6]}]
set_property PACKAGE_PIN V14 [get_ports {Q[7]}]

set_property PACKAGE_PIN W5  [get_ports {Clock100MHz}]

set_property PACKAGE_PIN W19 [get_ports {ManualClock}]
set_property PACKAGE_PIN T17 [get_ports {Reset}]


set_property IOSTANDARD LVCMOS33 [get_ports {D CountEnable CounterInputEnable ClockSelect Q Clock100MHz ManualClock Reset}]
