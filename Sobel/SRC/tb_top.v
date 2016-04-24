`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:09:58 04/20/2016
// Design Name:   top_level
// Module Name:   G:/OneDrive/Dokumentumok/BME/1.Semester/Logterv/Hazi/Project/sobel/tb_top.v
// Project Name:  sobel
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
	wire [7:0] data_in ;

	// Instantiate the Unit Under Test (UUT)
	top_level uut (
		.clk(clk), 
		.rst(rst), 
		.data_in(data_in)
	);

initial begin
		clk = 1;
		rst = 1;
		#1002 rst = 0;
end

always #5 clk <= ~clk;

reg [7:0] img [1023:0];
initial $readmemh("test2.txt", img);

integer file, i;
initial begin
file = $fopen("kimenet.txt", "w");
for (i=0; i<1024; i=i+1)
begin
$fwrite(file, "%x\n", img[i]);
end
$fclose(file);
end

reg [7:0] cntr = 0;
always @ (posedge clk)
begin
	if(rst | cntr == 255)
		cntr <= 0;
	else 
		cntr <= cntr + 1;
end

assign data_in = img[cntr];

endmodule

