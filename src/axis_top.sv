`timescale 1ns / 1ps

module axis_top #(
    parameter DATA_WIDTH = 32,
    parameter DEPTH      = 8,
    parameter PACKET_LEN = 8
)(
    input  logic clk,
    input  logic reset_n,
    input  logic start
);

    // AXI-Stream wires
    logic [DATA_WIDTH-1:0] tdata_gen;
    logic                  tvalid_gen;
    logic                  tready_fifo;
    logic                  tlast_gen;

    logic [DATA_WIDTH-1:0] tdata_fifo;
    logic                  tvalid_fifo;
    logic                  tready_sink;
    logic                  tlast_fifo;

    // Packet Generator (AXIS Master)
    axis_packet_generator #(
        .DATA_WIDTH (DATA_WIDTH),
        .PACKET_LEN (PACKET_LEN)
    ) u_gen (
        .clk     (clk),
        .reset_n (reset_n),
        .start   (start),
        .TDATA   (tdata_gen),
        .TVALID  (tvalid_gen),
        .TREADY  (tready_fifo),
        .TLAST   (tlast_gen)
    );

    // AXI-Stream FIFO
    axis_fifo #(
        .DATA_WIDTH (DATA_WIDTH),
        .DEPTH      (DEPTH)
    ) u_fifo (
        .clk       (clk),
        .reset_n   (reset_n),
        .S_TDATA   (tdata_gen),
        .S_TVALID  (tvalid_gen),
        .S_TLAST   (tlast_gen),
        .S_TREADY  (tready_fifo),
        .M_TDATA   (tdata_fifo),
        .M_TVALID  (tvalid_fifo),
        .M_TLAST   (tlast_fifo),
        .M_TREADY  (tready_sink)
    );

    // AXI-Stream Sink (AXIS Slave)
    axis_sink #(
        .DATA_WIDTH (DATA_WIDTH)
    ) u_sink (
        .clk     (clk),
        .reset_n (reset_n),
        .TDATA   (tdata_fifo),
        .TVALID  (tvalid_fifo),
        .TREADY  (tready_sink),
        .TLAST   (tlast_fifo)
    );

endmodule
