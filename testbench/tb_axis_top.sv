`timescale 1ns / 1ps

module tb_axis_top;

    localparam DATA_WIDTH = 32;
    localparam DEPTH      = 8;
    localparam PACKET_LEN = 8;

    logic clk;
    logic reset_n;
    logic start;

    // DUT
    axis_top #(
        .DATA_WIDTH (DATA_WIDTH),
        .DEPTH      (DEPTH),
        .PACKET_LEN (PACKET_LEN)
    ) dut (
        .clk     (clk),
        .reset_n (reset_n),
        .start   (start)
    );

    // Clock: 100 MHz
    initial clk = 0;
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        reset_n = 0;
        start   = 0;

        // Reset
        #20;
        reset_n = 1;

        // Start packet
        #20;
        start = 1;
        #10;
        start = 0;

        // Let simulation run
        #300;

        $display("---- TEST COMPLETED ----");
        $finish;
    end

endmodule
