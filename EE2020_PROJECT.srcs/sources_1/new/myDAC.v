`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2016 14:42:48
// Design Name: 
// Module Name: myDAC
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


module myDAC(
    input MHZ100_CLOCK,
    input RESET,
    input [14:0] SW,
    input [4:0] PB,
    output [15:0] LED,
    output [3:0] JA,
    output A, B, C, D, E, F, G, DP,
    output [3:0] AN
    );
       
    wire a,b,c,d,e,f,g;
    wire h,i,j,k,l,m,n;
    wire Z_PB_clock, Z_PB_middle, Z_PB_up, Z_PB_left, Z_PB_right, Z_PB_down;
    
    //A//
    wire [11:0] square_data_high_7segment;
    wire [11:0] square_data_low_7segment;
    wire [11:0] square_data_both_7segment;
    wire [11:0] square_offset_7segment;
    wire [11:0] square_dutycycle_7segment;
    
    wire [11:0] triangle_data_high_7segment;
    wire [11:0] triangle_data_low_7segment;
    wire [11:0] triangle_data_both_7segment;
    wire [11:0] triangle_offset_7segment;
    
    wire [11:0] sine_data_high_7segment;
    wire [11:0] sine_data_low_7segment;
    wire [11:0] sine_data_both_7segment;
    wire [11:0] sine_offset_7segment;
    
    wire [11:0] rectifed_sine_data_high_7segment;
    wire [11:0] rectifed_sine_data_low_7segment;
    wire [11:0] rectifed_sine_data_both_7segment;
    wire [11:0] rectifed_sine_offset_7segment;

    wire [11:0] DATA_A;
    wire [11:0] DATA_A_SQUARE;
    wire [11:0] DATA_A_TRIANGLE;
    wire [11:0] DATA_A_SINE;
    wire [11:0] DATA_A_SINE_RECTIFIED;
    
    wire triangle_LED0, triangle_LED1, triangle_LED2;
    wire sine_LED0, sine_LED1, sine_LED2;
    wire square_LED0, square_LED1, square_LED2;
    
    wire[1:0] selection_waveform;
    
    wire[13:0] square_frequency_7segment;
    wire[13:0] triangle_frequency_7segment;
    wire[13:0] sine_frequency_7segment;
    // end of A//
    
    wire [11:0] DATA_B;
    wire [11:0] DATA_B_SQUARE;
    wire [11:0] DATA_B_TRIANGLE;
    wire [11:0] DATA_B_SINE;
    wire [11:0] DATA_B_SINE_RECTIFIED;
    
    wire triangle_LED0_B, triangle_LED1_B, triangle_LED2_B;
    wire sine_LED0_B, sine_LED1_B, sine_LED2_B;
    wire square_LED0_B, square_LED1_B, square_LED2_B;
    
    wire[1:0] selection_waveform_B;
    //end of B//
    
    PB_CLOCK PB_clock (MHZ100_CLOCK, Z_PB_clock);
    PB Five_PB (Z_PB_clock, PB, Z_PB_middle, Z_PB_up, Z_PB_left, Z_PB_right, Z_PB_down);
    
    HALF_CLOCK u0(MHZ100_CLOCK, a);
    DAC_CLOCK u1(MHZ100_CLOCK, b);
    SLOW_CLOCK u2 (MHZ100_CLOCK, c);

    //DATA_A//
    SQUARE_FREQUENCY generate_A_square_frequency (MHZ100_CLOCK, c, Z_PB_left, Z_PB_right, SW[6], SW[7], SW[9], SW[10], SW[11], SW[12], SW[13], selection_waveform, d, square_LED0, square_LED1, square_LED2, square_frequency_7segment);
    SQUARE_WAVE generate_A_square_waveform (d, c, Z_PB_up, Z_PB_down, Z_PB_middle, SW[0], SW[1], SW[2], SW[3], SW[4], SW[5], SW[6], SW[7], SW[11], SW[12], SW[13], selection_waveform, DATA_A_SQUARE, square_data_high_7segment, square_data_low_7segment, square_data_both_7segment, square_offset_7segment, square_dutycycle_7segment);
    
    TRIANGLE_FREQUENCY generate_A_triangle_frequency (MHZ100_CLOCK, c, Z_PB_left, Z_PB_right, SW[6], SW[7], SW[9], SW[10], SW[11], SW[12], SW[13], selection_waveform, e, triangle_LED0, triangle_LED1, triangle_LED2, triangle_frequency_7segment);
    TRIANGLE_WAVE generate_A_triangle_waveform (e, c, Z_PB_up, Z_PB_down, Z_PB_middle, SW[0], SW[1], SW[2], SW[3], SW[4], SW[6], SW[7], SW[8], SW[11], SW[12], SW[13], selection_waveform, DATA_A_TRIANGLE, triangle_data_high_7segment, triangle_data_low_7segment, triangle_data_both_7segment, triangle_offset_7segment);
    
    SINE_FREQUENCY generate_A_sine_frequency (MHZ100_CLOCK, c, Z_PB_left, Z_PB_right, SW[6], SW[7], SW[9], SW[10], SW[11], SW[12], SW[13], selection_waveform, f, sine_LED0, sine_LED1, sine_LED2, sine_frequency_7segment);
    SINE_WAVE generate_A_sine_waveform(f, c, Z_PB_up, Z_PB_down, Z_PB_middle, SW[0], SW[1], SW[2], SW[3], SW[4], SW[6], SW[7], SW[11], SW[12], SW[13], selection_waveform, DATA_A_SINE, sine_data_high_7segment, sine_data_low_7segment, sine_data_both_7segment, sine_offset_7segment);
    SINE_WAVE_RECTIFIED generate_A_sine_waveform_rectified(f, c, Z_PB_up, Z_PB_down, Z_PB_middle, SW[0], SW[1], SW[2], SW[3], SW[4], SW[6], SW[7], SW[8], SW[11], SW[12], SW[13], selection_waveform, DATA_A_SINE_RECTIFIED, rectifed_sine_data_high_7segment, rectifed_sine_data_low_7segment, rectifed_sine_data_both_7segment, rectifed_sine_offset_7segment);
       
    mux_2_to_4 select_waveform (c, Z_PB_up, Z_PB_down, SW[6], SW[7], SW[14], DATA_A_SQUARE, DATA_A_TRIANGLE, DATA_A_SINE, DATA_A_SINE_RECTIFIED, DATA_A, selection_waveform);
    mux_2_to_4_LED mHz_LED(c, Z_PB_up, Z_PB_down, SW[6], SW[7], SW[14], square_LED0, triangle_LED0, sine_LED0, sine_LED0, LED[0]);    //mHz LED
    mux_2_to_4_LED Hz_LED(c, Z_PB_up, Z_PB_down, SW[6], SW[7], SW[14], square_LED1, triangle_LED1, sine_LED1, sine_LED1, LED[1]);    //Hz LED
    mux_2_to_4_LED kHz_LED(c, Z_PB_up, Z_PB_down, SW[6], SW[7], SW[14], square_LED2, triangle_LED2, sine_LED2, sine_LED2, LED[2]);    //KHz LED
    //end of DATA_A//
    
    //DATA_B//
    SQUARE_FREQUENCY_B generate_B_square_frequency (MHZ100_CLOCK, c, Z_PB_left, Z_PB_right, SW[6], SW[7], SW[9], SW[10], SW[11], SW[12], SW[13], selection_waveform_B, g, square_LED0_B, square_LED1_B, square_LED2_B);
    SQUARE_WAVE_B generate_B_square_waveform (g, c, Z_PB_up, Z_PB_down, Z_PB_middle, SW[0], SW[1], SW[2], SW[3], SW[4], SW[5], SW[6], SW[7], SW[11], SW[12], SW[13], selection_waveform_B, DATA_B_SQUARE);
    
    TRIANGLE_FREQUENCY_B generate_B_triangle_frequency (MHZ100_CLOCK, c, Z_PB_left, Z_PB_right, SW[6], SW[7], SW[9], SW[10], SW[11], SW[12], SW[13], selection_waveform_B, h, triangle_LED0_B, triangle_LED1_B, triangle_LED2_B);
    TRIANGLE_WAVE_B generate_B_triangle_waveform (h, c, Z_PB_up, Z_PB_down, Z_PB_middle, SW[0], SW[1], SW[2], SW[3], SW[4], SW[6], SW[7], SW[8], SW[11], SW[12], SW[13], selection_waveform_B, DATA_B_TRIANGLE);

    SINE_FREQUENCY_B generate_B_sine_frequency (MHZ100_CLOCK, c, Z_PB_left, Z_PB_right, SW[6], SW[7], SW[9], SW[10], SW[11], SW[12], SW[13], selection_waveform_B, i, sine_LED0_B, sine_LED1_B, sine_LED2_B);
    SINE_WAVE_B generate_B_sine_waveform(i, c, Z_PB_up, Z_PB_down, Z_PB_middle, SW[0], SW[1], SW[2], SW[3], SW[4], SW[6], SW[7], SW[11], SW[12], SW[13], selection_waveform_B, DATA_B_SINE);
    SINE_WAVE_RECTIFIED_B generate_B_sine_waveform_rectified(i, c, Z_PB_up, Z_PB_down, Z_PB_middle, SW[0], SW[1], SW[2], SW[3], SW[4], SW[6], SW[7], SW[8], SW[11], SW[12], SW[13], selection_waveform_B, DATA_B_SINE_RECTIFIED);

    mux_2_to_4_B select_waveform_B (c, Z_PB_up, Z_PB_down, SW[6], SW[7], SW[14], DATA_B_SQUARE, DATA_B_TRIANGLE, DATA_B_SINE, DATA_B_SINE_RECTIFIED, DATA_B, selection_waveform_B);
    mux_2_to_4_LED_B mHz_LED_B(c, Z_PB_up, Z_PB_down, SW[6], SW[7], SW[14], square_LED0_B, triangle_LED0_B, sine_LED0_B, sine_LED0_B, LED[3]);    //mHz LED
    mux_2_to_4_LED_B Hz_LED_B(c, Z_PB_up, Z_PB_down, SW[6], SW[7], SW[14], square_LED1_B, triangle_LED1_B, sine_LED1_B, sine_LED1_B, LED[4]);    //Hz LED
    mux_2_to_4_LED_B kHz_LED_B(c, Z_PB_up, Z_PB_down, SW[6], SW[7], SW[14], square_LED2_B, triangle_LED2_B, sine_LED2_B, sine_LED2_B, LED[5]);    //KHz LED

    //end of DATA_B//
    
    SEVEN_SEGMENT generate_7_segment(MHZ100_CLOCK, RESET, selection_waveform, selection_waveform_B, square_data_high_7segment, square_data_low_7segment, square_data_both_7segment, square_offset_7segment, square_dutycycle_7segment, triangle_data_high_7segment, triangle_data_low_7segment, triangle_data_both_7segment, triangle_offset_7segment, sine_data_high_7segment, sine_data_low_7segment, sine_data_both_7segment, sine_offset_7segment, rectifed_sine_data_high_7segment, rectifed_sine_data_low_7segment, rectifed_sine_data_both_7segment, rectifed_sine_offset_7segment, square_frequency_7segment, triangle_frequency_7segment, sine_frequency_7segment, SW[0], SW[1], SW[2], SW[3], SW[4], SW[5], SW[6], SW[7], A, B, C, D, E, F, G, DP, AN);

    DA2RefComp MY_BASIC_DAC (.CLK(a), .START(b), .RST(RESET), .D1(JA[1]), .D2(JA[2]), .CLK_OUT(JA[3]), .nSYNC(JA[0]), .DATA1(DATA_A), .DATA2(DATA_B), .DONE(LED[15]));
        
endmodule
