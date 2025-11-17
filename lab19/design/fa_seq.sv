class fa_seq extends uvm_sequence #(fa_tran);
   `uvm_object_utils(fa_seq)

   // Lab 11
   int seq_count;
   int min_delay;
   int max_delay;
   int delay;
//   int sent_count;
   int seq_index;
   string seq_type;

   function new(string name = "fa_seq");
      super.new(name);
//      sent_count = 0;  // Lab 11
        seq_index = 0;
        seq_type = "normal";
   endfunction

   // Lab 11
   function int get_random_delay();
      return $urandom_range(min_delay, max_delay);
   endfunction

   task body();
      fa_tran tr;
      `uvm_info(get_type_name(), "Normal Priority Sequence", UVM_MEDIUM)
      //repeat (7) begin
      repeat (seq_count) begin  // Lab 11
         tr = fa_tran::type_id::create("tr");
         start_item(tr);
//         assert(tr.randomize() with { addr[7:4] == 4'hA; write == 1; }); // Limit to write transactions only and include a extra constraint
         assert(tr.randomize());
         tr.seq_type = "normal";  // Lab 11
         delay = get_random_delay();  // Lab 11
//         sent_count++;  // Lab 11
           seq_index++;
           tr.seq_count = this.seq_count;
           tr.seq_index = this.seq_index;
           tr.seq_type = this.seq_type;
//         `uvm_info(get_type_name(), $sformatf("Sent %0d/%0d %s sequences, next sequence after %0d", sent_count, seq_count, tr.seq_type, delay), UVM_MEDIUM)  // Lab 11
         #delay;  // Lab 11

         finish_item(tr);

         `uvm_info(get_type_name(), $sformatf("Sent %0d/%0d %s sequences: a=%0b, b=%0b, cin=%0b Next sequence after %0d",
                                           seq_index, seq_count, seq_type, tr.a, tr.b, tr.cin, delay),
                                           UVM_MEDIUM)

      end
   endtask
endclass
