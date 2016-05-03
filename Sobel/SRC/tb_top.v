`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:09:58 04/20/2016
// Design Name:   top_level
// Module Name:   
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
	
	reg [7:0] img [640*480-1:0];
	initial $readmemh("cica.txt", img);

	reg [20:0] cntr = 1'b00;
	always @ (posedge clk) begin
		if(rst | (cntr == 640*480))
			cntr <= 1'b0;
		else 
			cntr <= cntr + 1'b1;
	end

	reg hiba = 1'b0;
	always @ (posedge clk) begin
		//if((cntr <= 31) | (cntr%32 == 0) | ((cntr-31)%32 == 0) | (cntr > 992))begin
		if((cntr <= 639) | (cntr%640 == 0) | ((cntr-639)%640 == 0) | (cntr > (640*480-640)))begin
			hiba <= 1;	//"hiba":kép széle
			p0 <= 0;
			p1 <= 0;
			p2 <= 0;
			p3 <= 0;
			p5 <= 0;
			p6 <= 0;
			p7 <= 0;
			p8 <= 0;
			end
		else begin
			hiba <= 0;
			p0 <= img[cntr-640-1];
			p1 <= img[cntr-640];
			p2 <= img[cntr-640+1];
			p3 <= img[cntr-1];
			p5 <= img[cntr+1];
			p6 <= img[cntr+640-1];
			p7 <= img[cntr+640];
			p8 <= img[cntr+640+1];
			end
	end
	
	integer file;
	initial begin
	file = $fopen("out.txt", "w");
	end
	
	reg k = 1'b0;
	reg vege = 1'b0;
	
	always @(posedge clk)begin
		if((cntr <= 640*480) & (k == 0))begin
			$fwrite(file,"%x\n",{1'b0,out_data});
			if(cntr == 640*480)
				k <= 1;
			end
		if(cntr == 640*480)
				vege <= 1;	
	end

	
	always #1 clk <= ~clk;

endmodule

