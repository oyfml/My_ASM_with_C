`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.11.2016 19:55:58
// Design Name: 
// Module Name: SQUARE_WAVE_B
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


module SQUARE_WAVE_B(
    input CLOCK,
    input SLOW_CLOCK,
    input PB_UP,
    input PB_DOWN,
    input PB_MIDDLE,
    input SW0,
    input SW1,
    input SW2,
    input SW3,
    input SW4,
    input SW5,
    input SW6,
    input SW7,
    input SW11,
    input SW12,
    input SW13,
    input [1:0] SELECTION_WAVEFORM,
    output [11:0] DATA_A_OUTPUT
    );
    
    //square wave duty cycle//
    reg [11:0] DATA_A = 12'hFFF;
    reg [11:0] DATA_A_HIGH = 12'hFFF; 
    reg [11:0] DATA_A_LOW = 12'h000;
    reg [11:0] amplitude_multiply = 12'h001;
    reg [11:0] offset = 12'h000;
    reg [11:0] offset_multiply = 12'h001;
    
    reg [7:0] squarewave_high = 8'h32; // 50% duty cycle  
    reg [7:0] count = 0;
    reg [7:0] count_low = 100;
    reg [6:0] dutycycle_multiply = 7'h00;
    
    reg counthigh_true = 0;
    reg middle_press = 0;
    reg middle_press_reset = 0;
    reg up_press = 0;
    reg up_press_reset = 0;
    reg down_press = 0;
    reg down_press_reset = 0;
    
    //checking for up & down & middle PB //
    always @(posedge SLOW_CLOCK) begin
    //switch dutycycle setting//
        dutycycle_multiply = (SW13 == 1) ? 7'h32 :                      // 50 dutycycle
                                (SW12 == 1) ? 7'h14 :                   // 20 dutycycle
                                    (SW11 == 1) ? 7'h0A : 7'h01;        // 10 dutycycle else 1 dutycycle
    //end of dutycycle setting//
        if(SELECTION_WAVEFORM == 0 && SW6 == 1 && SW7 == 1)
        begin
        squarewave_high = (PB_DOWN && SW5) ? ((squarewave_high <= dutycycle_multiply) ? 0 : squarewave_high - dutycycle_multiply) :        //duty cycle decrement
                            ((PB_UP && SW5) ? ((squarewave_high + dutycycle_multiply >= 100) ? 100 : squarewave_high + dutycycle_multiply) : squarewave_high);  //duty cycle increment
    
        middle_press = (PB_MIDDLE == 1) ? 1 :
                        ((middle_press_reset == 1) ? 0 : middle_press);     //check MIDDLE pressbutton
                        
        up_press = (PB_UP == 1 && SW2 == 1 && SW3 == 1 && SW4 == 1) ? 1 :
                        ((up_press_reset == 1) ? 0 : up_press);             //check UP pressbutton
                        
        down_press = (PB_DOWN == 1 && SW2 == 1 && SW3 == 1 && SW4 == 1) ? 1 :
                        ((down_press_reset == 1) ? 0 : down_press);         //check DOWN pressbutton
        end                
    end
    //end of checking for up & down & middle PB //     
        
    //square wave//
    always @ (posedge CLOCK) begin
        count = count +1;   
        
        //switch amplitude setting//
        amplitude_multiply = (SW13 == 1) ? 12'h4B4 :                     // 1V
                                (SW12 == 1) ? 12'h078 :                  // 0.1V
                                    (SW11 == 1) ? 12'h00C : 12'h001;     // 0.01V else 0.001
        //end of switch amplitude setting//
        
        //amplitude setting//
        middle_press_reset = (middle_press == 0) ? 0 : middle_press_reset;
        
        if(middle_press == 1 && middle_press_reset == 0 && SW2 == 1) //changing Both amplitude
        begin
            DATA_A_HIGH = (SW0 == 1) ? ((DATA_A_HIGH + offset + amplitude_multiply >= 4095) ? 12'hFFF : (DATA_A_HIGH + amplitude_multiply)) :
                            ((SW1 == 1) ? ((DATA_A_HIGH - amplitude_multiply <= DATA_A_LOW) ? DATA_A_LOW : (DATA_A_HIGH - amplitude_multiply)) : DATA_A_HIGH);
                            
            DATA_A_LOW = (SW0 == 1) ? ((DATA_A_LOW <= amplitude_multiply) ? 12'h000 : (DATA_A_LOW - amplitude_multiply)) : 
                            ((SW1 == 1) ? ((DATA_A_LOW + offset + amplitude_multiply >= DATA_A_HIGH || DATA_A_LOW + offset + amplitude_multiply >= 4095) ? DATA_A_HIGH : (DATA_A_LOW + amplitude_multiply)) : DATA_A_LOW);                                                                                              
            middle_press_reset = 1;
        end
        else if(middle_press == 1 && middle_press_reset == 0 && SW3 == 1) //changing HIGH amplitude
        begin
            DATA_A_HIGH = (SW0 == 1) ? ((DATA_A_HIGH + amplitude_multiply >= 4095) ? 12'hFFF : (DATA_A_HIGH + amplitude_multiply)) :
                            ((SW1 == 1) ? ((DATA_A_HIGH <= amplitude_multiply || DATA_A_HIGH - amplitude_multiply <= DATA_A_LOW) ? DATA_A_LOW : (DATA_A_HIGH - amplitude_multiply)) : DATA_A_HIGH);
            middle_press_reset = 1 ;
        end
        else if(middle_press == 1 && middle_press_reset == 0 && SW4 == 1)//changing LOW amplitude
        begin
            DATA_A_LOW = (SW0 == 1) ? ((DATA_A_LOW + amplitude_multiply >= DATA_A_HIGH || DATA_A_LOW + amplitude_multiply >= 4095) ? DATA_A_HIGH : (DATA_A_LOW + amplitude_multiply)) : 
                            ((SW1 == 1) ? ((DATA_A_LOW <= amplitude_multiply) ? 12'h000 : (DATA_A_LOW - amplitude_multiply)) : DATA_A_LOW);
            middle_press_reset = 1 ;
        end
        //end of amplitude setting//
        
        //amplitude offset setting//
        offset_multiply = (SW13 == 1) ? 12'h4B4 :                     // 1V
                                (SW12 == 1) ? 12'h078 :                  // 0.1V
                                    (SW11 == 1) ? 12'h00C : 12'h001;     // 0.01V else 0.001
        //end of amplitude offset setting//
        
        //amplitude offset//
        up_press_reset = (up_press == 0) ? 0 : up_press_reset;
        down_press_reset = (down_press == 0) ? 0 : down_press_reset;
        
        if(up_press == 1 && up_press_reset == 0)
        begin
            if((DATA_A_HIGH - DATA_A_LOW) + offset + offset_multiply >= 4095 || DATA_A_HIGH + offset + offset_multiply >= 4095)
            begin
                offset = 4095 - DATA_A_HIGH;
            end
            else
            begin
                offset = offset + offset_multiply;
            end
            
            up_press_reset = 1 ;
        end
        else if(down_press == 1 && down_press_reset == 0)
        begin
            if(offset < offset_multiply)
            begin
                offset = 12'h000;
            end
            else
            begin
                offset = offset - offset_multiply;
            end
            
            down_press_reset = 1 ;
        end
        //end of amplitude offset//
        
        //duty cycle//
        if(squarewave_high == 0)
        begin
            DATA_A = DATA_A_LOW + offset;
            count = 0;
        end
        else if(squarewave_high == 100)
        begin
            DATA_A = DATA_A_HIGH + offset;
            count = 0;
        end
        else if(squarewave_high == count && counthigh_true != 1)
        begin
            DATA_A = DATA_A_LOW + offset;
            counthigh_true = 1;
            count = 0;
        end
        else if ((count_low - squarewave_high) == count && counthigh_true != 0)
        begin
            DATA_A = DATA_A_HIGH + offset;
            counthigh_true = 0;
            count = 0;
        end
        //end of duty cycle//
        
    end
        
    assign DATA_A_OUTPUT = DATA_A;
    //end of square wave//

endmodule
