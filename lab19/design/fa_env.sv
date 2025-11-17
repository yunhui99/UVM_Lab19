class fa_env extends uvm_env;
   `uvm_component_utils(fa_env)

   // Analysis export to forward transactions
   uvm_analysis_export #(fa_tran) env_ae;

//   bus_driver drv;
//   bus_monitor mon;
//   bus_sequencer sqr;
//   bus_consumer consumer;  // Lab 10
//   bus_scoreboard scb;  // Lab 12
//   bus_coverage cov;  // Lab 12
//   bus_agent agent;  // Lab 13
     fa_agt agt;
     fa_scb scb;
     fa_cov cov;

   function new(string name, uvm_component parent);
      super.new(name, parent);
      //env_ae = new("env_ae", this);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      //drv = bus_driver::type_id::create("drv", this);
      //mon = bus_monitor::type_id::create("mon", this);
      //sqr = bus_sequencer::type_id::create("sqr", this);
//      consumer = bus_consumer::type_id::create("consumer", this);  // Lab 10
      scb = fa_scb::type_id::create("scb", this); 
      cov = fa_cov::type_id::create("cov", this);  
      agt = fa_agt::type_id::create("agt", this);  
   endfunction

   function void connect_phase(uvm_phase phase);
      /*super.connect_phase(phase);
      // Connect driver to sequencer
      drv.seq_item_port.connect(sqr.seq_item_export);

      // Connect monitor to consumer
      mon.mon_pp.connect(consumer.con_pi);  // Lab 10

      // Connect driver to monitor
      drv.drv_ap.connect(mon.mon_ai);  // Lab 10
      // Connect monitor to scoreboard and coverage
      mon.mon_ap.connect(scb.scb_ai);  // Lab 12
      mon.mon_ap.connect(cov.cov_ai);  // Lab 12

      // Connect driver to environment
      // Connect driver to monitor
      //drv.drv_ap.connect(env_ae);
      //drv.drv_ap.connect(mon.mon_ai);

      // Connect environment to monitor
      //env_ae.connect(mon.mon_ai);*/
     
      // Lab 13 Connect agent to consumer, scoreboard and coverage
//      agt.agt_ae.connect(consumer.con_ai);
      agt.agt_ae.connect(scb.scb_ai);
      agt.agt_ae.connect(cov.cov_ai);
   endfunction
endclass
