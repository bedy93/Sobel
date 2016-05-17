`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:04:19 05/12/2016 
// Design Name: 
// Module Name:    vga 
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
module vga(
	 input clk,
    input rst,
	 input data,
	 output [5:0] rgb,
	 output vsync,
	 output hsync
    );
	 
	 
//horizontális és vertikális pixel számlálók
	reg [9:0] hcntr;
	reg [9:0] vcntr;	
	always @(posedge clk)
			if(rst)begin
				hcntr <= 10'b0;
				vcntr <= 10'b0;
			end
			else if(hcntr == 799)begin
				if(vcntr == 520)
					vcntr <= 0;
				else
					vcntr <= vcntr + 1;
				hcntr <= 0;
			end
			else 
				hcntr <= hcntr + 1'b1;

//hsync jel		
	reg hsync1;	
	always @(posedge clk)
			if(hcntr == 655 | rst)
				hsync1 <= 0;
			else if(hcntr == 751)
				hsync1 <= 1;

//vsync jel
	reg vsync1;	
	always @(posedge clk)
			if((vcntr == 489 & hcntr == 799) | rst)
				vsync1 <= 0;
			else if(vcntr == 491 & hcntr == 799)
				vsync1 <= 1;

//aktuális tartomány horizontálisan	
	reg hact1;	
	always @(posedge clk)
			if(hcntr == 799)
				hact1 <= 1;
			else if(hcntr == 639)
				hact1 <= 0;
		
//aktuális tartomány vertikálisan	
	reg vact1;	
	always @(posedge clk)
			if(vcntr == 520 & hcntr == 799)
				vact1 <= 1;
			else if(vcntr == 479 & hcntr == 799)
				vact1 <= 0;

//aktuális tartomány
	reg act;
	always @(posedge clk)
		if(rst)
			act <= 0;
		else	
			act <= (hact1&vact1);

//szín elõállítása
	reg [5:0]rgb_reg;
	always @(posedge clk)
			if(act)
				rgb_reg <= {6{data}};	//data,  itt nem akarjuk kihasználni, hogy 2 biten tudunk színt ábrázolni  ?:D
			else 
				rgb_reg <= 6'b0;

//kimenetek
	assign rgb = rgb_reg;
	assign hsync = hsync1;
	assign vsync = vsync1;	 

endmodule
