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
	
	wire [7:0] pix_0, pix_1, pix_2, pix_3, pix_5, pix_6, pix_7, pix_8;
	
	img_in img_in_0(
			.clk(xclk), 
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
		.clk(xclk),
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
	
	wire [5:0] xrgb1;
	wire hsync1;
	wire vsync1;	
	
	vga vga_0(
		.clk(xclk),
		.rst(~rst),
		.data(out_data),
		.rgb(xrgb1),
		.hsync(xhs1),
		.vsync(xvs1)	
	);
	
	assign xrgb = xrgb1;
	assign xhs = xhs1;
	assign xvs = xvs1;	

endmodule
	


