`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:01:33 05/17/2016 
// Design Name: 
// Module Name:    img_vga 
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
module img_vga(
	 input clk,
    input rst,
	 output [5:0] rgb,
	 output vsync,
	 output hsync
    );	 
	 
	parameter WIDTH = 128;
	parameter HEIGHT = 96;

//kép beolvasása blockram-ba
	(* ram_style = "block" *)
	reg [7:0] img [WIDTH*HEIGHT-1:0];
	initial $readmemh("kocka_128_96.txt", img);
	 
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
				hcntr <= hcntr + 1;

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

//aktuális tartomány horizontálisan	kép kirajzolásához
	reg hact_img;	
	always @(posedge clk)
			if(hcntr == 63)
				hact_img <= 1;
			else if(hcntr == 575)
				hact_img <= 0;
		
//aktuális tartomány vertikálisankép kirajzolásához
	reg vact_img;	
	always @(posedge clk)
			if(vcntr == 47 & hcntr == 799)
				vact_img <= 1;
			else if(vcntr == 431 & hcntr == 799)
				vact_img <= 0;

//aktuális tartomány
	reg act;
	reg act_img;
	always @(posedge clk)
		if(rst) begin
			act <= 0;
			act_img <= 0;
			end
		else begin	
			act <= (hact1 & vact1);
			act_img <= (hact_img & vact_img);
			end

//pixelek a sobel algoritmushoz
	wire [9:0] vcntr2;
	wire [9:0] hcntr2;	
	assign vcntr2 = vcntr - 48;
	assign hcntr2 = hcntr - 64;		
	
	reg  [14:0] pix_cntr;
	always @ (posedge clk)
		if(rst)
			pix_cntr <= 0;
		else 
			pix_cntr <= vcntr2[9:2]*WIDTH + hcntr2[9:2];
			
//3x3 blokkok a sobel algoritmus számára	
	reg [7:0] pix_0_reg,pix_1_reg,pix_2_reg,pix_3_reg,pix_5_reg,pix_6_reg,pix_7_reg,pix_8_reg;
	reg hiba = 1'b0;		//"hiba":kép széle
	
	always @ (posedge clk)
	begin
		if((pix_cntr <= (WIDTH-1)) | (pix_cntr%WIDTH == 0) | ((pix_cntr-(WIDTH-1))%WIDTH  ==  0) | (pix_cntr > (WIDTH*HEIGHT-WIDTH)) | ~act_img)// elsõ sor, elsõ oszlop, utolsó oszlop, utolsó sor kihagyása
		begin																																								  // a kép szélének kezelése
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

	wire out_data;
	sobel sobel_0(
		.clk(clk),
		.rst(rst),
		.pix_0(pix_0_reg), 
		.pix_1(pix_1_reg), 
		.pix_2(pix_2_reg), 
		.pix_3(pix_3_reg), 
		.pix_5(pix_5_reg), 
		.pix_6(pix_6_reg), 
		.pix_7(pix_7_reg), 
		.pix_8(pix_8_reg),
		.out_data(out_data)
	);

//szín elõállítása
	reg [5:0]rgb_reg;
	always @(posedge clk)
			if(act_img)
				rgb_reg <= {6{out_data}};
			else if(act)
				rgb_reg <= 6'b101101;		//itt lehet a keretnek színt adni
			else
				rgb_reg <= 6'b0;

//kimenetek
	assign rgb = rgb_reg;
	assign hsync = hsync1;
	assign vsync = vsync1;	 
	
endmodule
