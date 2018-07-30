`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2016 14:44:26
// Design Name: 
// Module Name: HALF_CLOCK
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


module HALF_CLOCK(
    input CLOCK,
    output Z
    );
    
    reg count = 1'b0;
    
    always @ (posedge CLOCK) begin
    count <= count + 1;
    end
    
    assign Z = count;
    
endmodule
