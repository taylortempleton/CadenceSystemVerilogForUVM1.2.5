

class monitor extends component_base;

function new (string name, component_base parent);
    super.new(name, parent);
endfunction

task run();
    $display("Monitor @%s", pathname());
endtask

endclass

