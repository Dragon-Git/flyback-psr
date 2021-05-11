
`ifndef TOP__SV
`define TOP__SV
module top();

    logic clk;
    logic rst_n;
    reg[7:0] rxd;
    reg rx_dv;
    wire[7:0] txd;
    wire tx_en;

    my_if input_if(clk, rst_n);
    my_if output_if(clk, rst_n);

    bus_if b_if(clk, rst_n);

    // ToDo: Include Dut instance here
    dut my_dut(.clk          (clk               ),
           .rst_n        (rst_n             ),
           .bus_cmd_valid(b_if.bus_cmd_valid), 
           .bus_op       (b_if.bus_op       ), 
           .bus_addr     (b_if.bus_addr     ), 
           .bus_wr_data  (b_if.bus_wr_data  ), 
           .bus_rd_data  (b_if.bus_rd_data  ), 
           .rxd          (input_if.data     ),
           .rx_dv        (input_if.valid    ),
           .txd          (output_if.data    ),
           .tx_en        (output_if.valid   ));

    // Clock Generation
    parameter sim_cycle = 10;

    // Reset Delay Parameter
    parameter rst_delay = 50;

    initial begin
        clk = 0;
        forever begin
            clk = #(sim_cycle/2) ~clk;
        end
    end

    initial begin
       rst_n = 1'b0;
       #1000;
       rst_n = 1'b1;
    end

    program_block test();

    initial begin
        $dumpfile("top.vcd");
        $dumpvars(0, top);
    end

endmodule : top
`endif // TOP__SV
