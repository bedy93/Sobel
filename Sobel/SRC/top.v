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
	 output [7:0] out_data

);

img_read img_read_0 (
		.clk(clk), 
		.rst(rst), 
		.p0(p0), 
		.p1(p1), 
		.p2(p2), 
		.p3(p3), 
		.p5(p5), 
		.p6(p6), 
		.p7(p7), 
		.p8(p8), 
		.vsync(vsync),
		.hsync(hsync)
	);

wire [7:0] p0,p1,p2,p3,p5,p6,p7,p8,out_data;

sobel_masking sobel_masking_0(
	.clk(clk),
	.rst(rst),
	.p0(p0), 
	.p1(p1), 
	.p2(p2), 
	.p3(p3), 
	.p5(p5), 
	.p6(p6), 
	.p7(p7), 
	.p8(p8),
	.out_data(out_data)
);
	
	



endmodule



	


