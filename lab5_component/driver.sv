
class driver extends component_base;

// Handle on sequencer class
    sequencer sref;

function new (string name, component_base parent);
    super.new(name, parent);
endfunction

task run();
    $display("Driver @%s", pathname());
    $display("Sequencer @%s", sref.pathname());
    
endtask

endclass