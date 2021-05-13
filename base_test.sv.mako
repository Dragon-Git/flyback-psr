<%block name="main">
<%
self.modname = datamodel.modname
%>
`ifndef ${self.modname.upper()}_UVM_TEST__SV
`define ${self.modname.upper()}_UVM_TEST__SV

class ${self.modname}_uvm_test extends uvm_test;

   ${self.modname}_env         env;
   ${self.modname}_vsqr        v_sqr;
   ${self.modname}_reg_model      rm;
   ${self.modname}_adapter     reg_sqr_adapter;

   function new(string name = "${self.modname}_uvm_test", uvm_component parent = null);
      super.new(name,parent);
   endfunction
   
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern virtual function void report_phase(uvm_phase phase);
   `uvm_component_utils(${self.modname}_uvm_test)
endclass : ${self.modname}_uvm_test


function void ${self.modname}_uvm_test::build_phase(uvm_phase phase);
   super.build_phase(phase);
   env  =  ${self.modname}_env::type_id::create("env", this); 
   v_sqr =  ${self.modname}_vsqr::type_id::create("v_sqr", this);
   rm = reg_model::type_id::create("rm", this);
   rm.configure(null, "");
   rm.build();
   rm.lock_model();
   rm.reset();
   reg_sqr_adapter = new("reg_sqr_adapter");
   env.p_rm = this.rm;
endfunction

function void ${self.modname}_uvm_test::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   v_sqr.p_my_sqr = env.i_agt.sqr;
   v_sqr.p_bus_sqr = env.bus_agt.sqr;
   v_sqr.p_rm = this.rm;
   rm.default_map.set_sequencer(env.bus_agt.sqr, reg_sqr_adapter);
   rm.default_map.set_auto_predict(1);
endfunction

function void ${self.modname}_uvm_test::report_phase(uvm_phase phase);
   uvm_report_server server;
   int err_num;
   super.report_phase(phase);

   server = get_report_server();
   err_num = server.get_severity_count(UVM_ERROR);

   if (err_num != 0) begin
      $$display("TEST CASE FAILED");
   end
   else begin
      $$display("TEST CASE PASSED");
   end
endfunction

`endif
</%block>
