
class agent extends component_base;

driver drv;
sequencer seq;
monitor mon;

function new(string name, component_base parent);
super.new(name, parent);
drv = new("drv", this);
seq = new("seq", this);
mon = new("mon", this);
drv.sref = seq;

endfunction

endclass

