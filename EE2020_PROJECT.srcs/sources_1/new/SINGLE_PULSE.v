`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2016 15:15:41
// Design Name: 
// Module Name: SINGLE_PULSE
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


module SINGLE_PULSE(
    input CLOCK,
    input PUSHBUTTON,
    output Z
    );
    
    wire a0,a1;
    DFF unit1(CLOCK, PUSHBUTTON, a0);
    DFF unit2(CLOCK, a0, a1);
    and u0(Z, a0, ~a1);
    
endmodule
