`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.10.2016 14:02:27
// Design Name: 
// Module Name: SLOW_CLOCK
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


module SLOW_CLOCK(
    input CLOCK,
    output Z
    );
     
    reg[20:0] COUNT = 21'b0000000;
    always @ (posedge CLOCK) begin
    COUNT <= COUNT + 1; // 3Hz
    end
    
    assign Z = COUNT[20];
endmodule
