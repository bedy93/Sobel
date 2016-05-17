`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:16:03 05/17/2016
// Design Name:   top_level
// Module Name:   G:/OneDrive/Dokumentumok/BME/1.Semester/Logterv/Hazi_1/Sobel/SRC/tb_top.v
// Project Name:  Sobel
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top_level
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_top;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [5:0] xrgb;
	wire xhs;
	wire xvs;

	// Instantiate the Unit Under Test (UUT)
	top_level uut (
		.xclk(clk), 
		.rst(rst), 
		.xrgb(xrgb), 
		.xhs(xhs), 
		.xvs(xvs)
	);

		initial begin
		clk = 1;
		rst = 0;
		#1002 rst = 1;
	end

always #5 clk <= ~clk;
      
endmodule

