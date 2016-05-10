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
	//output [7:0] out_data,
	 
	output [5:0] xrgb,
	output       xhs,
	output       xvs

);

reg clk;
always @(posedge xclk)
if(~rst)
	clk <= 0;
else
	clk <= ~clk;
	
wire [7:0] pix_0, pix_1, pix_2, pix_3, pix_5, pix_6, pix_7, pix_8;

img_read img_read_0 (
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
		.vsync(xvs),
		.hsync(xhs)
	);



//wire [5:0] xrgb;
//wire xvs,xhs;


wire [7:0] out_data;
sobel_masking sobel_masking_0(
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
	assign xrgb = { out_data[7:6], out_data[7:6], out_data[7:6]};
	



endmodule



	


