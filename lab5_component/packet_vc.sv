class packet_vc extends component_base;

agent agn;

function new (string name, component_base parent );
super.new(name, parent);
agn = new("agn", this);
endfunction

task run();
agn.mon.run();
agn.drv.run();
  
endtask
endclass