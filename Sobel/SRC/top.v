`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:04:26 09/23/2013 
// Design Name: 
// Module Name:    top_level 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top_level(
    input clk,
    input rst,
	 input [7:0] data_in,
	 input h_sync,
	 input v_sync

);


reg [7:0] first_row [32:0];
reg [7:0] second_row [32:0];
reg [7:0] third_row [32:0];

reg [5:0] cntr;
always @ (posedge clk)
begin
	if(rst)
		cntr <= 0;
	else 
		cntr <= cntr + 1;
end

reg [2:0] row_cntr;
always @ (posedge clk)
begin
	if(rst | row_cntr == 3)
		row_cntr <=0;
	else if(h_sync)
		row_cntr <= row_cntr + 1;
end		
	

always @ (posedge clk)
begin		
	case(row_cntr)
		2'b00:	first_row[cntr] <= data_in;
		2'b01:	second_row[cntr] <= data_in;
		2'b10:	third_row[cntr] <= data_in;
	endcase
end



endmodule
