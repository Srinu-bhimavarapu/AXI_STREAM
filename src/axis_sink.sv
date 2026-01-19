`timescale 1ns / 1ps
module axis_sink #(
parameter DATA_WIDTH=32
)
(
input logic clk,
input logic reset_n,
// axi stream slave interface
input logic[DATA_WIDTH-1:0] TDATA,
input logic TVALID,
output logic TREADY,
input logic TLAST
);
logic[7:0] recv_count;
always_ff@(posedge clk or negedge reset_n)
begin
if(!reset_n)
begin
TREADY<=1'b0;
recv_count<=0;
end
else 
begin
TREADY <=1'b1;
if(TVALID && TREADY)
begin
recv_count<=recv_count + 1'b1;
if(TLAST)
begin
$display("[%0t] AXIS SINK : packet received, beats=%0d",$time , recv_count+1);
recv_count<=0;
end
end
end
end
endmodule