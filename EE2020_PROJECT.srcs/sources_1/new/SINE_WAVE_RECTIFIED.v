`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.11.2016 09:39:34
// Design Name: 
// Module Name: SINE_WAVE_RECTIFIED
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


module SINE_WAVE_RECTIFIED(
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
    output [11:0] DATA_A_OUTPUT,
    output [11:0] DATA_A_HIGH_OUTPUT,
    output [11:0] DATA_A_LOW_OUTPUT,
    output [11:0] DATA_A_BOTH_OUTPUT,
    output [11:0] AMPLITUDE_OFFSET_OUTPUT
    );
    
        
    reg [8:0] count;
    reg [11:0] sine[0:359];
    reg [11:0] DATA_A_Z = 12'h000;
    reg [11:0] DATA_A_HIGH = 12'hFFF; 
    reg [11:0] DATA_A_LOW = 12'h000;
    reg [11:0] amplitude_multiply = 12'h001;
    reg [11:0] offset = 12'h000;
    reg [11:0] offset_multiply = 12'h001;
    
    reg middle_press = 0;
    reg middle_press_reset = 0;
    reg up_press = 0;
    reg up_press_reset = 0;
    reg down_press = 0;
    reg down_press_reset = 0;
    
    //checking for up & down & middle PB //
    always @(posedge SLOW_CLOCK) begin
        if(SELECTION_WAVEFORM == 3 && SW6 == 0 && SW7 == 0)
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
    
    initial begin
    sine[0] = 2048;
    sine[1] = 2083;
    sine[2] = 2119;
    sine[3] = 2155;
    sine[4] = 2190;
    sine[5] = 2226;
    sine[6] = 2262;
    sine[7] = 2297;
    sine[8] = 2332;
    sine[9] = 2368;
    sine[10] = 2403;
    sine[11] = 2438;
    sine[12] = 2473;
    sine[13] = 2508;
    sine[14] = 2543;
    sine[15] = 2577;
    sine[16] = 2612;
    sine[17] = 2646;
    sine[18] = 2680;
    sine[19] = 2714;
    sine[20] = 2748;
    sine[21] = 2781;
    sine[22] = 2815;
    sine[23] = 2848;
    sine[24] = 2880;
    sine[25] = 2913;
    sine[26] = 2945;
    sine[27] = 2977;
    sine[28] = 3009;
    sine[29] = 3040;
    sine[30] = 3071;
    sine[31] = 3102;
    sine[32] = 3133;
    sine[33] = 3163;
    sine[34] = 3192;
    sine[35] = 3222;
    sine[36] = 3251;
    sine[37] = 3280;
    sine[38] = 3308;
    sine[39] = 3336;
    sine[40] = 3364;
    sine[41] = 3391;
    sine[42] = 3418;
    sine[43] = 3444;
    sine[44] = 3470;
    sine[45] = 3495;
    sine[46] = 3520;
    sine[47] = 3545;
    sine[48] = 3569;
    sine[49] = 3593;
    sine[50] = 3616;
    sine[51] = 3639;
    sine[52] = 3661;
    sine[53] = 3683;
    sine[54] = 3704;
    sine[55] = 3725;
    sine[56] = 3745;
    sine[57] = 3765;
    sine[58] = 3784;
    sine[59] = 3803;
    sine[60] = 3821;
    sine[61] = 3838;
    sine[62] = 3855;
    sine[63] = 3872;
    sine[64] = 3888;
    sine[65] = 3903;
    sine[66] = 3918;
    sine[67] = 3932;
    sine[68] = 3946;
    sine[69] = 3959;
    sine[70] = 3972;
    sine[71] = 3983;
    sine[72] = 3995;
    sine[73] = 4006;
    sine[74] = 4016;
    sine[75] = 4025;
    sine[76] = 4034;
    sine[77] = 4043;
    sine[78] = 4050;
    sine[79] = 4057;
    sine[80] = 4064;
    sine[81] = 4070;
    sine[82] = 4075;
    sine[83] = 4080;
    sine[84] = 4084;
    sine[85] = 4087;
    sine[86] = 4090;
    sine[87] = 4092;
    sine[88] = 4094;
    sine[89] = 4095;
    sine[90] = 4095;
    sine[91] = 4095;
    sine[92] = 4094;
    sine[93] = 4092;
    sine[94] = 4090;
    sine[95] = 4087;
    sine[96] = 4084;
    sine[97] = 4080;
    sine[98] = 4075;
    sine[99] = 4070;
    sine[100] = 4064;
    sine[101] = 4057;
    sine[102] = 4050;
    sine[103] = 4043;
    sine[104] = 4034;
    sine[105] = 4025;
    sine[106] = 4016;
    sine[107] = 4006;
    sine[108] = 3995;
    sine[109] = 3983;
    sine[110] = 3972;
    sine[111] = 3959;
    sine[112] = 3946;
    sine[113] = 3932;
    sine[114] = 3918;
    sine[115] = 3903;
    sine[116] = 3888;
    sine[117] = 3872;
    sine[118] = 3855;
    sine[119] = 3838;
    sine[120] = 3821;
    sine[121] = 3803;
    sine[122] = 3784;
    sine[123] = 3765;
    sine[124] = 3745;
    sine[125] = 3725;
    sine[126] = 3704;
    sine[127] = 3683;
    sine[128] = 3661;
    sine[129] = 3639;
    sine[130] = 3616;
    sine[131] = 3593;
    sine[132] = 3569;
    sine[133] = 3545;
    sine[134] = 3520;
    sine[135] = 3495;
    sine[136] = 3470;
    sine[137] = 3444;
    sine[138] = 3418;
    sine[139] = 3391;
    sine[140] = 3364;
    sine[141] = 3336;
    sine[142] = 3308;
    sine[143] = 3280;
    sine[144] = 3251;
    sine[145] = 3222;
    sine[146] = 3192;
    sine[147] = 3163;
    sine[148] = 3133;
    sine[149] = 3102;
    sine[150] = 3071;
    sine[151] = 3040;
    sine[152] = 3009;
    sine[153] = 2977;
    sine[154] = 2945;
    sine[155] = 2913;
    sine[156] = 2880;
    sine[157] = 2848;
    sine[158] = 2815;
    sine[159] = 2781;
    sine[160] = 2748;
    sine[161] = 2714;
    sine[162] = 2680;
    sine[163] = 2646;
    sine[164] = 2612;
    sine[165] = 2577;
    sine[166] = 2543;
    sine[167] = 2508;
    sine[168] = 2473;
    sine[169] = 2438;
    sine[170] = 2403;
    sine[171] = 2368;
    sine[172] = 2332;
    sine[173] = 2297;
    sine[174] = 2262;
    sine[175] = 2226;
    sine[176] = 2190;
    sine[177] = 2155;
    sine[178] = 2119;
    sine[179] = 2083;
    sine[180] = 2048;
    sine[181] = 2048;
    sine[182] = 2048;
    sine[183] = 2048;
    sine[184] = 2048;
    sine[185] = 2048;
    sine[186] = 2048;
    sine[187] = 2048;
    sine[188] = 2048;
    sine[189] = 2048;
    sine[190] = 2048;
    sine[191] = 2048;
    sine[192] = 2048;
    sine[193] = 2048;
    sine[194] = 2048;
    sine[195] = 2048;
    sine[196] = 2048;
    sine[197] = 2048;
    sine[198] = 2048;
    sine[199] = 2048;
    sine[200] = 2048;
    sine[201] = 2048;
    sine[202] = 2048;
    sine[203] = 2048;
    sine[204] = 2048;
    sine[205] = 2048;
    sine[206] = 2048;
    sine[207] = 2048;
    sine[208] = 2048;
    sine[209] = 2048;
    sine[210] = 2048;
    sine[211] = 2048;
    sine[212] = 2048;
    sine[213] = 2048;
    sine[214] = 2048;
    sine[215] = 2048;
    sine[216] = 2048;
    sine[217] = 2048;
    sine[218] = 2048;
    sine[219] = 2048;
    sine[220] = 2048;
    sine[221] = 2048;
    sine[222] = 2048;
    sine[223] = 2048;
    sine[224] = 2048;
    sine[225] = 2048;
    sine[226] = 2048;
    sine[227] = 2048;
    sine[228] = 2048;
    sine[229] = 2048;
    sine[230] = 2048;
    sine[231] = 2048;
    sine[232] = 2048;
    sine[233] = 2048;
    sine[234] = 2048;
    sine[235] = 2048;
    sine[236] = 2048;
    sine[237] = 2048;
    sine[238] = 2048;
    sine[239] = 2048;
    sine[240] = 2048;
    sine[241] = 2048;
    sine[242] = 2048;
    sine[243] = 2048;
    sine[244] = 2048;
    sine[245] = 2048;
    sine[246] = 2048;
    sine[247] = 2048;
    sine[248] = 2048;
    sine[249] = 2048;
    sine[250] = 2048;
    sine[251] = 2048;
    sine[252] = 2048;
    sine[253] = 2048;
    sine[254] = 2048;
    sine[255] = 2048;
    sine[256] = 2048;
    sine[257] = 2048;
    sine[258] = 2048;
    sine[259] = 2048;
    sine[260] = 2048;
    sine[261] = 2048;
    sine[262] = 2048;
    sine[263] = 2048;
    sine[264] = 2048;
    sine[265] = 2048;
    sine[266] = 2048;
    sine[267] = 2048;
    sine[268] = 2048;
    sine[269] = 2048;
    sine[270] = 2048;
    sine[271] = 2048;
    sine[272] = 2048;
    sine[273] = 2048;
    sine[274] = 2048;
    sine[275] = 2048;
    sine[276] = 2048;
    sine[277] = 2048;
    sine[278] = 2048;
    sine[279] = 2048;
    sine[280] = 2048;
    sine[281] = 2048;
    sine[282] = 2048;
    sine[283] = 2048;
    sine[284] = 2048;
    sine[285] = 2048;
    sine[286] = 2048;
    sine[287] = 2048;
    sine[288] = 2048;
    sine[289] = 2048;
    sine[290] = 2048;
    sine[291] = 2048;
    sine[292] = 2048;
    sine[293] = 2048;
    sine[294] = 2048;
    sine[295] = 2048;
    sine[296] = 2048;
    sine[297] = 2048;
    sine[298] = 2048;
    sine[299] = 2048;
    sine[300] = 2048;
    sine[301] = 2048;
    sine[302] = 2048;
    sine[303] = 2048;
    sine[304] = 2048;
    sine[305] = 2048;
    sine[306] = 2048;
    sine[307] = 2048;
    sine[308] = 2048;
    sine[309] = 2048;
    sine[310] = 2048;
    sine[311] = 2048;
    sine[312] = 2048;
    sine[313] = 2048;
    sine[314] = 2048;
    sine[315] = 2048;
    sine[316] = 2048;
    sine[317] = 2048;
    sine[318] = 2048;
    sine[319] = 2048;
    sine[320] = 2048;
    sine[321] = 2048;
    sine[322] = 2048;
    sine[323] = 2048;
    sine[324] = 2048;
    sine[325] = 2048;
    sine[326] = 2048;
    sine[327] = 2048;
    sine[328] = 2048;
    sine[329] = 2048;
    sine[330] = 2048;
    sine[331] = 2048;
    sine[332] = 2048;
    sine[333] = 2048;
    sine[334] = 2048;
    sine[335] = 2048;
    sine[336] = 2048;
    sine[337] = 2048;
    sine[338] = 2048;
    sine[339] = 2048;
    sine[340] = 2048;
    sine[341] = 2048;
    sine[342] = 2048;
    sine[343] = 2048;
    sine[344] = 2048;
    sine[345] = 2048;
    sine[346] = 2048;
    sine[347] = 2048;
    sine[348] = 2048;
    sine[349] = 2048;
    sine[350] = 2048;
    sine[351] = 2048;
    sine[352] = 2048;
    sine[353] = 2048;
    sine[354] = 2048;
    sine[355] = 2048;
    sine[356] = 2048;
    sine[357] = 2048;
    sine[358] = 2048;
    sine[359] = 2048;
    end
    
    always @ (posedge CLOCK)
    begin
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
        
        DATA_A_Z = (sine[count] - 2048)*2;
        count = count + 1;
        if(count == 179 && SW8 == 0)
        begin
            count = 0;
        end
        else if(count == 359 && SW8 == 1)
        begin
            count = 0;
        end
    end
    
    assign DATA_A_OUTPUT = ((DATA_A_Z * (DATA_A_HIGH-DATA_A_LOW))/4095 + DATA_A_LOW) + offset;
    assign DATA_A_HIGH_OUTPUT = DATA_A_HIGH + offset;
    assign DATA_A_LOW_OUTPUT = DATA_A_LOW + offset;
    assign DATA_A_BOTH_OUTPUT = (DATA_A_HIGH - DATA_A_LOW);
    assign AMPLITUDE_OFFSET_OUTPUT = offset;
endmodule
