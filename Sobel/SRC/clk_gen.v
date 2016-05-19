`timescale 1ns / 1ps

module clk_gen(
   input  clk_in,
   output clk_out   
);

wire clk_in_bufg;
IBUFG ibufg_in (					//Bej�v� �rajel bufferel�se
   .O(clk_in_bufg), 
   .I(clk_in)
);
 
DCM_CLKGEN #(
   .CLKFXDV_DIVIDE(2),        // Ezt az oszt�t nem haszn�ljuk
   .CLKFX_DIVIDE(64),         // Ezzel �ll�tjuk be a 64 es oszt�st
   .CLKFX_MD_MAX(0.0),        
   .CLKFX_MULTIPLY(32),       // 32-vel szorozva kij�n az �rajel felez�s
   .CLKIN_PERIOD(20.0),       // 20ns - 50MHz
   .SPREAD_SPECTRUM("NONE"), 
   .STARTUP_WAIT("FALSE")     
)
DCM_CLKGEN_0 (
   .CLKFX(clkfx),         		// Innen vessz�k le a 32/64-el osztott �rajelet
   .CLKFX180(),   				
   .CLKFXDV(),     				// Innen vehetn�nk le CLKFX CLKFXDV_DIVIDE-al ossztottj�t
   .LOCKED(),      				
   .PROGDONE(),   				
   .STATUS(),       				
   .CLKIN(clk_in_bufg),       // 1-bit input: Input clock
   .FREEZEDCM(1'b0), 			
   .PROGCLK(1'b0),     			
   .PROGDATA(1'b0),   			
   .PROGEN(1'b0),       		
   .RST(1'b0)             		
);

BUFG bufg_dcm0_clkfx (			//Kimen� �rajel bufferel�se
   .O(clkfx_bufg),
   .I(clkfx)
);

assign clk_out = clkfx_bufg;

endmodule

