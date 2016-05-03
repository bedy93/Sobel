`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    
// Design Name: 
// Module Name:    VGA 
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
module VGA(
	input clk,
	input rst,
//	input wr_en,
//  input [12:0] wr_addr,
//  input [ 3:0] wr_data,
	output hsync,
	output vsync,
	output [3:0] rgb
    );

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

endmodule
