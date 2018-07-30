`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2016 14:55:20
// Design Name: 
// Module Name: DAC_CLOCK
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


module DAC_CLOCK(
    input CLOCK,
    output Z
    );
    
    reg [4:0] count = 5'b00000;
    always @ (posedge CLOCK) begin
    count <= count + 1;
    end
    
    assign Z = count[4];
    
endmodule
