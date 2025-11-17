class fa_cov extends uvm_component;
    `uvm_component_utils(fa_cov)
    
    // Use implementation port to receive transactions
    uvm_analysis_imp #(fa_tran, fa_cov) cov_ai;

    covergroup fa_cg with function sample(fa_tran tr);
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
        } */

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

    function new(string name, uvm_component parent);
        super.new(name, parent);
        cov_ai = new("cov_ai", this);
        fa_cg = new();
	fa_cg.set_inst_name($sformatf("%s\ (fa_cg\)", get_full_name()));
//        `uvm_info("COVERAGE", $sformatf("Instance:%s, Full Instance:%s, Class:%s", get_name(), get_full_name(), get_type_name()), UVM_MEDIUM)
    endfunction
    
    // This will be called when transactions arrive
    function void write(fa_tran tr);
        fa_cg.sample(tr);
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
