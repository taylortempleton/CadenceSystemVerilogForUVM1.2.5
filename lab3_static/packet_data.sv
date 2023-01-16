/*-----------------------------------------------------------------
From the Cadence "Essential SystemVerilog for UVM" training course
Copyright Cadence Design Systems (c)2019

2022 Jan 14
taylor.templeton@gmail.com
Solution to lab03
-----------------------------------------------------------------*/
// packet class declaration

// enum to toggle print format for debug
typedef enum {HEX,BIN,DEC} pp_t;
typedef enum {ANY, SINGLE, MULTICAST, BROADCAST} ptype_t; 
typedef enum {UNIDED, IDED} tag_t;

class packet;

  local string name;
  
  rand bit [3:0] target; // 4-bit target variable
  bit [3:0] source; // 4-bit source variable
  rand bit [7:0] data; // 8-bit data variable
  ptype_t ptype; // create property for packet type

  tag_t tagmode;
  int tag;
  static int pktcount;

  // modify constructor to include instance name and source of packet
  function new (string name, int idt);
    this.name = name; // instance handle name
    source = 1 << idt; // convert source to bit format
    ptype = ANY; // establish arbitrary default value
    pktcount++;
    tag = pktcount;
  endfunction

static function int getcount();
  return(pktcount);
endfunction

function void post_randomize();
if (tagmode == IDED) data = tag;
endfunction

  constraint targetNotZero {target != 0;} // Target cant be 0; must send packet somewhere
 // constraint targetSourceNotSame {(target & source) == 4'b0;} //target cannot be same as source, else would be sending packet to where it was sent from
  constraint ptypetargetConstr {ptype == SINGLE -> {target inside {1, 2, 4, 8}; (target & source) == 4'b0;}
                                ptype == MULTICAST -> {target inside {3, [5:7], [9:14]}; (target & source) == 4'b0;}
                                ptype == BROADCAST -> target == 15;}
  
  
  
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
    $display("\n------------------------------\n");
    $display("name: %s, type: %s, tag: %0d, pktcount %0d, tagmode %s", getname(), gettype(), tag, pktcount, tagmode.name());
    case (pp)
      HEX: $display("from source %h, to target %h, data %h", source, target, data);
      DEC: $display("from source %0d, to target %0d, data %0d", source, target, data);
      BIN: $display("from source %b, to target %b, data %b", source, target, data);
    endcase
    $display("------------------------------\n");
  endfunction
 
endclass

