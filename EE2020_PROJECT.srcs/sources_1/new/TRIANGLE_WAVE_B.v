`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.11.2016 20:29:07
// Design Name: 
// Module Name: TRIANGLE_WAVE_B
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


module TRIANGLE_WAVE_B(
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
input SW6,
input SW7,
input SW8,
input SW11,
input SW12,
input SW13,
input [1:0] SELECTION_WAVEFORM,
output [11:0] DATA_A_OUTPUT
);

reg [11:0] DATA_A = 12'h000;
reg [11:0] DATA_A_Z = 12'h000;
reg [11:0] DATA_A_HIGH = 12'hFFF; 
reg [11:0] DATA_A_LOW = 12'h000;
reg [11:0] amplitude_multiply = 12'h001;
reg [11:0] offset = 12'h000;
reg [11:0] offset_multiply = 12'h001;

reg shift = 1'b0;
reg middle_press = 0;
reg middle_press_reset = 0;
reg up_press = 0;
reg up_press_reset = 0;
reg down_press = 0;
reg down_press_reset = 0;

//checking for up & down & middle PB //
always @(posedge SLOW_CLOCK) begin
    if(SELECTION_WAVEFORM == 1 && SW6 == 1 && SW7 == 1)
    begin
    middle_press = (PB_MIDDLE == 1) ? 1 :
                    ((middle_press_reset == 1) ? 0 : middle_press);     //check MIDDLE pressbutton
                    
    up_press = (PB_UP == 1 && SW2 == 1 && SW3 == 1 && SW4 == 1) ? 1 :
                            ((up_press_reset == 1) ? 0 : up_press);             //check UP pressbutton
                                    
    down_press = (PB_DOWN == 1 && SW2 == 1 && SW3 == 1 && SW4 == 1) ? 1 :
                    ((down_press_reset == 1) ? 0 : down_press);         //check DOWN pressbutton
    end
end
//end of checking for up & down & middle PB //    

//triangle waveform//

always @ (posedge CLOCK) begin
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

shift = (DATA_A == 12'hFFF && SW8 == 0) ? 1'b1 : ((DATA_A == 12'h000 && SW8 == 0) ? 1'b0 : shift); 
shift = (DATA_A == 12'hFFF && SW8 == 1 && SW1 == 1) ? 1'b1 : ((DATA_A == 12'h000 && SW8 == 1 && SW0 == 1) ? 1'b0 : shift); // check oscillscope
DATA_A = (shift == 1'b0) ? DATA_A + 21 : DATA_A - 21;

DATA_A_Z  = ((DATA_A* (DATA_A_HIGH-DATA_A_LOW))/4095 + DATA_A_LOW) + offset;

end
//end of triangle waveform//

assign DATA_A_OUTPUT = DATA_A_Z;

endmodule
