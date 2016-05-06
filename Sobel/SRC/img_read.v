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
	 output  [7:0] pix_0,pix_1,pix_2,pix_3,pix_5,pix_6,pix_7,pix_8,
	 output vsync,
	 output hsync
    );
	
	(* ram_style = "block" *)
	reg [7:0] img [640*480-1:0]  ;

	initial $readmemh("cica.txt", img);
	
	reg [20:0] cntr;
	always @ (posedge clk) begin
		if(rst | (cntr == 640*480))
			cntr <= 1'b0;
		else 
			cntr <= cntr + 1'b1;
	end
	
	
	
	reg [7:0] pix_0_reg,pix_1_reg,pix_2_reg,pix_3_reg,pix_5_reg,pix_6_reg,pix_7_reg,pix_8_reg;
	reg hiba = 1'b0;
	always @ (posedge clk) 
	begin
		if((pix_cntr <= 639) | (pix_cntr%640 == 0) | ((pix_cntr-639)%640 == 0) | (pix_cntr > (640*480-640)) | ~act )// elsõ sor, elsõ oszlop, utolsó oszlop, utolsó sor kihagyása
		begin
			hiba <= 1;	//"hiba":kép széle
			pix_0_reg <= 0;
			pix_1_reg <= 0;
			pix_2_reg <= 0;
			pix_3_reg <= 0;
			pix_5_reg <= 0;
			pix_6_reg <= 0;
			pix_7_reg <= 0;
			pix_8_reg <= 0;
		end
		else 
		begin
			hiba <= 0;
			pix_0_reg <= img[pix_cntr-640-1];
			pix_1_reg <= img[pix_cntr-640];
			pix_2_reg <= img[pix_cntr-640+1];
			pix_3_reg <= img[pix_cntr-1];
			pix_5_reg <= img[pix_cntr+1];
			pix_6_reg <= img[pix_cntr+640-1];
			pix_7_reg <= img[pix_cntr+640];
			pix_8_reg <= img[pix_cntr+640+1];
		end
	end
	
reg [9:0] hcntr;
reg [9:0] vcntr;
reg hsync1;
reg vsync1;
reg hact1;
reg vact1;
reg [3:0] rgb1;

always @(posedge clk)
	if(rst)
		begin
		hcntr<=10'b0;
		vcntr<=10'b0;
		end
	else if(hcntr==799)
		begin
		if(vcntr==520)
			vcntr<=0;
		else
			vcntr<=vcntr+1;
		hcntr<=0;
		end
	else 
		hcntr<=hcntr+1;
		
always @(posedge clk)
	if(hcntr==655 | rst)
		hsync1<=0;
	else if(hcntr==752)
		hsync1<=1;

always @(posedge clk)
	if((vcntr==489 & hcntr==799) | rst)
		vsync1<=0;
	else if(vcntr==491 & hcntr==799)
		vsync1<=1;
		
always @(posedge clk)
	if(hcntr==799)
		hact1<=1;
	else if(hcntr==639)
		hact1<=0;
	
always @(posedge clk)
	if(vcntr==520 & hcntr==799)
		vact1<=1;
	else if(vcntr==479 & hcntr==799)
		vact1<=0;
		

reg  [20:0] pix_cntr;
always @ (posedge clk)
	if(rst)
		pix_cntr <= 0;
	else
		pix_cntr <= vcntr*640+hcntr;
	
	
		
		
		
		
always @(posedge clk)
	if(vact1==0 & hact1==0)
		rgb1<=3'b0;
	else if(vact1 & hact1)
		begin
		if (vcntr[3:0]>=4'b0000 & vcntr[3:0]<=4'b0111)
			if (hcntr[3:0]==4'b0000)
				rgb1<=3'b000;
			else if (hcntr[3:0]==4'b1000)
				rgb1<=3'b111;
				
		 if(vcntr[3:0]>=4'b1000 & vcntr[3:0]<=4'b1111)
			if (hcntr[3:0]==4'b0000)
				rgb1<=3'b111;
			else if (hcntr[3:0]==4'b1000)
				rgb1<=3'b000;
		end
 //sakktábla


	
//wire [12:0] cim;
//assign cim={vcntr[9:3],hcntr[9:3]};

reg act;
always @(posedge clk)
	act<=(hact1&vact1);

/*wire [3:0] rd_data;		
frame_buffer uut2(
   .clk(clk),
   .rst(rst),
   .wr_en(wr_en),
   .wr_addr(wr_addr),
   .wr_data(wr_data),
   .rd_addr(cim),
   .rd_data(rd_data)
);*/
		

assign hsync=hsync1;
assign vsync=vsync1;		
//assign rgb=(act)? rd_data : 4'b0000;
assign rgb = (act)? rgb1 : 4'b0000;
	
assign	pix_0	= pix_0_reg;
assign	pix_1	= pix_1_reg;
assign	pix_2	= pix_2_reg;
assign	pix_3	= pix_3_reg;
assign	pix_5	= pix_5_reg;
assign	pix_6	= pix_6_reg;
assign	pix_7	= pix_7_reg;
assign	pix_8 = pix_8_reg;
	


endmodule
