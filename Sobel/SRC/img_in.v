`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:04:00 05/12/2016 
// Design Name: 
// Module Name:    img_in 
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
module img_in(
	 input clk,
    input rst,
	 output [7:0] pix_0,pix_1,pix_2,pix_3,pix_5,pix_6,pix_7,pix_8
    );
	 
	parameter WIDTH = 128;
	parameter HEIGHT = 96;

//k�p beolvas�sa blockram-ba
	(* ram_style = "block" *)
	reg [7:0] img [WIDTH*HEIGHT-1:0];
	initial $readmemh("kocka_128_96.txt", img);
	
//sz�ml�l� a k�p pixeleinek c�mz�s�hez	
	//25MHz: xclk/2 to VGA
	reg clk_en;				
	always @(posedge clk)
		if(rst)
			clk_en <= 0;
		else
			clk_en <= ~clk_en;	 
	 
	//horizont�lis �s vertik�lis pixel sz�ml�l�k (640*480-as felbont�shoz)
	reg [9:0] hcntr;
	reg [9:0] vcntr;	
	always @(posedge clk)
		if(clk_en)
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
				
	reg  [14:0] pix_cntr;
	always @ (posedge clk)
		if(clk_en)
			if(rst)
				pix_cntr <= 0;
			else
				//pix_cntr <= vcntr[9:2]*WIDTH + hcntr[9:2]; 	//ez nem t�k�letes, de hardverben hat�kony
				pix_cntr <= (vcntr/5)*WIDTH + hcntr/5;			//�gy k�ne, csak 5-tel osztani nem eleg�ns
			
			
//3x3 blokkok a sobel algoritmus sz�m�ra	
	reg [7:0] pix_0_reg,pix_1_reg,pix_2_reg,pix_3_reg,pix_5_reg,pix_6_reg,pix_7_reg,pix_8_reg;
	reg hiba = 1'b0;		//"hiba":k�p sz�le
	
	always @ (posedge clk)
	begin
	if(clk_en)
		if((pix_cntr <= (WIDTH-1)) | (pix_cntr%WIDTH == 0) | ((pix_cntr-(WIDTH-1))%WIDTH  ==  0) | (pix_cntr > (WIDTH*HEIGHT-WIDTH)))// els� sor, els� oszlop, utols� oszlop, utols� sor kihagy�sa
		begin																																								  // a k�p sz�l�nek kezel�se
			hiba <= 1;			
			pix_0_reg <= 0;
			pix_1_reg <= 0;
			pix_2_reg <= 0;
			pix_3_reg <= 0;
			pix_5_reg <= 0;
			pix_6_reg <= 0;
			pix_7_reg <= 0;
			pix_8_reg <= 0;
		end
		else begin
			hiba <= 0;
			pix_0_reg <= img[pix_cntr-WIDTH-1];
			pix_1_reg <= img[pix_cntr-WIDTH];
			pix_2_reg <= img[pix_cntr-WIDTH+1];
			pix_3_reg <= img[pix_cntr-1];
			pix_5_reg <= img[pix_cntr+1];
			pix_6_reg <= img[pix_cntr+WIDTH-1];
			pix_7_reg <= img[pix_cntr+WIDTH];
			pix_8_reg <= img[pix_cntr+WIDTH+1];
		end
	end

//kimenetek
	assign	pix_0	= pix_0_reg;
	assign	pix_1	= pix_1_reg;
	assign	pix_2	= pix_2_reg;
	assign	pix_3	= pix_3_reg;
	assign	pix_5	= pix_5_reg;
	assign	pix_6	= pix_6_reg;
	assign	pix_7	= pix_7_reg;
	assign	pix_8 = pix_8_reg;

endmodule
