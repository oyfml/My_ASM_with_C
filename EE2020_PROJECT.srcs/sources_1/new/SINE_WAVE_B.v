`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.11.2016 20:29:07
// Design Name: 
// Module Name: SINE_WAVE_B
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


module SINE_WAVE_B(
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
    input SW11,
    input SW12,
    input SW13,
    input [1:0] SELECTION_WAVEFORM,
    output [11:0] DATA_A_OUTPUT
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
        if(SELECTION_WAVEFORM == 2 && SW6 == 1 && SW7 == 1)
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
    sine[181] = 2012;
    sine[182] = 1976;
    sine[183] = 1940;
    sine[184] = 1905;
    sine[185] = 1869;
    sine[186] = 1833;
    sine[187] = 1798;
    sine[188] = 1763;
    sine[189] = 1727;
    sine[190] = 1692;
    sine[191] = 1657;
    sine[192] = 1622;
    sine[193] = 1587;
    sine[194] = 1552;
    sine[195] = 1518;
    sine[196] = 1483;
    sine[197] = 1449;
    sine[198] = 1415;
    sine[199] = 1381;
    sine[200] = 1347;
    sine[201] = 1314;
    sine[202] = 1280;
    sine[203] = 1247;
    sine[204] = 1215;
    sine[205] = 1182;
    sine[206] = 1150;
    sine[207] = 1118;
    sine[208] = 1086;
    sine[209] = 1055;
    sine[210] = 1024;
    sine[211] = 993;
    sine[212] = 962;
    sine[213] = 932;
    sine[214] = 903;
    sine[215] = 873;
    sine[216] = 844;
    sine[217] = 815;
    sine[218] = 787;
    sine[219] = 759;
    sine[220] = 731;
    sine[221] = 704;
    sine[222] = 677;
    sine[223] = 651;
    sine[224] = 625;
    sine[225] = 600;
    sine[226] = 575;
    sine[227] = 550;
    sine[228] = 526;
    sine[229] = 502;
    sine[230] = 479;
    sine[231] = 456;
    sine[232] = 434;
    sine[233] = 412;
    sine[234] = 391;
    sine[235] = 370;
    sine[236] = 350;
    sine[237] = 330;
    sine[238] = 311;
    sine[239] = 292;
    sine[240] = 274;
    sine[241] = 257;
    sine[242] = 240;
    sine[243] = 223;
    sine[244] = 207;
    sine[245] = 192;
    sine[246] = 177;
    sine[247] = 163;
    sine[248] = 149;
    sine[249] = 136;
    sine[250] = 123;
    sine[251] = 112;
    sine[252] = 100;
    sine[253] = 89;
    sine[254] = 79;
    sine[255] = 70;
    sine[256] = 61;
    sine[257] = 52;
    sine[258] = 45;
    sine[259] = 38;
    sine[260] = 31;
    sine[261] = 25;
    sine[262] = 20;
    sine[263] = 15;
    sine[264] = 11;
    sine[265] = 8;
    sine[266] = 5;
    sine[267] = 3;
    sine[268] = 1;
    sine[269] = 0;
    sine[270] = 0;
    sine[271] = 0;
    sine[272] = 1;
    sine[273] = 3;
    sine[274] = 5;
    sine[275] = 8;
    sine[276] = 11;
    sine[277] = 15;
    sine[278] = 20;
    sine[279] = 25;
    sine[280] = 31;
    sine[281] = 38;
    sine[282] = 45;
    sine[283] = 52;
    sine[284] = 61;
    sine[285] = 70;
    sine[286] = 79;
    sine[287] = 89;
    sine[288] = 100;
    sine[289] = 112;
    sine[290] = 123;
    sine[291] = 136;
    sine[292] = 149;
    sine[293] = 163;
    sine[294] = 177;
    sine[295] = 192;
    sine[296] = 207;
    sine[297] = 223;
    sine[298] = 240;
    sine[299] = 257;
    sine[300] = 274;
    sine[301] = 292;
    sine[302] = 311;
    sine[303] = 330;
    sine[304] = 350;
    sine[305] = 370;
    sine[306] = 391;
    sine[307] = 412;
    sine[308] = 434;
    sine[309] = 456;
    sine[310] = 479;
    sine[311] = 502;
    sine[312] = 526;
    sine[313] = 550;
    sine[314] = 575;
    sine[315] = 600;
    sine[316] = 625;
    sine[317] = 651;
    sine[318] = 677;
    sine[319] = 704;
    sine[320] = 731;
    sine[321] = 759;
    sine[322] = 787;
    sine[323] = 815;
    sine[324] = 844;
    sine[325] = 873;
    sine[326] = 903;
    sine[327] = 932;
    sine[328] = 962;
    sine[329] = 993;
    sine[330] = 1024;
    sine[331] = 1055;
    sine[332] = 1086;
    sine[333] = 1118;
    sine[334] = 1150;
    sine[335] = 1182;
    sine[336] = 1215;
    sine[337] = 1247;
    sine[338] = 1280;
    sine[339] = 1314;
    sine[340] = 1347;
    sine[341] = 1381;
    sine[342] = 1415;
    sine[343] = 1449;
    sine[344] = 1483;
    sine[345] = 1518;
    sine[346] = 1552;
    sine[347] = 1587;
    sine[348] = 1622;
    sine[349] = 1657;
    sine[350] = 1692;
    sine[351] = 1727;
    sine[352] = 1763;
    sine[353] = 1798;
    sine[354] = 1833;
    sine[355] = 1869;
    sine[356] = 1905;
    sine[357] = 1940;
    sine[358] = 1976;
    sine[359] = 2012;
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
        
        DATA_A_Z = sine[count];
        count = count + 1;
        if(count == 359)
        begin
            count = 0;
        end
    end
    
    assign DATA_A_OUTPUT = ((DATA_A_Z * (DATA_A_HIGH-DATA_A_LOW))/4095 + DATA_A_LOW) + offset;
    
endmodule
