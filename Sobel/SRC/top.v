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
	output  xhs,
	output  xvs

);
	wire clk;
	clk_gen clk_gen_0(
			.clk_in(xclk),
			.clk_out(clk)
		);
	
	wire [7:0] pix_0, pix_1, pix_2, pix_3, pix_5, pix_6, pix_7, pix_8;
	
	img_in img_in_0(
			.clk(clk), 
			.rst(~rst), 
			.pix_0(pix_0), 
			.pix_1(pix_1), 
			.pix_2(pix_2), 
			.pix_3(pix_3), 
			.pix_5(pix_5), 
			.pix_6(pix_6), 
			.pix_7(pix_7), 
			.pix_8(pix_8)
		);


	wire out_data;
	
	sobel sobel_0(
		.clk(clk),
		.rst(~rst),
		.pix_0(pix_0), 
		.pix_1(pix_1), 
		.pix_2(pix_2), 
		.pix_3(pix_3), 
		.pix_5(pix_5), 
		.pix_6(pix_6), 
		.pix_7(pix_7), 
		.pix_8(pix_8),
		.out_data(out_data)
	);
	

	vga vga_0(
		.clk(clk),
		.rst(~rst), 
		.data(out_data),
		.rgb(xrgb),				
		.hsync(xhs),
		.vsync(xvs)	
	);
	
endmodule
	


