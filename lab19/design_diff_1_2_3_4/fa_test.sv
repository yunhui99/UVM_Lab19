class fa_test extends uvm_test;
   `uvm_component_utils(fa_test)

//   bus_sequencer sqr;
//   bus_driver drv;
//   fa_seq seq; //Remove
//   high_prio_seq hseq;  // Lab 7
//   low_prio_seq lseq;   // Lab 7
//   bus_monitor mon;  // Lab 8
   fa_env env;  // Lab 9

   // Lab 11
//   int seq_count = 8, hseq_count = 2, lseq_count = 5; 
//   int seq_count = 10;  //Change the seq_count to from 8 to 10 // Remove

//   int seq_min_delay = 10,  seq_max_delay = 15;
   //Reduce all the delay to 0
//   int seq_min_delay = 0,  seq_max_delay = 0; //Remove

//   int hseq_min_delay = 0, hseq_max_delay = 5;
//   int lseq_min_delay = 5, lseq_max_delay = 10;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
//      sqr = bus_sequencer::type_id::create("sqr", this);
//      hseq = high_prio_seq::type_id::create("hseq");  // Lab 7
//      lseq = low_prio_seq::type_id::create("lseq");   // Lab 7
//      mon = bus_monitor::type_id::create("mon", this);  // Lab 8
      env = fa_env::type_id::create("env", this);  // Lab 9
//      drv = bus_driver::type_id::create("drv", this);
   endfunction

   /*function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      drv.seq_item_port.connect(sqr.seq_item_export);
      drv.drv_ap.connect(mon.mon_ai);  // Lab 8
   endfunction*/

/*   virtual task run_phase(uvm_phase phase);
      seq = fa_seq::type_id::create("seq");

      // Lab 11
        seq.seq_count = this.seq_count;
        seq.min_delay = this.seq_min_delay;
        seq.max_delay = this.seq_max_delay;
//        hseq.seq_count = this.hseq_count;
//        hseq.min_delay = this.hseq_min_delay;
//        hseq.max_delay = this.hseq_max_delay;
//        lseq.seq_count = this.lseq_count;
//        lseq.min_delay = this.lseq_min_delay;
//        lseq.max_delay = this.lseq_max_delay;

        // Lab 11
        `uvm_info("TEST", $sformatf("Starting sequences with config:\n\
                                    Normal: count=%0d, delay=%0d-%0d\n\
                                    High: count=%0d, delay=%0d-%0d\n\
                                    Low: count=%0d, delay=%0d-%0d",
                                  seq.seq_count, seq.min_delay, seq.max_delay,
                                  hseq.seq_count, hseq.min_delay, hseq.max_delay,
                                  lseq.seq_count, lseq.min_delay, lseq.max_delay),
                                  UVM_MEDIUM) 

        `uvm_info("TEST", $sformatf("Starting sequences with config:\n\
                                    Normal: count=%0d, delay=%0d-%0d",
                                  seq.seq_count, seq.min_delay, seq.max_delay),
                                  UVM_MEDIUM)

      //`uvm_info("TEST", "Launching the sequence", UVM_MEDIUM);
      `uvm_info("TEST", "Launching the sequence", UVM_MEDIUM) //Remove the extra ';', `uvm_info("TEST", "Launching the sequence", UVM_MEDIUM);

      phase.raise_objection(this);
//      fork  // Lab 7

//        seq.start(env.sqr); // Lab 9 Launch the sequence
        hseq.start(env.sqr); // Lab 7 Lab 9 Launch the sequence
        lseq.start(env.sqr); // Lab 7 Lab 9 Launch the sequence

	seq.start(env.agt.sqr); // Lab 9 Launch the sequence  // Lab 13
//        hseq.start(env.agent.sqr); // Lab 7 Lab 9 Launch the sequence  // Lab 13
//        lseq.start(env.agent.sqr); // Lab 7 Lab 9 Launch the sequence  // Lab 13

//      join  // Lab 7

//      wait(env.consumer.num_processed + env.consumer.fifo_overflows == env.consumer.num_received);  // Important to avoid simulation ended before processing all the FIFO contents

        // Important to avoid simulation ended before processing all the transactions
//        wait(env.scb.tran_index - 1 == seq.seq_count);

        // Replace the wait with this
	wait(env.scb.tran_index == seq.seq_count);       


      phase.drop_objection(this);
   endtask */ //Remove whole task
endclass
