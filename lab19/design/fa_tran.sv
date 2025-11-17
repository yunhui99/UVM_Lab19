`include "uvm_macros.svh"

import uvm_pkg::*;

class fa_tran extends uvm_sequence_item;
/*   rand bit [7:0] addr;
   rand bit [31:0] data;
   rand bit write;
   string seq_type;  // Lab 11*/

   rand bit a;
   rand bit b;
   rand bit cin;
   bit sum;
   bit cout;
   int seq_count;
   int seq_index;
   int tran_count;
   int tran_index;
   string seq_type;
   string tran_type;

//   `uvm_object_utils(fa_tran) Remove

   // Add
   `uvm_object_utils_begin(fa_tran)
    `uvm_field_int(a, UVM_ALL_ON)
    `uvm_field_int(b, UVM_ALL_ON)
    `uvm_field_int(cin, UVM_ALL_ON)
    `uvm_field_int(sum, UVM_ALL_ON)
    `uvm_field_int(cout, UVM_ALL_ON)
    `uvm_field_int(seq_index, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(seq_count, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(tran_index, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(tran_count, UVM_ALL_ON | UVM_DEC)
    `uvm_field_string(seq_type, UVM_ALL_ON)
    `uvm_field_string(tran_type, UVM_ALL_ON)
  `uvm_object_utils_end

   function new(string name = "fa_tran");
      super.new(name);
   endfunction
endclass
