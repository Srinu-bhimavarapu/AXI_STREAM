`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.01.2026 23:33:36
// Design Name: 
// Module Name: axis_fifo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module axis_fifo#(
parameter DATA_WIDTH = 32,
parameter DEPTH=8
)
(
input logic clk,
input logic reset_n,

input logic[DATA_WIDTH-1:0] S_TDATA,
input logic S_TVALID,
input logic S_TLAST, 
output logic S_TREADY,

output logic[DATA_WIDTH-1:0] M_TDATA,
output logic M_TVALID,
output logic M_TLAST,
input  logic M_TREADY
);

logic [DATA_WIDTH-1:0] fifo_data [0:DEPTH-1];
logic                  fifo_last [0:DEPTH-1];
localparam ADDR_W = $clog2(DEPTH);

logic[ADDR_W-1:0] wr_ptr,rd_ptr,count;

assign S_TREADY = (count<DEPTH);
assign M_TVALID = (count >0);
 
assign M_TDATA = fifo_data[rd_ptr];
assign M_TLAST= fifo_last[rd_ptr];
 
 always_ff@(posedge clk or negedge  reset_n)
 begin
 if(!reset_n)
 begin
 wr_ptr<=0;
 rd_ptr<=0;
 count<=0;
 end
 else begin
 if(S_TVALID && S_TREADY)begin
 fifo_data[wr_ptr]<=S_TDATA;
 fifo_last[wr_ptr]<=S_TLAST;
 wr_ptr<=wr_ptr + 1'b1;   
 count<=count +1'b1;
 end
 //read
 if(M_TVALID && M_TREADY)
 begin
 rd_ptr<= rd_ptr + 1'b1;
 end
 count<= count-1'b1;
 end
 end
 endmodule
 
 
 
 
 
 
 
 
 
 
 
 
 
 









    