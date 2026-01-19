`timescale 1ns / 1ps

module axis_packet_generator #(
parameter DATA_WIDTH =32,
parameter PACKET_LEN=8  // no.of beat per packet
)
(
input logic clk,
input logic reset_n,
input logic start ,
output logic[DATA_WIDTH-1:0] TDATA,
output logic TVALID,
input logic TREADY,
output logic TLAST
);
//FSM
typedef enum logic [1:0] {
IDLE,
SEND,
DONE
}state_t;
state_t state, next_state;

logic [$clog2(PACKET_LEN)-1:0] beat_cnt;
logic [DATA_WIDTH-1:0] data_reg;

//fsm state logic 
always_ff@(posedge clk or negedge reset_n)
begin
if(!reset_n)
state<=IDLE;
else 
state<=next_state;
end

//fsm next state
always_comb 
begin
next_state=state;
case(state)
IDLE: begin
if(start)
next_state=SEND;
end
SEND:
begin
if(TVALID && TREADY && TLAST)
next_state=DONE;
end 
DONE:
begin
next_state=IDLE;
end 
endcase
end

always_ff@(posedge clk or negedge reset_n)
begin
if(!reset_n)
begin
TVALID<=1'b0;
TLAST<=1'b0;
TDATA<='0;
beat_cnt<='0;
data_reg<='0;
end
else 
begin
case(state)

IDLE:
begin
TVALID<=1'b0;
TLAST<=1'b0;
beat_cnt<=0;
data_reg<=32'h0000_0001;
end

SEND:
begin
TVALID<=1'b1;
if(TVALID && TREADY)
begin
TDATA<=data_reg;
data_reg<= data_reg + 1'b1;
beat_cnt<=beat_cnt +1'b1;

if(beat_cnt==PACKET_LEN-1)
TLAST<=1'b1;
else 
TLAST<=1'b0;
end
end
DONE:
begin
TVALID<=1'b0;
TLAST<=1'b0;
end
endcase
end
end
endmodule























