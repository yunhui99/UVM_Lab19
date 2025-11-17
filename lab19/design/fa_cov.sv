//Move the covergroup fa_cg to outside of the class fa_cov
covergroup fa_covergroup with function sample(fa_tran tr); //Rename covergroup fa_cg to covergroup fa_covergroup
	option.per_instance = 1;
	option.comment = "THIS IS MY FA_CG COVERAGE";
       
        a_cp: coverpoint tr.a {
            option.comment = "THIS IS MY FA_CG:A_CP COVERAGE";
        }

        b_cp: coverpoint tr.b {
            option.comment = "THIS IS MY FA_CG:B_CP COVERAGE";
        }

        cin_cp: coverpoint tr.cin {
            option.comment = "THIS IS MY FA_CG:CIN_CP COVERAGE";
        }

        sum_cp: coverpoint tr.sum {
            option.comment = "THIS IS MY FA_CG:SUM_CP COVERAGE";
        }

        cout_cp: coverpoint tr.cout {
            option.comment = "THIS IS MY FA_CG:COUT_CP COVERAGE";
        }

        abcin_cp: cross a_cp, b_cp, cin_cp {
            option.comment = "THIS IS MY FA_CG:ABCIN_CP COVERAGE";
        }

    endgroup

//Add
covergroup fa_tran_covergroup with function sample(fa_tran prev_tr, fa_tran curr_tr);
    // Define the previous state as coverage points
    a_prev: coverpoint prev_tr.a { bins zero = {0}; bins one  = {1}; }
    b_prev: coverpoint prev_tr.b { bins zero = {0}; bins one  = {1}; }
    cin_prev: coverpoint prev_tr.cin { bins zero = {0}; bins one  = {1}; }

    // Define the current state as coverage points
    a_curr: coverpoint curr_tr.a { bins zero = {0}; bins one  = {1}; }
    b_curr: coverpoint curr_tr.b { bins zero = {0}; bins one  = {1}; }
    cin_curr: coverpoint curr_tr.cin { bins zero = {0}; bins one  = {1}; }

    // Cross previous and current states for each signal.
    // This creates bins for transitions like a_prev=0 -> a_curr=1.
    a_trans: cross a_prev, a_curr;
    b_trans: cross b_prev, b_curr;
    cin_trans: cross cin_prev, cin_curr;

    // Optional but powerful: Cross transitions of all three signals.
    // This has 2^3 * 2^3 = 64 bins and is very rigorous.
    all_trans: cross a_prev, b_prev, cin_prev, a_curr, b_curr, cin_curr;
  endgroup

class fa_cov extends uvm_component;
    `uvm_component_utils(fa_cov)
    
    // Use implementation port to receive transactions
    uvm_analysis_imp #(fa_tran, fa_cov) cov_ai;

/*    covergroup fa_cg with function sample(fa_tran tr);
        option.per_instance = 1;
//	option.weight = 2;
	option.comment = "THIS IS MY FA_CG COVERAGE";
        
/*        addr_cp: coverpoint tr.addr {
            option.weight = 2; // Lab13
	    option.comment = "THIS IS MY BUS_CG:ADDR_CP COVERAGE";
            bins low_addr = {[0:127]};
            bins high_addr = {[128:255]};
        }
        
        data_cp: coverpoint tr.data {
	    option.weight = 4; // Lab13
	    option.comment = "THIS IS MY BUS_CG:DATA_CP COVERAGE";
            bins zero_data = {0};
            bins small_data = {[1:1000]};
            bins large_data = {[1001:32'hFFFF_FFFF]};
        }
        
        write_cp: coverpoint tr.write {
	    option.comment = "THIS IS MY BUS_CG:WRITE_CP COVERAGE";
	} 
        
        addr_x_write: cross addr_cp, write_cp {
	    option.weight = 3; // Lab13
	    option.comment = "THIS IS MY BUS_CG:ADDR_X_WRITE_CP COVERAGE";
        }

        a_cp: coverpoint tr.a {
            option.comment = "THIS IS MY FA_CG:A_CP COVERAGE";
        }

        b_cp: coverpoint tr.b {
            option.comment = "THIS IS MY FA_CG:B_CP COVERAGE";
        }

        cin_cp: coverpoint tr.cin {
            option.comment = "THIS IS MY FA_CG:CIN_CP COVERAGE";
        }

        sum_cp: coverpoint tr.sum {
            option.comment = "THIS IS MY FA_CG:SUM_CP COVERAGE";
        }

        cout_cp: coverpoint tr.cout {
            option.comment = "THIS IS MY FA_CG:COUT_CP COVERAGE";
        }

        abcin_cp: cross a_cp, b_cp, cin_cp {
            option.comment = "THIS IS MY FA_CG:ABCIN_CP COVERAGE";
        }

    endgroup */
    
    //Add
    fa_covergroup fa_cg;
    fa_tran_covergroup fa_tran_cg;
    // Variable to store the previous state
    fa_tran prev_tr;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        cov_ai = new("cov_ai", this);
        fa_cg = new();
	fa_cg.set_inst_name($sformatf("%s\ (fa_cg\)", get_full_name()));
        //Add
	fa_tran_cg = new();
        fa_tran_cg.set_inst_name($sformatf("%s\ (fa_tran_cg\)", get_full_name()));
//        `uvm_info("COVERAGE", $sformatf("Instance:%s, Full Instance:%s, Class:%s", get_name(), get_full_name(), get_type_name()), UVM_MEDIUM)
    endfunction
    
    //Add
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      prev_tr = fa_tran::type_id::create("prev_tr");
    endfunction
    
    // This will be called when transactions arrive
    function void write(fa_tran tr);
        fa_cg.sample(tr);
        //Add
	if (prev_tr != null) begin
          fa_tran_cg.sample(prev_tr, tr);

          `uvm_info("COVERAGE", $sformatf("TR a   %0d/%0d: %0b, PREV a   %0d/%0d: %0b", tr.tran_index, tr.tran_count, tr.a, prev_tr.tran_index, prev_tr.tran_count, prev_tr.a), UVM_LOW)
          `uvm_info("COVERAGE", $sformatf("TR b   %0d/%0d: %0b, PREV b   %0d/%0d: %0b", tr.tran_index, tr.tran_count, tr.b, prev_tr.tran_index, prev_tr.tran_count, prev_tr.b), UVM_LOW)
          `uvm_info("COVERAGE", $sformatf("TR cin %0d/%0d: %0b, PREV cin %0d/%0d: %0b", tr.tran_index, tr.tran_count, tr.cin, prev_tr.tran_index, prev_tr.tran_count, prev_tr.cin), UVM_LOW)
        end
    prev_tr.copy(tr);
    endfunction

    function void report_phase(uvm_phase phase);
/*        `uvm_info("COVERAGE", $sformatf("Coverage bus_cg      : %.2f%%", fa_cg.get_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Coverage addr_cp     : %.2f%%", fa_cg.addr_cp.get_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Coverage data_cp     : %.2f%%", fa_cg.data_cp.get_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Coverage write_cp    : %.2f%%", fa_cg.write_cp.get_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Coverage addr_x_write: %.2f%%", fa_cg.addr_x_write.get_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Coverage bus_cg inst      : %.2f%%", fa_cg.get_inst_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Coverage addr_cp inst     : %.2f%%", fa_cg.addr_cp.get_inst_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Coverage data_cp inst     : %.2f%%", fa_cg.data_cp.get_inst_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Coverage write_cp inst    : %.2f%%", fa_cg.write_cp.get_inst_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Coverage addr_x_write inst: %.2f%%", fa_cg.addr_x_write.get_inst_coverage()), UVM_NONE) */

        `uvm_info("COVERAGE", $sformatf("Coverage fa_cg        : %.2f%%", fa_cg.get_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Coverage a_cp         : %.2f%%", fa_cg.a_cp.get_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Coverage b_cp         : %.2f%%", fa_cg.b_cp.get_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Coverage cin_cp       : %.2f%%", fa_cg.cin_cp.get_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Coverage sum_cp       : %.2f%%", fa_cg.sum_cp.get_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Coverage cout_cp      : %.2f%%", fa_cg.cout_cp.get_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Coverage abcin_cp     : %.2f%%", fa_cg.abcin_cp.get_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Coverage fa_cg inst   : %.2f%%", fa_cg.get_inst_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Coverage a_cp inst    : %.2f%%", fa_cg.a_cp.get_inst_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Coverage b_cp inst    : %.2f%%", fa_cg.b_cp.get_inst_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Coverage cin_cp inst  : %.2f%%", fa_cg.cin_cp.get_inst_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Coverage sum_cp inst  : %.2f%%", fa_cg.sum_cp.get_inst_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Coverage cout_cp inst : %.2f%%", fa_cg.cout_cp.get_inst_coverage()), UVM_NONE)
        `uvm_info("COVERAGE", $sformatf("Coverage abcin_cp inst: %.2f%%", fa_cg.abcin_cp.get_inst_coverage()), UVM_NONE)

    endfunction
endclass
