class fa_drv extends uvm_driver #(fa_tran);
  `uvm_component_utils(fa_drv)

  virtual fadder_if vif;
  uvm_analysis_port #(fa_tran) drv_ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    drv_ap = new("drv_ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fadder_if)::get(this, "", "vif", vif)) begin
      `uvm_error("DRIVER", "Virtual interface not found in config db")
    end
  endfunction

  task run_phase(uvm_phase phase);
    fa_tran tr;
    forever begin
      seq_item_port.get_next_item(tr);

      @(vif.drv_cb);                // Wait for the posedge clock
//      @(posedge vif.drv_mp.clk_tb);  // Wait for the posedge clock

      `uvm_info("DRIVER", $sformatf("Drive %0d/%0d %s tran to DUT: a=%0b, b=%0b, cin=%0b",
                                    tr.seq_index, tr.seq_count, tr.seq_type, tr.a, tr.b, tr.cin),
                                    UVM_MEDIUM)

	uvm_config_db#(fa_tran)::set(null, "*", "tr_drv", tr);
      
      // Use clocking block instead of modports so that the clock skew can be tuned
      vif.drv_cb.a_tb <= tr.a;      // Drive 'a' from transaction (tr) to DUT
      vif.drv_cb.b_tb <= tr.b;      // Drive 'b' from transaction (tr) to DUT
      vif.drv_cb.cin_tb <= tr.cin;  // Drive 'cin' from transaction (tr) to DUT

//        vif.drv_mp.a_tb <= tr.a;      // Drive 'a' from transaction (tr) to DUT
//        vif.drv_mp.b_tb <= tr.b;      // Drive 'b' from transaction (tr) to DUT
//        vif.drv_mp.cin_tb <= tr.cin;  // Drive 'cin' from transaction (tr) to DUT

//      vif.sum <= 1'b1; 
//      vif.drv_mp.sum <= 1'b1; //Indirect access to sum signal by going thru modport
//      vif.drv_cb.sum <= 1'b1; //Indirect access to sum signal by going thru clocking block

      seq_item_port.item_done();
    end
  endtask
endclass
