/*-----------------------------------------------------------------
From the Cadence "Essential SystemVerilog for UVM" training course
Copyright Cadence Design Systems (c)2019

2022 Jan 18
taylor.templeton@gmail.com
Solution to lab05
-----------------------------------------------------------------*/
// packet class declaration

// enum to toggle print format for debug
typedef enum {HEX,BIN,DEC} pp_t;

// enum for characterizing packet type
typedef enum {ANY, SINGLE, MULTICAST, BROADCAST} ptype_t; 

class packet;
  
  local string name; // create name unique to instances
  rand bit [3:0] target; // 4-bit target variable
  bit [3:0] source; // 4-bit source variable
  rand bit [7:0] data; // 8-bit data variable
  ptype_t ptype; // create property for packet type

  constraint t_not0 {target != 0;} // Target cant be 0; must send packet somewhere
 // constraint targetSourceNotSame {(target & source) == 4'b0;} //target cannot be same as source, else would be sending packet to where it was sent from
  
  constraint ts_bits {|(target & source) != 1'b1;}
  
  // modify constructor to include instance name and source of packet
  function new (string name, int idt);
    this.name = name; // instance handle name
    source = 1 << idt; // convert source to bit format
    ptype = ANY; // establish arbitrary default value
  endfunction
  
  // Method to return instance name
  function string getname();
    return name;
  endfunction

  // Method to return packet type
  function string gettype();
    return ptype.name();
  endfunction

  // print policy to specify print format based on enum
  function void print(input pp_t pp = BIN);
    $display("\n------------------------------");
    $display("name: %s, type: %s", getname(), gettype());
    case (pp)
      HEX: $display("from source %h, to target %h, data %h", source, target, data);
      DEC: $display("from source %0d, to target %0d, data %0d", source, target, data);
      BIN: $display("from source %b, to target %b, data %b", source, target, data);
    endcase
  endfunction
endclass

class psingle extends packet;
constraint csingle{target inside {1,2,4,8};}

function new(string name, int idt);
    super.new(name,idt);
    ptype = SINGLE;
endfunction
endclass

class pmulticast extends packet;
constraint csingle{target inside {3, [5:7], [9:14]};}

function new(string name, int idt);
    super.new(name,idt);
    ptype = MULTICAST;
endfunction
endclass

class pbroadcast extends packet;

constraint ts_bits {}
constraint cbroadcast {target == 15;}

function new(string name, int idt);
    super.new(name,idt);
    ptype = BROADCAST;
endfunction

endclass


