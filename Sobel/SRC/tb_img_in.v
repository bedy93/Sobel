`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:24:28 05/17/2016
// Design Name:   img_in
// Module Name:   G:/OneDrive/Dokumentumok/BME/1.Semester/Logterv/Hazi_1/Sobel/SRC/tb_img_in.v
// Project Name:  Sobel
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: img_in
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_img_in;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [7:0] pix_0;
	wire [7:0] pix_1;
	wire [7:0] pix_2;
	wire [7:0] pix_3;
	wire [7:0] pix_5;
	wire [7:0] pix_6;
	wire [7:0] pix_7;
	wire [7:0] pix_8;

	// Instantiate the Unit Under Test (UUT)
	img_in uut (
		.clk(clk), 
		.rst(rst), 
		.pix_0(pix_0), 
		.pix_1(pix_1), 
		.pix_2(pix_2), 
		.pix_3(pix_3), 
		.pix_5(pix_5), 
		.pix_6(pix_6), 
		.pix_7(pix_7), 
		.pix_8(pix_8)
	);

	initial begin
		clk = 1;
		rst = 1;
		#102 rst = 0;
	end

always #5 clk <= ~clk;
      
endmodule

