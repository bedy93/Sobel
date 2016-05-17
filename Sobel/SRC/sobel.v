`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:03:28 05/12/2016 
// Design Name: 
// Module Name:    sobel 
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
module sobel(
	 input clk,
    input rst,
	 input [7:0] pix_0,pix_1,pix_2,pix_3,pix_5,pix_6,pix_7,pix_8,
	 output out_data
    );
	 
wire signed [10:0] gx, gy;    		//11 bit: gx es gy max ertekei: 255*4 + 1
wire signed [10:0] abs_gx, abs_gy;	//absz.ertek
wire [10:0] sum;				 			//kimenet: max 255*8 bit lehet

assign gx =((pix_2-pix_0) + ((pix_5-pix_3)<<1) + (pix_8-pix_6));		//sobel maszk (horizontális)
assign gy =((pix_0-pix_6) + ((pix_1-pix_7)<<1) + (pix_2-pix_8));		//sobel maszk (vertikális)

assign abs_gx = (gx[10] ? ~gx+1 : gx);				//ha negativ: absz erteket veszem
assign abs_gy = (gy[10] ? ~gy+1 : gy);	
 
assign sum = abs_gx + abs_gy;							//x es y irany osszeadasa

assign out_data = |sum[10:7];	//ha nagyobb 128-nél kimenet: 1, ha él, ha nem él: 0

endmodule
