`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2016 09:11:10
// Design Name: 
// Module Name: SEVEN_SEGMENT
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


module SEVEN_SEGMENT(
    input CLOCK,
    input RESET,
    input [1:0] SELECTION_WAVEFORM,
    input [1:0] SELECTION_WAVEFORM_B,
    input [11:0] REC_DATA_A_HIGH,
    input [11:0] REC_DATA_A_LOW,
    input [11:0] REC_DATA_A_BOTH,
    input [11:0] REC_AMPLITUDE_OFFSET,
    input [11:0] REC_DUTY_CYCLE,
    input [11:0] TRI_DATA_A_HIGH,
    input [11:0] TRI_DATA_A_LOW,
    input [11:0] TRI_DATA_A_BOTH,
    input [11:0] TRI_AMPLITUDE_OFFSET,
    input [11:0] SINE_DATA_A_HIGH,
    input [11:0] SINE_DATA_A_LOW,
    input [11:0] SINE_DATA_A_BOTH,
    input [11:0] SINE_AMPLITUDE_OFFSET,
    input [11:0] RECTIFED_SINE_DATA_A_HIGH,
    input [11:0] RECTIFED_SINE_DATA_A_LOW,
    input [11:0] RECTIFED_SINE_DATA_A_BOTH,
    input [11:0] RECTIFED_SINE_AMPLITUDE_OFFSET,
    input [13:0] REC_FREQUENCY,
    input [13:0] TRI_FREQUENCY,
    input [13:0] SINE_FREQUENCY,
    input SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7,
    output A, B, C, D, E, F, G, 
    output reg DP,
    output [3:0] AN
    );
    
    reg [5:0] in0;
    reg [5:0] in1;
    reg [5:0] in2;
    reg [5:0] in3;
    
    localparam N = 18;
    
    reg [N-1:0] count;
    
    always @ (posedge CLOCK or posedge RESET) begin
        if (RESET)
            count <= 0;
        else
            count <= count + 1;
    end
    
    reg [6:0] sseg;
    reg [3:0] an_temp;
    
    always @ (*) begin
        //selection A//
        if(SW6 == 0 && SW7 == 0)
        begin
        if(SW2 == 1 && SW3 == 1 && SW4 == 1 && SELECTION_WAVEFORM == 0)
        begin
            in0 = ((REC_AMPLITUDE_OFFSET*1000/1204)) %10;
            in1 = ((REC_AMPLITUDE_OFFSET*1000/1204)) /10 %10;
            in2 = ((REC_AMPLITUDE_OFFSET*1000/1204)) /100 %10;
            in3 = ((REC_AMPLITUDE_OFFSET*1000/1204)) /1000;
        end
        else if(SW2 == 1 && SW3 == 0 && SW4 == 0 && SELECTION_WAVEFORM == 0)
        begin
            in0 = ((REC_DATA_A_BOTH*1000/1204)) %10;
            in1 = ((REC_DATA_A_BOTH*1000/1204)) /10 %10;
            in2 = ((REC_DATA_A_BOTH*1000/1204)) /100 %10;
            in3 = ((REC_DATA_A_BOTH*1000/1204)) /1000;
        end
        else if(SW2 == 0 && SW3 == 1 && SW4 == 0 && SELECTION_WAVEFORM == 0)
        begin
            in0 = ((REC_DATA_A_HIGH*1000/1204)) %10;
            in1 = ((REC_DATA_A_HIGH*1000/1204)) /10 %10;
            in2 = ((REC_DATA_A_HIGH*1000/1204)) /100 %10;
            in3 = ((REC_DATA_A_HIGH*1000/1204)) /1000;
        end
        else if(SW2 == 0 && SW3 == 0 && SW4 == 1 && SELECTION_WAVEFORM == 0)
        begin
            in0 = ((REC_DATA_A_LOW*1000/1204)) %10;
            in1 = ((REC_DATA_A_LOW*1000/1204)) /10 %10;
            in2 = ((REC_DATA_A_LOW*1000/1204)) /100 %10;
            in3 = ((REC_DATA_A_LOW*1000/1204)) /1000;
        end
        else if(SW5 == 1 && SELECTION_WAVEFORM == 0)
        begin
            in0 = REC_DUTY_CYCLE %10;
            in1 = REC_DUTY_CYCLE %100/10;
            in2 = REC_DUTY_CYCLE /100;
            in3 = 10;
        end
        else if(SW2 == 1 && SW3 == 1 && SW4 == 1 && SELECTION_WAVEFORM == 1)
        begin
            in0 = ((TRI_AMPLITUDE_OFFSET*1000/1204)) %10;
            in1 = ((TRI_AMPLITUDE_OFFSET*1000/1204)) /10 %10;
            in2 = ((TRI_AMPLITUDE_OFFSET*1000/1204)) /100 %10;
            in3 = ((TRI_AMPLITUDE_OFFSET*1000/1204)) /1000;
        end
        else if(SW2 == 1 && SW3 == 0 && SW4 == 0 && SELECTION_WAVEFORM == 1)
        begin
            in0 = ((TRI_DATA_A_BOTH*1000/1204)) %10;
            in1 = ((TRI_DATA_A_BOTH*1000/1204)) /10 %10;
            in2 = ((TRI_DATA_A_BOTH*1000/1204)) /100 %10;
            in3 = ((TRI_DATA_A_BOTH*1000/1204)) /1000;
        end
        else if(SW2 == 0 && SW3 == 1 && SW4 == 0 && SELECTION_WAVEFORM == 1)
        begin
            in0 = ((TRI_DATA_A_HIGH*1000/1204)) %10;
            in1 = ((TRI_DATA_A_HIGH*1000/1204)) /10 %10;
            in2 = ((TRI_DATA_A_HIGH*1000/1204)) /100 %10;
            in3 = ((TRI_DATA_A_HIGH*1000/1204)) /1000;
        end
        else if(SW2 == 0 && SW3 == 0 && SW4 == 1 && SELECTION_WAVEFORM == 1)
        begin
            in0 = ((TRI_DATA_A_LOW*1000/1204)) %10;
            in1 = ((TRI_DATA_A_LOW*1000/1204)) /10 %10;
            in2 = ((TRI_DATA_A_LOW*1000/1204)) /100 %10;
            in3 = ((TRI_DATA_A_LOW*1000/1204)) /1000;
        end
        else if(SW2 == 1 && SW3 == 1 && SW4 == 1 && SELECTION_WAVEFORM == 2)
        begin
            in0 = ((SINE_AMPLITUDE_OFFSET*1000/1204)) %10;
            in1 = ((SINE_AMPLITUDE_OFFSET*1000/1204)) /10 %10;
            in2 = ((SINE_AMPLITUDE_OFFSET*1000/1204)) /100 %10;
            in3 = ((SINE_AMPLITUDE_OFFSET*1000/1204)) /1000;
        end
        else if(SW2 == 1 && SW3 == 0 && SW4 == 0 && SELECTION_WAVEFORM == 2)
        begin
            in0 = ((SINE_DATA_A_BOTH*1000/1204)) %10;
            in1 = ((SINE_DATA_A_BOTH*1000/1204)) /10 %10;
            in2 = ((SINE_DATA_A_BOTH*1000/1204)) /100 %10;
            in3 = ((SINE_DATA_A_BOTH*1000/1204)) /1000;
        end
        else if(SW2 == 0 && SW3 == 1 && SW4 == 0 && SELECTION_WAVEFORM == 2)
        begin
            in0 = ((SINE_DATA_A_HIGH*1000/1204)) %10;
            in1 = ((SINE_DATA_A_HIGH*1000/1204)) /10 %10;
            in2 = ((SINE_DATA_A_HIGH*1000/1204)) /100 %10;
            in3 = ((SINE_DATA_A_HIGH*1000/1204)) /1000;
        end
        else if(SW2 == 0 && SW3 == 0 && SW4 == 1 && SELECTION_WAVEFORM == 2)
        begin
            in0 = ((SINE_DATA_A_LOW*1000/1204)) %10;
            in1 = ((SINE_DATA_A_LOW*1000/1204)) /10 %10;
            in2 = ((SINE_DATA_A_LOW*1000/1204)) /100 %10;
            in3 = ((SINE_DATA_A_LOW*1000/1204)) /1000;
        end
        else if(SW2 == 1 && SW3 == 1 && SW4 == 1 && SELECTION_WAVEFORM == 3)
        begin
            in0 = ((RECTIFED_SINE_AMPLITUDE_OFFSET*1000/1204)) %10;
            in1 = ((RECTIFED_SINE_AMPLITUDE_OFFSET*1000/1204)) /10 %10;
            in2 = ((RECTIFED_SINE_AMPLITUDE_OFFSET*1000/1204)) /100 %10;
            in3 = ((RECTIFED_SINE_AMPLITUDE_OFFSET*1000/1204)) /1000;
        end
        else if(SW2 == 1 && SW3 == 0 && SW4 == 0 && SELECTION_WAVEFORM == 3)
        begin
            in0 = ((RECTIFED_SINE_DATA_A_BOTH*1000/1204)) %10;
            in1 = ((RECTIFED_SINE_DATA_A_BOTH*1000/1204)) /10 %10;
            in2 = ((RECTIFED_SINE_DATA_A_BOTH*1000/1204)) /100 %10;
            in3 = ((RECTIFED_SINE_DATA_A_BOTH*1000/1204)) /1000;
        end
        else if(SW2 == 0 && SW3 == 1 && SW4 == 0 && SELECTION_WAVEFORM == 3)
        begin
            in0 = ((RECTIFED_SINE_DATA_A_HIGH*1000/1204)) %10;
            in1 = ((RECTIFED_SINE_DATA_A_HIGH*1000/1204)) /10 %10;
            in2 = ((RECTIFED_SINE_DATA_A_HIGH*1000/1204)) /100 %10;
            in3 = ((RECTIFED_SINE_DATA_A_HIGH*1000/1204)) /1000;
        end
        else if(SW2 == 0 && SW3 == 0 && SW4 == 1 && SELECTION_WAVEFORM == 3)
        begin
            in0 = ((RECTIFED_SINE_DATA_A_LOW*1000/1204)) %10;
            in1 = ((RECTIFED_SINE_DATA_A_LOW*1000/1204)) /10 %10;
            in2 = ((RECTIFED_SINE_DATA_A_LOW*1000/1204)) /100 %10;
            in3 = ((RECTIFED_SINE_DATA_A_LOW*1000/1204)) /1000;
        end
        else if(SW0 == 1 && SW1 == 1 && SELECTION_WAVEFORM == 0)
        begin
            if(REC_FREQUENCY >= 9999)
            begin
                in0 = 9;
                in1 = 9;
                in2 = 9;
                in3 = 9;
            end
            else
            begin
                in0 = REC_FREQUENCY %10;
                in1 = REC_FREQUENCY /10 %10;
                in2 = REC_FREQUENCY /100 %10;
                in3 = REC_FREQUENCY /1000;
            end
        end
        else if(SW0 == 1 && SW1 == 1 && SELECTION_WAVEFORM == 1)
        begin
            if(TRI_FREQUENCY >= 9999)
            begin
                in0 = 9;
                in1 = 9;
                in2 = 9;
                in3 = 9;
            end
            else
            begin
                in0 = TRI_FREQUENCY %10;
                in1 = TRI_FREQUENCY /10 %10;
                in2 = TRI_FREQUENCY /100 %10;
                in3 = TRI_FREQUENCY /1000;
            end
        end
        else if(SW0 == 1 && SW1 == 1 && (SELECTION_WAVEFORM == 2 || SELECTION_WAVEFORM == 3))
        begin
            if(SINE_FREQUENCY >= 9999)
            begin
                in0 = 9;
                in1 = 9;
                in2 = 9;
                in3 = 9;
            end
            else
            begin
                in0 = SINE_FREQUENCY %10;
                in1 = SINE_FREQUENCY /10 %10;
                in2 = SINE_FREQUENCY /100 %10;
                in3 = SINE_FREQUENCY /1000;
            end
        end
        else if(SELECTION_WAVEFORM == 0)
        begin
            in0 = 52;
            in1 = 51;
            in2 = 50;
            in3 = 10;
        end
        else if(SELECTION_WAVEFORM == 1)
        begin
            in0 = 55;
            in1 = 54;
            in2 = 53;
            in3 = 10;
        end
        else if(SELECTION_WAVEFORM == 2)
        begin
            in0 = 58;
            in1 = 57;
            in2 = 56;
            in3 = 10;
        end
        else if(SELECTION_WAVEFORM == 3)
        begin
            in0 = 58;
            in1 = 57;
            in2 = 56;
            in3 = 50;
        end
        end
        else
        begin
            in0 = 10;
            in1 = 10;
            in2 = 10;
            in3 = 10;
        end
        //end of selection A//
        
        case(count[N-1:N-2])
            
            2'b00:
            begin
                sseg = in0;
                an_temp = 4'b1110;
                DP = 1'b1;
            end
            
            2'b01:
            begin
                sseg = in1;
                an_temp = 4'b1101;
                DP = 1'b1;
            end
            
            2'b10:
            begin
                sseg = in2;
                an_temp = 4'b1011;
                DP = 1'b1;
            end
            
            2'b11:
            begin
                sseg = in3;
                an_temp = 4'b0111;
                if((SW2 == 1 && SW3 == 1 && SW4 == 1) || (SW2 == 1 && SW3 == 0 && SW4 == 0) || (SW2 == 0 && SW3 == 1 && SW4 == 0) ||(SW2 == 0 && SW3 == 0 && SW4 == 1))
                DP = 1'b0;
                else
                DP = 1'b1;
            end
        endcase
    end
    
    assign AN = an_temp;
    
    reg [6:0]sseg_temp;
    
    always @ (*) begin
        case(sseg)
            4'd0 : sseg_temp = 7'b1000000;
            4'd1 : sseg_temp = 7'b1111001;
            4'd2 : sseg_temp = 7'b0100100;
            4'd3 : sseg_temp = 7'b0110000;
            4'd4 : sseg_temp = 7'b0011001;
            4'd5 : sseg_temp = 7'b0010010;
            4'd6 : sseg_temp = 7'b0000010;
            4'd7 : sseg_temp = 7'b1111000;
            4'd8 : sseg_temp = 7'b0000000;
            4'd9 : sseg_temp = 7'b0010000;
            6'd50 : sseg_temp = 7'b1001110;     //r
            6'd51 : sseg_temp = 7'b0000110;     //e
            6'd52 : sseg_temp = 7'b1000110;     //c
            6'd53 : sseg_temp = 7'b0000111;     //t
            6'd54 : sseg_temp = 7'b0101111;     //r
            6'd55 : sseg_temp = 7'b1101111;     //i
            6'd56 : sseg_temp = 7'b0010010;     //s
            6'd57 : sseg_temp = 7'b1111001;     //i
            6'd58 : sseg_temp = 7'b1001000;     //n
            default: sseg_temp = 7'b1111111;
        endcase
    end
    
    assign {G, F, E, D, C, B, A} = sseg_temp;

    
endmodule
