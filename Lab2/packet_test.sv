/*-----------------------------------------------------------------
From the Cadence "Essential SystemVerilog for UVM" training course
Copyright Cadence Design Systems (c)2019

2022 Jan 14
taylor.templeton@gmail.com
Solution to lab02

-----------------------------------------------------------------*/

module packet_test;
import packet_pkg::*;

packet p;
  bit ok;

initial begin
  p = new("p", 0); // construct instance of packet, passing in a name string and source int
  repeat (10) begin
    ok = p.randomize() with {ptype != ANY;};
    p.print();
  end
end





//--------------------validate functions for verification ----
//--------------------Do not edit below this line          -----

function int countones (input logic[3:0] vec);
  countones = 0;
  foreach (vec [i])
    if (vec[i]) countones++;
endfunction

function void validate (input packet ap);
  int sco, tco;
  sco = countones(ap.source);
  tco = countones(ap.target);
  if (sco != 1) 
     $display("ERROR in source %h - no. bits set = %0d", ap.source, sco);
  if (ap.ptype == "broadcast") begin
    if  (ap.target != 4'hf) 
       $display("ERROR: broadcast packet target is %h not 4'hf", ap.target);
  end
  else 
  begin
    if ( |(ap.source & ap.target) == 1'b1)   
      $display("ERROR: non-broadcast packet %s has same source %h and target %h bit set", ap.getname(), ap.source, ap.target);
    if ((ap.ptype == "single") & (tco != 1)) 
      $display("ERROR: single packet %s does not have only one bit set in target %h", ap.getname(), ap.target);
    if ((ap.ptype == "multicast") & (tco < 2)) 
      $display("ERROR: multicast packet %s does not have more than one bit set in target %h", ap.getname(), ap.target);
  end
endfunction
    
endmodule
   

