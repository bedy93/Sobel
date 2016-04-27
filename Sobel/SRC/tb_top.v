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
	reg [7:0] p0;
	reg [7:0] p1;
	reg [7:0] p2;
	reg [7:0] p3;
	reg [7:0] p5;
	reg [7:0] p6;
	reg [7:0] p7;
	reg [7:0] p8;

	// Outputs
	wire [7:0] out_data;

	// Instantiate the Unit Under Test (UUT)
	top_level uut (
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

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		p0 = 0;
		p1 = 0;
		p2 = 0;
		p3 = 0;
		p5 = 0;
		p6 = 0;
		p7 = 0;
		p8 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	reg [7:0] img [1023:0];
	initial $readmemh("test.txt", img);

	integer file;
	initial begin
		file = $fopen("out.txt", "w");
		while(cntr < 64) begin
			if((cntr < 8) | (cntr%7 == 0) | (cntr%8 == 0) | (cntr > 56)) begin
				$fwrite(file, "%x\n", 0);
			end
			else begin
				p0 = img[cntr-8-1];
				p1 = img[cntr-8];
				p2 = img[cntr-8+1];
				p3 = img[cntr-1];
				p5 = img[cntr+1];
				p6 = img[cntr+8-1];
				p7 = img[cntr+8];
				p8 = img[cntr+8+1];
				$fwrite(file, "%x\n", out_data);
			end
		end
		$fclose(file);
	end

	reg [9:0] cntr = 0;
	always @ (posedge clk) begin
		if(rst)
			cntr <= 0;
		else 
			cntr <= cntr + 1;
	end

	always #5 clk <= ~clk;

endmodule

