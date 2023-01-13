# CadenceSystemVerilogfForUVM1.2.5

Labs completed as part of Cadence's SystemVerilog for UVM 1.2.5.  A simple 4 port switch is used as the subject for developing verification components.
4 Ports:[3:0], data_op[15:0] (out for each port), data_ip[15:0] (in for each port)
2-byte Switch data packet: composed of header (byte 1) and data (byte 2)
Header composed of 4-bit target and 4-bit source.
