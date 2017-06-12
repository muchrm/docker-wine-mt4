

#property indicator_separate_window
#property indicator_buffers 2
#property indicator_color1 Red
#property indicator_color2 Yellow
#property indicator_minimum 0
#property indicator_maximum 100



extern int interval = 12;
double dNocRange = 0.012;
extern int MA = 5;
int nOutLag = 2;

int nLayers = 3;
int arrNeurons[3] = { 17, 5, 1 };
int nNumOfLags = 17;
int arrLags[17] = 
    { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };

double arrWeights_0[305];
double arrWeights_1[90];
double arrWeights_2[6];

extern int BuyLevel = 54;
extern int SellLevel = 74;


double arrOutput_0[17];
double arrOutput_1[5];
double dNnOutput;

double arrPattern[18];

int nRemoveFirst = 200;
double dE = 2.7182818;

// indicator buffers
double arrNocBuffer[];
double arrNnBuffer[];

int nExtCountedBars = 0;

////////////////////////
int init()
{
    
    // Layer: 0
arrWeights_0[0] = 0.376436;
arrWeights_0[1] = 0.690657;
arrWeights_0[2] = 0.512335;
arrWeights_0[3] = 0.786179;
arrWeights_0[4] = 0.671377;
arrWeights_0[5] = 0.614279;
arrWeights_0[6] = 0.539750;
arrWeights_0[7] = 0.820380;
arrWeights_0[8] = 0.750566;
arrWeights_0[9] = 0.707890;
arrWeights_0[10] = 0.396094;
arrWeights_0[11] = 0.725720;
arrWeights_0[12] = 0.555349;
arrWeights_0[13] = 0.395257;
arrWeights_0[14] = 0.227280;
arrWeights_0[15] = 0.128274;
arrWeights_0[16] = 0.289072;
arrWeights_0[17] = 0.387067;
arrWeights_0[18] = 0.662450;
arrWeights_0[19] = 1.019812;
arrWeights_0[20] = 0.761206;
arrWeights_0[21] = 0.984280;
arrWeights_0[22] = 0.878235;
arrWeights_0[23] = 0.829384;
arrWeights_0[24] = 0.786234;
arrWeights_0[25] = 1.189799;
arrWeights_0[26] = 1.112219;
arrWeights_0[27] = 1.069424;
arrWeights_0[28] = 0.640762;
arrWeights_0[29] = 0.730670;
arrWeights_0[30] = 0.067006;
arrWeights_0[31] = -0.320953;
arrWeights_0[32] = -0.600880;
arrWeights_0[33] = -0.371686;
arrWeights_0[34] = 0.261142;
arrWeights_0[35] = 0.063323;
arrWeights_0[36] = 0.413053;
arrWeights_0[37] = 0.737687;
arrWeights_0[38] = 0.555759;
arrWeights_0[39] = 0.815068;
arrWeights_0[40] = 0.692078;
arrWeights_0[41] = 0.630406;
arrWeights_0[42] = 0.556191;
arrWeights_0[43] = 0.846380;
arrWeights_0[44] = 0.763236;
arrWeights_0[45] = 0.715549;
arrWeights_0[46] = 0.390297;
arrWeights_0[47] = 0.705948;
arrWeights_0[48] = 0.482014;
arrWeights_0[49] = 0.291501;
arrWeights_0[50] = 0.101741;
arrWeights_0[51] = 0.048724;
arrWeights_0[52] = 0.280508;
arrWeights_0[53] = 0.428389;
arrWeights_0[54] = -6.065296;
arrWeights_0[55] = 0.559039;
arrWeights_0[56] = 1.732407;
arrWeights_0[57] = 2.446417;
arrWeights_0[58] = 2.226664;
arrWeights_0[59] = 1.043498;
arrWeights_0[60] = -0.892194;
arrWeights_0[61] = 0.538670;
arrWeights_0[62] = 1.696599;
arrWeights_0[63] = 2.895421;
arrWeights_0[64] = 1.936742;
arrWeights_0[65] = 0.857415;
arrWeights_0[66] = 1.777173;
arrWeights_0[67] = 1.489486;
arrWeights_0[68] = 0.990452;
arrWeights_0[69] = -0.312611;
arrWeights_0[70] = -2.485575;
arrWeights_0[71] = 5.784152;
arrWeights_0[72] = 0.691233;
arrWeights_0[73] = 1.003065;
arrWeights_0[74] = 0.746760;
arrWeights_0[75] = 0.973191;
arrWeights_0[76] = 0.868018;
arrWeights_0[77] = 0.821039;
arrWeights_0[78] = 0.770604;
arrWeights_0[79] = 1.139881;
arrWeights_0[80] = 1.057454;
arrWeights_0[81] = 1.004390;
arrWeights_0[82] = 0.595049;
arrWeights_0[83] = 0.733458;
arrWeights_0[84] = 0.177670;
arrWeights_0[85] = -0.170966;
arrWeights_0[86] = -0.443584;
arrWeights_0[87] = -0.345470;
arrWeights_0[88] = 0.135814;
arrWeights_0[89] = -0.010206;
arrWeights_0[90] = 0.585687;
arrWeights_0[91] = 1.040471;
arrWeights_0[92] = 0.778059;
arrWeights_0[93] = 0.994592;
arrWeights_0[94] = 0.882501;
arrWeights_0[95] = 0.819930;
arrWeights_0[96] = 0.783313;
arrWeights_0[97] = 1.225092;
arrWeights_0[98] = 1.138965;
arrWeights_0[99] = 1.112052;
arrWeights_0[100] = 0.667895;
arrWeights_0[101] = 0.725504;
arrWeights_0[102] = -0.042205;
arrWeights_0[103] = -0.470107;
arrWeights_0[104] = -0.758346;
arrWeights_0[105] = -0.356139;
arrWeights_0[106] = 0.477461;
arrWeights_0[107] = 0.159831;
arrWeights_0[108] = 0.465873;
arrWeights_0[109] = 0.827723;
arrWeights_0[110] = 0.635881;
arrWeights_0[111] = 0.876557;
arrWeights_0[112] = 0.751904;
arrWeights_0[113] = 0.689548;
arrWeights_0[114] = 0.624036;
arrWeights_0[115] = 0.943642;
arrWeights_0[116] = 0.844483;
arrWeights_0[117] = 0.793347;
arrWeights_0[118] = 0.439269;
arrWeights_0[119] = 0.710473;
arrWeights_0[120] = 0.362673;
arrWeights_0[121] = 0.107347;
arrWeights_0[122] = -0.123129;
arrWeights_0[123] = -0.079149;
arrWeights_0[124] = 0.300953;
arrWeights_0[125] = 0.333110;
arrWeights_0[126] = 36.878339;
arrWeights_0[127] = -34.157785;
arrWeights_0[128] = 13.570499;
arrWeights_0[129] = -9.445193;
arrWeights_0[130] = 5.906855;
arrWeights_0[131] = -2.631383;
arrWeights_0[132] = -3.466850;
arrWeights_0[133] = 1.387212;
arrWeights_0[134] = 1.168750;
arrWeights_0[135] = -1.252440;
arrWeights_0[136] = -4.167107;
arrWeights_0[137] = 7.462264;
arrWeights_0[138] = 4.218665;
arrWeights_0[139] = -10.616881;
arrWeights_0[140] = 2.816792;
arrWeights_0[141] = -0.854816;
arrWeights_0[142] = 0.465124;
arrWeights_0[143] = 3.805423;
arrWeights_0[144] = 17.371809;
arrWeights_0[145] = -10.758329;
arrWeights_0[146] = 4.288758;
arrWeights_0[147] = -3.300900;
arrWeights_0[148] = -1.387066;
arrWeights_0[149] = -0.545407;
arrWeights_0[150] = -0.627846;
arrWeights_0[151] = 0.359405;
arrWeights_0[152] = -0.910465;
arrWeights_0[153] = 1.672222;
arrWeights_0[154] = -1.087077;
arrWeights_0[155] = 1.711690;
arrWeights_0[156] = 1.892743;
arrWeights_0[157] = 1.370835;
arrWeights_0[158] = -1.074922;
arrWeights_0[159] = -2.069598;
arrWeights_0[160] = 2.132245;
arrWeights_0[161] = 3.323435;
arrWeights_0[162] = 3.192245;
arrWeights_0[163] = 0.722216;
arrWeights_0[164] = 0.595036;
arrWeights_0[165] = 2.562026;
arrWeights_0[166] = 4.118245;
arrWeights_0[167] = 2.533825;
arrWeights_0[168] = 0.661547;
arrWeights_0[169] = -0.522384;
arrWeights_0[170] = -0.923482;
arrWeights_0[171] = -0.744284;
arrWeights_0[172] = -0.531758;
arrWeights_0[173] = -1.737114;
arrWeights_0[174] = -0.894963;
arrWeights_0[175] = 0.335197;
arrWeights_0[176] = 2.767129;
arrWeights_0[177] = 0.169424;
arrWeights_0[178] = -1.868230;
arrWeights_0[179] = 2.057215;
arrWeights_0[180] = 0.408584;
arrWeights_0[181] = 0.730536;
arrWeights_0[182] = 0.549013;
arrWeights_0[183] = 0.810092;
arrWeights_0[184] = 0.687577;
arrWeights_0[185] = 0.626130;
arrWeights_0[186] = 0.551439;
arrWeights_0[187] = 0.839836;
arrWeights_0[188] = 0.758454;
arrWeights_0[189] = 0.711269;
arrWeights_0[190] = 0.388133;
arrWeights_0[191] = 0.706349;
arrWeights_0[192] = 0.491137;
arrWeights_0[193] = 0.305519;
arrWeights_0[194] = 0.119262;
arrWeights_0[195] = 0.059367;
arrWeights_0[196] = 0.280111;
arrWeights_0[197] = 0.432421;
arrWeights_0[198] = 11.382900;
arrWeights_0[199] = -2.355699;
arrWeights_0[200] = 0.800231;
arrWeights_0[201] = -0.812782;
arrWeights_0[202] = -1.725548;
arrWeights_0[203] = 0.506914;
arrWeights_0[204] = 3.685745;
arrWeights_0[205] = -1.570360;
arrWeights_0[206] = -0.678070;
arrWeights_0[207] = -1.385545;
arrWeights_0[208] = 0.665419;
arrWeights_0[209] = -2.403472;
arrWeights_0[210] = 0.348713;
arrWeights_0[211] = 0.948801;
arrWeights_0[212] = 3.943966;
arrWeights_0[213] = 0.609010;
arrWeights_0[214] = -2.954932;
arrWeights_0[215] = 6.570737;
arrWeights_0[216] = 1.098680;
arrWeights_0[217] = 0.457162;
arrWeights_0[218] = 0.047123;
arrWeights_0[219] = 0.314413;
arrWeights_0[220] = 0.270546;
arrWeights_0[221] = 0.271241;
arrWeights_0[222] = 0.444340;
arrWeights_0[223] = 0.685449;
arrWeights_0[224] = 0.881795;
arrWeights_0[225] = 0.904727;
arrWeights_0[226] = 0.538997;
arrWeights_0[227] = 0.274688;
arrWeights_0[228] = -0.107260;
arrWeights_0[229] = -0.182735;
arrWeights_0[230] = -0.297917;
arrWeights_0[231] = -0.722563;
arrWeights_0[232] = -1.004438;
arrWeights_0[233] = 2.114029;
arrWeights_0[234] = 0.625319;
arrWeights_0[235] = 1.073737;
arrWeights_0[236] = 0.794572;
arrWeights_0[237] = 1.012257;
arrWeights_0[238] = 0.909403;
arrWeights_0[239] = 0.851104;
arrWeights_0[240] = 0.819041;
arrWeights_0[241] = 1.284499;
arrWeights_0[242] = 1.213157;
arrWeights_0[243] = 1.195116;
arrWeights_0[244] = 0.731964;
arrWeights_0[245] = 0.733472;
arrWeights_0[246] = -0.119051;
arrWeights_0[247] = -0.574390;
arrWeights_0[248] = -0.865588;
arrWeights_0[249] = -0.405175;
arrWeights_0[250] = 0.494158;
arrWeights_0[251] = 0.142718;
arrWeights_0[252] = 0.443620;
arrWeights_0[253] = 0.790221;
arrWeights_0[254] = 0.604280;
arrWeights_0[255] = 0.852407;
arrWeights_0[256] = 0.728354;
arrWeights_0[257] = 0.666281;
arrWeights_0[258] = 0.596990;
arrWeights_0[259] = 0.903026;
arrWeights_0[260] = 0.809120;
arrWeights_0[261] = 0.758782;
arrWeights_0[262] = 0.416953;
arrWeights_0[263] = 0.708992;
arrWeights_0[264] = 0.415040;
arrWeights_0[265] = 0.186673;
arrWeights_0[266] = -0.028387;
arrWeights_0[267] = -0.027435;
arrWeights_0[268] = 0.289143;
arrWeights_0[269] = 0.376176;
arrWeights_0[270] = 0.377669;
arrWeights_0[271] = 0.691528;
arrWeights_0[272] = 0.513124;
arrWeights_0[273] = 0.786421;
arrWeights_0[274] = 0.670892;
arrWeights_0[275] = 0.613345;
arrWeights_0[276] = 0.538605;
arrWeights_0[277] = 0.819386;
arrWeights_0[278] = 0.749119;
arrWeights_0[279] = 0.706133;
arrWeights_0[280] = 0.394004;
arrWeights_0[281] = 0.723393;
arrWeights_0[282] = 0.551766;
arrWeights_0[283] = 0.390955;
arrWeights_0[284] = 0.222564;
arrWeights_0[285] = 0.125193;
arrWeights_0[286] = 0.287931;
arrWeights_0[287] = 0.397175;
arrWeights_0[288] = 0.390177;
arrWeights_0[289] = 0.704718;
arrWeights_0[290] = 0.524964;
arrWeights_0[291] = 0.793337;
arrWeights_0[292] = 0.673926;
arrWeights_0[293] = 0.614109;
arrWeights_0[294] = 0.538623;
arrWeights_0[295] = 0.821537;
arrWeights_0[296] = 0.747044;
arrWeights_0[297] = 0.702102;
arrWeights_0[298] = 0.386249;
arrWeights_0[299] = 0.712341;
arrWeights_0[300] = 0.526445;
arrWeights_0[301] = 0.357474;
arrWeights_0[302] = 0.183363;
arrWeights_0[303] = 0.099539;
arrWeights_0[304] = 0.282065;
arrWeights_0[305] = 0.431269;

// Layer: 1
arrWeights_1[0] = 0.313367;
arrWeights_1[1] = 0.600233;
arrWeights_1[2] = 0.413307;
arrWeights_1[3] = 0.723853;
arrWeights_1[4] = 0.604417;
arrWeights_1[5] = 0.564724;
arrWeights_1[6] = 0.494233;
arrWeights_1[7] = 0.776964;
arrWeights_1[8] = 0.713700;
arrWeights_1[9] = 0.689037;
arrWeights_1[10] = 0.403412;
arrWeights_1[11] = 0.743660;
arrWeights_1[12] = 0.681661;
arrWeights_1[13] = 0.582135;
arrWeights_1[14] = 0.470205;
arrWeights_1[15] = 0.320594;
arrWeights_1[16] = 0.360557;
arrWeights_1[17] = 0.505358;
arrWeights_1[18] = 0.207009;
arrWeights_1[19] = -0.600315;
arrWeights_1[20] = 0.292799;
arrWeights_1[21] = -0.486397;
arrWeights_1[22] = -0.698483;
arrWeights_1[23] = -0.466675;
arrWeights_1[24] = 0.161680;
arrWeights_1[25] = 1.267072;
arrWeights_1[26] = 0.942115;
arrWeights_1[27] = 1.601429;
arrWeights_1[28] = 0.294829;
arrWeights_1[29] = 2.066898;
arrWeights_1[30] = 1.149577;
arrWeights_1[31] = -0.608109;
arrWeights_1[32] = 0.236174;
arrWeights_1[33] = 0.223691;
arrWeights_1[34] = 0.281142;
arrWeights_1[35] = 2.639872;
arrWeights_1[36] = 0.298441;
arrWeights_1[37] = 0.585156;
arrWeights_1[38] = 0.397331;
arrWeights_1[39] = 0.714002;
arrWeights_1[40] = 0.591642;
arrWeights_1[41] = 0.547087;
arrWeights_1[42] = 0.477829;
arrWeights_1[43] = 0.768086;
arrWeights_1[44] = 0.709662;
arrWeights_1[45] = 0.679375;
arrWeights_1[46] = 0.387499;
arrWeights_1[47] = 0.736123;
arrWeights_1[48] = 0.665259;
arrWeights_1[49] = 0.564510;
arrWeights_1[50] = 0.453956;
arrWeights_1[51] = 0.305558;
arrWeights_1[52] = 0.345016;
arrWeights_1[53] = 0.508310;
arrWeights_1[54] = -0.677255;
arrWeights_1[55] = -1.032676;
arrWeights_1[56] = -0.744642;
arrWeights_1[57] = -0.925155;
arrWeights_1[58] = -1.197128;
arrWeights_1[59] = -0.992372;
arrWeights_1[60] = -0.855172;
arrWeights_1[61] = 7.016197;
arrWeights_1[62] = 5.226784;
arrWeights_1[63] = 2.411577;
arrWeights_1[64] = -0.733721;
arrWeights_1[65] = 3.402664;
arrWeights_1[66] = 1.729731;
arrWeights_1[67] = -0.991801;
arrWeights_1[68] = -0.815011;
arrWeights_1[69] = -0.677321;
arrWeights_1[70] = -0.693829;
arrWeights_1[71] = 9.138765;
arrWeights_1[72] = -0.246490;
arrWeights_1[73] = -0.391846;
arrWeights_1[74] = -0.347720;
arrWeights_1[75] = -1.096698;
arrWeights_1[76] = -0.001496;
arrWeights_1[77] = -0.693606;
arrWeights_1[78] = -0.468658;
arrWeights_1[79] = 6.178259;
arrWeights_1[80] = 4.306803;
arrWeights_1[81] = 2.409460;
arrWeights_1[82] = -0.336563;
arrWeights_1[83] = 2.374341;
arrWeights_1[84] = 1.504236;
arrWeights_1[85] = -0.726152;
arrWeights_1[86] = -0.426187;
arrWeights_1[87] = -0.254840;
arrWeights_1[88] = -0.293797;
arrWeights_1[89] = -1.892730;

// Layer: 2
arrWeights_2[0] = -0.626160;
arrWeights_2[1] = 1.717378;
arrWeights_2[2] = -0.485501;
arrWeights_2[3] = 2.751261;
arrWeights_2[4] = 2.323994;
arrWeights_2[5] = 2.047616;
    
    // drawing settings
    
    SetIndexStyle(0, DRAW_NONE);
    SetIndexEmptyValue(0, 0.0);
    
    SetIndexStyle(1, DRAW_LINE);
    SetIndexEmptyValue(1, 0.0);

    IndicatorDigits(4);
        
    string strIndicatorShortName = "forex_nn";
    IndicatorShortName(strIndicatorShortName);

    // indicator buffers mapping
    SetIndexBuffer(0, arrNocBuffer);
    SetIndexBuffer(1, arrNnBuffer);    
    
    SetLevelStyle(STYLE_DOT,1);
    SetLevelValue(0,BuyLevel); 
    SetLevelValue(1,SellLevel); 

    return(0);
}
////////////////////
int start()
{

    nExtCountedBars = IndicatorCounted();
    if(nExtCountedBars < 0) 
        return(-1);

    // last counted bar will be recounted
    if(nExtCountedBars > 0) 
        nExtCountedBars--;
        
    Noc();        
    ApplyNn();  

    return(0);
}
///////////////////
// For the selected period:
// CLV = ((Close - Low) - (High - Close)) / (High - Low) 
void Noc()
{
    int nPos = Bars - nExtCountedBars;

    while(nPos > 0)
    {
        if(nPos > Bars - nRemoveFirst)
        {
            arrNocBuffer[nPos] = 0.5;
            nPos--;
            continue;
        }

        double dClose = Close[nPos];
        double dLow = Low[ArrayMinimum(Low, interval, nPos)]; 
        double dHigh = High[ArrayMaximum(High, interval, nPos)]; 

        arrNocBuffer[nPos] = 0.1;

        if(dHigh - dLow > dNocRange)
            arrNocBuffer[nPos] = (((dClose - dLow) - (dHigh - dClose)) 
                / (dHigh - dLow)) / 2 + 0.5; 
        else
            arrNocBuffer[nPos] = (((dClose - dLow) - (dHigh - dClose)) 
                / dNocRange) / 2 + 0.5; 

        nPos--;
    }
    
    if(MA > 1)
        Ema(arrNocBuffer);
}
///////////////////
void Ema(double& arr[])
{
    double dPr = 2.0 / (MA + 1);

    int nPos = Bars - nExtCountedBars;
    
    while(nPos > 0)
    {
        if(nPos == Bars - 2) 
            arrNocBuffer[nPos + 1] = arr[nPos + 1];

        arrNocBuffer[nPos] = arr[nPos] * dPr + arrNocBuffer[nPos + 1] 
            * (1 - dPr);
        nPos--;
    }
}
///////////////////
void ApplyNn()
{
    int nPos = Bars - nExtCountedBars - 2;

    while(nPos > 0)
    {
        if(nPos > Bars - nRemoveFirst)
        {
            arrNnBuffer[nPos] = 0.5;
            nPos--;
            continue;
        }

        arrNnBuffer[nPos] = 0.5*100;
        
        for(int nLagNo = 0; nLagNo < nNumOfLags; nLagNo++)
            arrPattern[nLagNo] 
                = arrNocBuffer[nPos + arrLags[nLagNo] + nOutLag];

        for(int nLayer = 0; nLayer < nLayers; nLayer++)
        {
            // Absolute index of the weight in an array
            int nWeightIdx = 0;

            for(int nNeuron = 0; nNeuron < arrNeurons[nLayer]; 
                nNeuron++)
            {
                double dLinearCombiner = 0;
    
                int nInputs = arrNeurons[nLayer];
                if(nLayer != 0)
                    nInputs = arrNeurons[nLayer - 1];
                
                for(int nInput = 0; nInput < nInputs; nInput++)
                {
                    double dInput;
                    double dWeight;
                    switch(nLayer)
                    { 
                        case 0:
                        {
                            dInput = arrPattern[nInput];
                            dWeight = arrWeights_0[nWeightIdx];
                        }
                        break;
                        
                        case 1:
                        {
                            dInput = arrOutput_0[nInput];
                            dWeight = arrWeights_1[nWeightIdx];
                        }
                        break;
                        
                        default:
                        {
                            dInput = arrOutput_1[nInput];
                            dWeight = arrWeights_2[nWeightIdx];
                        }
                        break;
                    }

                    dLinearCombiner += dWeight * dInput;
                
                    nWeightIdx++;
                }        

                switch(nLayer)
                {
                    case 0:
                        dWeight = arrWeights_0[nWeightIdx]; break;
                    case 1:
                        dWeight = arrWeights_1[nWeightIdx]; break;
                    default: 
                        dWeight = arrWeights_2[nWeightIdx]; break;
                }

                dLinearCombiner += (-1) * dWeight;
                nWeightIdx++;

                double dActivation = Activation(dLinearCombiner, 0);

                switch(nLayer)
                {
                    case 0:
                        arrOutput_0[nNeuron] = dActivation; break;
                    case 1:
                        arrOutput_1[nNeuron] = dActivation; break;
                    default: 
                        dNnOutput = dActivation; break;
                }

            }    // for all neurons

        }    // for all layers

        arrNnBuffer[nPos] = dNnOutput*100;

        nPos--;
            
    }    // for all patterns
}
///////////////////
double Activation(double u, int nType)
{
    //double dEx = TANH(u / 2);
    
    double dPow = MathPow(dE, 2 * u / 2);
    double dEx = (dPow - 1) / (dPow + 1);
    if(dEx == 1 || dEx == -1)
        dEx = dEx * 0.999999999;
    
    // 0 - sigmoid, 1 - tangent
    if(nType == 0)
        return((dEx + 1) / 2);

    return(dEx);
}


