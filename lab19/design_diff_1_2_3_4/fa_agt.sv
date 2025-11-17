class fa_agt extends uvm_agent;
   `uvm_component_utils(fa_agt)

   uvm_analysis_export #(fa_tran) agt_ae;

   fa_drv drv;
   fa_mon mon;
   fa_sqr sqr;

   function new(string name, uvm_component parent);
      super.new(name, parent);
      agt_ae = new("agt_ae", this);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      mon = fa_mon::type_id::create("mon", this);
      
      // Only create driver and sequencer if agent is active
      if (get_is_active() == UVM_ACTIVE) begin
         drv = fa_drv::type_id::create("drv", this);
         sqr = fa_sqr::type_id::create("sqr", this);
      end
   endfunction

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);

      // Connect driver to monitor if active
/*      if (get_is_active() == UVM_ACTIVE) begin
         drv.drv_ap.connect(mon.mon_ai);
      end*/
      
/*      // Connect driver to sequencer if active
      if (get_is_active() == UVM_ACTIVE) begin
         drv.seq_item_port.connect(sqr.seq_item_export);
      end */
      
      // Connect monitor to agent
      mon.mon_ap.connect(agt_ae);

      // Connect driver to sequencer if agent active
      if (get_is_active() == UVM_ACTIVE) begin
         drv.seq_item_port.connect(sqr.seq_item_export);
      end

   endfunction
endclass
