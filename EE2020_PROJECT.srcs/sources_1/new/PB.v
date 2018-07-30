`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2016 15:09:09
// Design Name: 
// Module Name: PB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PB(
    input PB_CLOCK,
    input [4:0] PB,
    output Z_MIDDLE,
    output Z_UP,
    output Z_LEFT,
    output Z_RIGHT,
    output Z_DOWN
    );
    
    SINGLE_PULSE U0 (PB_CLOCK, PB[0], Z_MIDDLE);
    SINGLE_PULSE U1 (PB_CLOCK, PB[1], Z_UP);
    SINGLE_PULSE U2 (PB_CLOCK, PB[2], Z_LEFT);
    SINGLE_PULSE U3 (PB_CLOCK, PB[3], Z_RIGHT);
    SINGLE_PULSE U4 (PB_CLOCK, PB[4], Z_DOWN);
    
endmodule
