`timescale 1ns / 1ps

module clk_gen(
   input  clk_in,
   output clk_out   
);



wire clk_in_bufg;
IBUFG ibufg_in (
   .O(clk_in_bufg), 
   .I(clk_in)
);

DCM_CLKGEN #(
   .CLKFXDV_DIVIDE(2),       // CLKFXDV divide value (2, 4, 8, 16, 32)
   .CLKFX_DIVIDE(64),         // Divide value - D - (1-256)
   .CLKFX_MD_MAX(0.0),       // Specify maximum M/D ratio for timing anlysis
   .CLKFX_MULTIPLY(32),       // Multiply value - M - (2-256)
   .CLKIN_PERIOD(20.0),       // Input clock period specified in nS
   .SPREAD_SPECTRUM("NONE"), // Spread Spectrum mode "NONE", "CENTER_LOW_SPREAD", "CENTER_HIGH_SPREAD",
                             // "VIDEO_LINK_M0", "VIDEO_LINK_M1" or "VIDEO_LINK_M2" 
   .STARTUP_WAIT("FALSE")    // Delay config DONE until DCM_CLKGEN LOCKED (TRUE/FALSE)
)
DCM_CLKGEN_0 (
   .CLKFX(clkfx),         // 1-bit output: Generated clock output
   .CLKFX180(),   // 1-bit output: Generated clock output 180 degree out of phase from CLKFX.
   .CLKFXDV(),     // 1-bit output: Divided clock output
   .LOCKED(),       // 1-bit output: Locked output
   .PROGDONE(),   // 1-bit output: Active high output to indicate the successful re-programming
   .STATUS(),       // 2-bit output: DCM_CLKGEN status
   .CLKIN(clk_in_bufg),         // 1-bit input: Input clock
   .FREEZEDCM(1'b0), // 1-bit input: Prevents frequency adjustments to input clock
   .PROGCLK(1'b0),     // 1-bit input: Clock input for M/D reconfiguration
   .PROGDATA(1'b0),   // 1-bit input: Serial data input for M/D reconfiguration
   .PROGEN(1'b0),       // 1-bit input: Active high program enable
   .RST(1'b0)              // 1-bit input: Reset input pin
);

BUFG bufg_dcm0_clkfx (
   .O(clkfx_bufg),
   .I(clkfx)
);

assign clk_out = clkfx_bufg;

endmodule

