`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.11.2016 19:46:00
// Design Name: 
// Module Name: SQUARE_FREQUENCY_B
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


module SQUARE_FREQUENCY_B(
    input CLOCK,
    input SLOW_CLOCK,
    input PB_LEFT,
    input PB_RIGHT,
    input SW6,
    input SW7,
    input SW9,
    input SW10,
    input SW11,
    input SW12,
    input SW13,
    input [1:0] SELECTION_WAVEFORM,
    output reg Z,
    output LED0,
    output LED1,
    output LED2
    );
    reg [19:0] count = 20'b0;
    integer FPGA_frequency = 500000000;
    integer frequency = 4785;               //478.5mHz
    integer vary_clock = 1044932;           //478.5mHz might wanna change to 0;
    integer frequency_addition = 1000;
    
    reg left_press = 0;
    reg left_press_reset = 0;
    reg right_press = 0;
    reg right_press_reset = 0;
    
    reg mHz = 0;
    reg Hz = 0;
    reg kHz = 0;
    
    //checking for PB//
    always @(posedge SLOW_CLOCK)
    begin
        if(SELECTION_WAVEFORM == 0 && SW6 == 1 && SW7 == 1)
        begin
            left_press = (PB_LEFT == 1) ? 1 :
                            ((left_press_reset == 1) ? 0 : left_press);     //check LEFT pressbutton
    
            right_press = (PB_RIGHT == 1) ? 1 :
                            ((right_press_reset == 1) ? 0 : right_press);     //check RIGHT pressbutton
        end
    end
    //end of checking for PB //
    
    //vary frequency//
    always @(posedge CLOCK)
    begin
        //switch frequency setting//
        frequency_addition = (SW13 == 1) ? 10000000 :            // 1KHz
                             (SW12 == 1) ? 1000000 :             // 100Hz
                             (SW11 == 1) ? 100000 :              // 10Hz
                             (SW10 == 1) ? 10000 :               // 1Hz
                             (SW9 == 1) ? 1000: 100;             // 0.1Hz else 0.01Hz
        //end of switch frequency setting//
        
        left_press_reset = (left_press == 0) ? 0 : left_press_reset;
        right_press_reset = (right_press == 0) ? 0 : right_press_reset;
        
        if(left_press == 1 && left_press_reset == 0) //increase frequency
        begin
            if(frequency + frequency_addition >= 200000000)
            begin
                frequency = 200000000;
            end
            else
            begin 
                frequency = frequency + frequency_addition;
            end
            left_press_reset = 1 ;
        end
        else if(right_press == 1 && right_press_reset == 0)//decrease frequency
        begin
            if(frequency - frequency_addition <= 4785 || frequency <= frequency_addition)
            begin
                frequency = 4785;
            end
            else
            begin
                frequency = frequency - frequency_addition;
            end
            right_press_reset = 1 ;
        end
        vary_clock = ((FPGA_frequency/frequency)*10);
        
        //frequency LED//
        if(frequency >= 10000000)
        begin
            mHz = 0;
            Hz = 0;
            kHz = 1;
        end
        else if(frequency >= 10000)
        begin
            mHz = 0;
            Hz = 1;
            kHz = 0;
        end
        else
        begin
            mHz = 1;
            Hz = 0;
            kHz = 0;
        end
        //end of frequency LED//
        
        count = count + 1;
        if(count == vary_clock)
        begin
            Z = ~Z;
            count = 0;
        end
    end
    //end vary frequency//
    
    assign LED0 = mHz;
    assign LED1 = Hz;
    assign LED2 = kHz;
    
endmodule
