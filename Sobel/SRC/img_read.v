`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:35:36 05/04/2016 
// Design Name: 
// Module Name:    img_read 
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
module img_read(
	 input clk,
    input rst,
	 output  [7:0] p0,p1,p2,p3,p5,p6,p7,p8,
	 output vsync,
	 output hsync
    );
	 
	reg [7:0] img [640*480-1:0];
	initial $readmemh("cica.txt", img);
	
	reg [20:0] cntr;
	always @ (posedge clk) begin
		if(rst | (cntr == 640*480))
			cntr <= 1'b0;
		else 
			cntr <= cntr + 1'b1;
	end
	
	
	
	reg [7:0] p0_reg,p1_reg,p2_reg,p3_reg,p5_reg,p6_reg,p7_reg,p8_reg;
	reg hiba = 1'b0;
	always @ (posedge clk) 
	begin
		if((cntr <= 639) | (cntr%640 == 0) | ((cntr-639)%640 == 0) | (cntr > (640*480-640)))begin
			hiba <= 1;	//"hiba":kép széle
			p0_reg <= 0;
			p1_reg <= 0;
			p2_reg <= 0;
			p3_reg <= 0;
			p5_reg <= 0;
			p6_reg <= 0;
			p7_reg <= 0;
			p8_reg <= 0;
			end
		else begin
			hiba <= 0;
			p0_reg <= img[cntr-640-1];
			p1_reg <= img[cntr-640];
			p2_reg <= img[cntr-640+1];
			p3_reg <= img[cntr-1];
			p5_reg <= img[cntr+1];
			p6_reg <= img[cntr+640-1];
			p7_reg <= img[cntr+640];
			p8_reg <= img[cntr+640+1];
			end
	end
	
	reg hsync_reg,vsync_reg;
	always @ (posedge clk) 
	begin
		if(rst)
		begin
			hsync_reg <= 0;
			vsync_reg <= 0;
		end
	end
	
assign	p0	= p0_reg;
assign	p1	= p1_reg;
assign	p2	= p2_reg;
assign	p3	= p3_reg;
assign	p5	= p5_reg;
assign	p6	= p6_reg;
assign	p7	= p7_reg;
assign	p8 = p8_reg;
	


endmodule
