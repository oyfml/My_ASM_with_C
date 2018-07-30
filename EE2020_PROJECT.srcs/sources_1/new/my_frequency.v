`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.10.2016 14:23:08
// Design Name: 
// Module Name: my_frequency
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


module my_frequency(
    input CLOCK,
    input SLOW_CLOCK,
    input PB_LEFT,
    input PB_RIGHT,
    input SW6,
    input SW7,
    input SW8,
    input SW9,
    input SW11,
    input SW12,
    input SW13,
    output reg Z
    );                                                                                                                                       
    reg [19:0] count = 20'b0;
    reg [19:0] vary_clock = 20'h00100;
    reg [19:0] vary_frequency = 15728;
    reg [19:0] vary_binary = 32;
    reg [19:0] clock_multiply = 20'b0;
    
    reg left_press = 0;
    reg left_press_reset = 0;
    reg right_press = 0;
    reg right_press_reset = 0;
    
    //checking for PB//
    always @(posedge SLOW_CLOCK)
    begin
        left_press = (PB_LEFT == 1) ? 1 :
                        ((left_press_reset == 1) ? 0 : left_press);     //check LEFT pressbutton

        right_press = (PB_RIGHT == 1) ? 1 :
                        ((right_press_reset == 1) ? 0 : right_press);     //check RIGHT pressbutton
    end
    //end of checking for PB //
    
    //vary frequency//
    always @(posedge CLOCK)
    begin
        left_press_reset = (left_press == 0) ? 0 : left_press_reset;
        right_press_reset = (right_press == 0) ? 0 : right_press_reset;

        clock_multiply = (1000/(vary_frequency/vary_binary));

        if(SW6 == 0 && SW7 == 0 && SW8 == 0 && SW9 == 0)
        begin
            if(right_press == 1 && right_press_reset == 0)
            begin
            vary_clock = vary_clock + clock_multiply;

            right_press_reset = 1;
            end
            else if(left_press == 1 && left_press_reset == 0)
            begin
            vary_clock = vary_clock - clock_multiply;

            left_press_reset = 1;
            end
        end
        
        count = count + 1;
        if(count == vary_clock)
        begin
            Z = ~Z;
            count = 0;
        end
    end
    //end vary frequency//
    
endmodule
