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
	wire [7:0] out_data;
	wire [5:0] xrgb;
	wire xhs;
	wire xvs;


	// Instantiate the Unit Under Test (UUT)
	top_level uut (
		.clk(clk), 
		.rst(rst),
		.out_data(out_data),
		.xrgb(xrgb),
		.xhs(xhs),
		.xvs(xvs)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		
		// Wait 100 ns for global reset to finish
		#40 rst = 0;
		
        
		// Add stimulus here

	end
	
	reg [20:0] cntr;
	always @ (posedge clk) begin
		if(rst | (cntr == 800*521))
			cntr <= 1'b0;
		else 
			cntr <= cntr + 1'b1;
	end
	
	integer file;
	initial begin
	file = $fopen("out.txt", "w");
	end
	
	reg k = 1'b0;
	reg vege = 1'b0;
	
	always @(posedge clk)begin
		if((cntr <= 800*521) & (k == 0))begin
			$fwrite(file,"%x\n",{1'b0,out_data});
			if(cntr == 800*521)
				k <= 1;
			end
		if(cntr == 800*521)
		begin
				vege <= 1;
				$fclose(file);
		end
	end

	
	always #20 clk <= ~clk;

endmodule

