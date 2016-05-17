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
	input xclk,
	input rst,	 
	output [5:0] xrgb,
	output  xvs,
	output  xhs
	

);
	wire clk;
	clk_gen clk_gen_0(
			.clk_in(xclk),
			.clk_out(clk) 
		);
	
	img_vga img_vga_0(
		.clk(clk),
		.rst(~rst), 
		.rgb(xrgb),	
		.vsync(xvs),			
		.hsync(xhs)
	);
	
endmodule
	


