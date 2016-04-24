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
	 input [7:0] data_in

);


reg [7:0] first_row [255:0];
reg [7:0] cntr;
always @ (posedge clk)
begin
	if(rst | cntr == 255)
		cntr <= 0;
	else 
		cntr <= cntr + 1;
end

reg [7:0] konv_input [2:0][2:0];

always @ (posedge clk)
begin
	
		first_row[cntr] <= data_in;
end



endmodule
