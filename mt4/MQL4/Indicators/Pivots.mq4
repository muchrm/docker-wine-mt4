//+------------------------------------------------------------------+
//|   Original Indicator Auto-Pivot Plotter Labels.mq4 Elton Treloar |
//|               I called this one Pivot Point S&R + GMT correction |
//|                                         and was made by Linuxser |
//|  Thanks to Rosh form metaquotes forum for fix the redraw problem |
//+------------------------------------------------------------------+
#property copyright ""
#property link      ""
#define IND_NAME "Pivot Point S&R"
#property indicator_chart_window
#property indicator_buffers 7
#property indicator_color1 Green
#property indicator_color2 Blue
#property indicator_color3 Red
#property indicator_color4 Blue
#property indicator_color5 Red
#property indicator_color6 Blue
#property indicator_color7 Red

//---- input parameters
extern int       StartHour=0;
extern int       StartMinute=0;
extern int       DaysToPlot=15;
extern color     SupportLabelColor=DodgerBlue;
extern color     ResistanceLabelColor=OrangeRed;
extern color     PivotLabelColor=Green;
extern int       fontsize=8;
extern int       LabelShift = 0;

//---- buffers
double R3Buffer[];
double R2Buffer[];
double R1Buffer[];
double PBuffer[];
double S1Buffer[];
double S2Buffer[];
double S3Buffer[];


string Pivot="Pivot",Sup1="S 1", Res1="R 1";
string Sup2="S 2", Res2="R 2", Sup3="S 3", Res3="R 3";

datetime LabelShiftTime;

double P,S1,R1,S2,R2,S3,R3;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
   SetIndexStyle(0,DRAW_LINE,0,2);
   SetIndexStyle(1,DRAW_LINE,0,2);
   SetIndexStyle(2,DRAW_LINE,0,2);
   SetIndexStyle(3,DRAW_LINE,0,2);
   SetIndexStyle(4,DRAW_LINE,0,2);
   SetIndexStyle(5,DRAW_LINE,0,2);
   SetIndexStyle(6,DRAW_LINE,0,2);
   SetIndexBuffer(0,PBuffer);
   SetIndexBuffer(1,S1Buffer);
   SetIndexBuffer(2,R1Buffer);
   SetIndexBuffer(3,S2Buffer);
   SetIndexBuffer(4,R2Buffer);
   SetIndexBuffer(5,S3Buffer);
   SetIndexBuffer(6,R3Buffer);
   
   IndicatorShortName(IND_NAME);
//----

   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//----

   ObjectDelete("Res3");
   ObjectDelete("Res2");
   ObjectDelete("Res1");
   ObjectDelete("Pivot");
   ObjectDelete("Sup1");
   ObjectDelete("Sup2");
   ObjectDelete("Sup3");   
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   int    counted_bars=IndicatorCounted(); 
  
  
//---- indicator calculation

{
   if (counted_bars==0)
   if(counted_bars<0) return(-1);
   //---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;
   
   
}

   int limit=Bars-counted_bars;
   int StartMinutesIntoDay=(StartHour*60)+StartMinute; // 8' o'clock x 60 = 480
   int CloseMinutesIntoDay=StartMinutesIntoDay-Period(); //
   
   
   // ****************************************************
   //    Check That cloes time isn't now a negative number.
   //    Correct if it is by adding a full day's worth 
   //    of minutes.
   // ****************************************************
   
   if (CloseMinutesIntoDay<0)
      {
         CloseMinutesIntoDay=CloseMinutesIntoDay+1440;
      }
      
   // ****************************************************
   //    Establish the nuber of bars in a day.
   // ****************************************************
   int BarsInDay=1440/Period();
    
   // ******************************************************************************************
   // ******************************************************************************************
   //                                        Main Loop                                      
   // ******************************************************************************************
   // ******************************************************************************************
   
   for(int i=0; i<limit; i++)
   { 
      // ***************************************************************************
      //       Only do all this if we are within the plotting range we want.
      //       i.e. DaysToPlot 
      //       If DaysToPlot is "0" (zero) we plot ALL available data. This can be 
      //    VERY slow with a large history and at small time frames. Expect to
      //    wait if plotting a year or more on a say a five minute chart. On my PC 
      //    two years of data at Five Minutes takes around 30 seconds per indicator. 
      //    i.e. 30 seconds for main pivot levels indicator then another 30 seconds 
      //    to plot the seperate mid-levels indicator. 
      // ***************************************************************************
      if ( (i<((DaysToPlot+1)*BarsInDay))||DaysToPlot==0)   // Used to limit the number of days
      {                                                     // that are mapped out. Less waiting ;)
      
      // *****************************************************
      //    Find previous day's opening and closing bars.
      // *****************************************************
      
      int PreviousClosingBar = FindLastTimeMatchFast(CloseMinutesIntoDay,i+1);
      int PreviousOpeningBar = FindLastTimeMatchFast(StartMinutesIntoDay,PreviousClosingBar+1);
      
      double PreviousHigh= High[PreviousClosingBar];
      double PreviousLow = Low [PreviousClosingBar];
      double PreviousClose = Close[PreviousClosingBar];
      
      // *****************************************************
      //    Find previous day's high and low.
      // *****************************************************
      
      for (int SearchHighLow=PreviousClosingBar;SearchHighLow<(PreviousOpeningBar+1);SearchHighLow++)
      {
         if (High[SearchHighLow]>PreviousHigh) PreviousHigh=High[SearchHighLow];
         if (Low[SearchHighLow]<PreviousLow) PreviousLow=Low[SearchHighLow];
      }
      
      // ************************************************************************
      //    Calculate Pivot lines and map into indicator buffers.
      // ************************************************************************
      {
      double P =  (PreviousHigh+PreviousLow+PreviousClose)/3;
      double R1 = (2*P)-PreviousLow;
      double S1 = (2*P)-PreviousHigh;
      double R2 =  P+(PreviousHigh - PreviousLow);
      double S2 =  P-(PreviousHigh - PreviousLow);
      double R3 =  P+2 * (PreviousHigh - PreviousLow);
      double S3 =  P-2 * (PreviousHigh - PreviousLow);
      
      LabelShiftTime = Time[LabelShift];
      
      if (i==0)
         {
         Print(i);
   
         ObjectCreate("Pivot", OBJ_TEXT, 0, LabelShiftTime, 0);   
         ObjectSetText("Pivot", "                           Pivot " +DoubleToStr(P,4),fontsize,"tahoma ",PivotLabelColor);
         SetIndexLabel(0, "Pivot Point");
         ObjectCreate("Sup1", OBJ_TEXT, 0, LabelShiftTime, 0);
         ObjectSetText("Sup1", "                    S1 " +DoubleToStr(S1,4),fontsize,"tahoma ",SupportLabelColor);
         SetIndexLabel(1, "S1");
         ObjectCreate("Res1", OBJ_TEXT, 0, LabelShiftTime, 0);
         ObjectSetText("Res1", "                    R1 " +DoubleToStr(R1,4),fontsize,"tahoma ",ResistanceLabelColor);
         SetIndexLabel(2, "R1");
         ObjectCreate("Sup2", OBJ_TEXT, 0, LabelShiftTime, 0);
         ObjectSetText("Sup2", "                    S2 " +DoubleToStr(S2,4),fontsize,"tahoma ",SupportLabelColor);
         SetIndexLabel(3, "S2");
         ObjectCreate("Res2", OBJ_TEXT, 0, LabelShiftTime, 0);
         ObjectSetText("Res2", "                    R2 " +DoubleToStr(R2,4),fontsize,"tahoma ",ResistanceLabelColor);
         SetIndexLabel(4, "R2");
         ObjectCreate("Sup3", OBJ_TEXT, 0, LabelShiftTime, 0);
         ObjectSetText("Sup3", "                    S3 " +DoubleToStr(S3,4),fontsize,"tahoma ",SupportLabelColor);
         SetIndexLabel(5, "S3");
         ObjectCreate("Res3", OBJ_TEXT, 0, LabelShiftTime, 0);
         ObjectSetText("Res3", "                    R3 " +DoubleToStr(R3,4),fontsize,"tahoma ",ResistanceLabelColor);
         SetIndexLabel(6, "R3");
         Print("ObjectSet Done");
         ObjectMove("Res3", 0, LabelShiftTime,R3);
         ObjectMove("Res2", 0, LabelShiftTime,R2);
         ObjectMove("Res1", 0, LabelShiftTime,R1);
         ObjectMove("Pivot", 0, LabelShiftTime,P);
         ObjectMove("Sup1", 0, LabelShiftTime,S1);
         ObjectMove("Sup2", 0, LabelShiftTime,S2);
         ObjectMove("Sup3", 0, LabelShiftTime,S3);
         Print("ObjectMove Done");
      
         ObjectsRedraw(); 
         Print("ObjectsRedraw Done");
         }
   }
      
}  
    R3Buffer[i]=R3;
    R2Buffer[i]=R2;
    R1Buffer[i]=R1;
    PBuffer[i]=P;
    S1Buffer[i]=S1;
    S2Buffer[i]=S2;
    S3Buffer[i]=S3;
    
   }
      // Extra1[i]=OpenPriceAt+i;

      //   **********************************************
      //      Calculate the mid-levels in to the buffers. 
      //      (for mid-levels version)
      //   **********************************************(Twe)
      // Res1[i] =((R1-P)/2)+P;    //M3
      // Res2[i] =((R2-R1)/2)+R1;  //M4
      // Res3[i] =((R3-R2)/2)+R2;  
      // Supp1[i]=((P-S1)/2)+S1;   //M2
      // Supp2[i]=((S1-S2)/2)+S2;  //M1
      // Supp3[i]=((S2-S3)/2)+S3;


       //End of 'DaysToPlot 'if' statement.
     
      // ***************************************************************************************
      //                            End of Main Loop
      // ***************************************************************************************
  

   // *****************************************
   //    Return from Start() (Main Routine)
   return(0);
  
  }
//+-------------------------------------------------------------------------------------------------------+
//  END Custom indicator iteration function
//+-------------------------------------------------------------------------------------------------------+


// *****************************************************************************************
// *****************************************************************************************
// -----------------------------------------------------------------------------------------
//    The following routine will use "StartingBar"'s time and use it to find the 
//    general area that SHOULD contain the bar that matches "TimeToLookFor"
// -----------------------------------------------------------------------------------------
int FindLastTimeMatchFast(int TimeToLookFor,int StartingBar)
   {
   int StartingBarsTime=(TimeHour(Time[StartingBar])*60)+TimeMinute(Time[StartingBar]);
   
   // ***************************************************
   //    Check that our search isn't on the otherside of 
   //    the midnight boundary and correct for calculations
   // ***************************************************
   if (StartingBarsTime<TimeToLookFor)
      {
      StartingBarsTime=StartingBarsTime+1440;
      }
      
   // ***************************************************
   //    Find out where the bar SHOULD be in time.
   // ***************************************************
   int HowFarBack=StartingBarsTime-TimeToLookFor;
   
   // ***************************************************
   //    Translate that into Bars
   // ***************************************************
   int HowManyBarsBack=HowFarBack/Period();
   
   // ***************************************************
   //    We've found our starting point
   //    Calculate it's relative time in minutes.
   // ***************************************************
   int SuggestedBar=StartingBar+HowManyBarsBack;
   
   int SuggestedBarsTime=(TimeHour(Time[SuggestedBar])*60)+TimeMinute(Time[SuggestedBar]);
   
   // ***************************************************
   //    If we have what we're after let's just skip the 
   //    crap and return the position of the bar in the 
   //    chart to our main routine
   // ***************************************************
   if (SuggestedBarsTime==TimeToLookFor)
      {
      return(SuggestedBar);
      }   
      
   // ***************************************************
   // Else find the difference in time from where we
   // were supposed to find the bar.
   // ***************************************************
   int DeltaTimeFound=TimeToLookFor-SuggestedBarsTime;
   int DeltaBarFound=DeltaTimeFound/Period();
   
   // ***************************************************
   // I'd be worried if Delta was below zero. Would mean
   // that we have EXTRA bars in that day.  Unlikely in 
   // the extreme.
   // So I'm only checking for the other case.
   // ...now let's search in a narrow range to find that 
   // bar we are after...
   // ***************************************************
   if (DeltaTimeFound>0)
      {
        for (int SearchCount=SuggestedBar ;SearchCount>(SuggestedBar-DeltaBarFound-2) ;SearchCount--)
            {
            // ******************************************************************************
            //    Find time (in minutes) of the current bar AND the two bars either side of it.
            // This is done to allow for any missing bars in the data.   i.e. If THE bar you 
            // were after were to be missing you'd never get a valid close/open time.  
            //    This is the same reason for searching rather than just looking back a certain
            // number of bars from the close time. Missing bars upset the count back and 
            // screw up all pivot calculations. There is still room for error but it's improved.
            // The best calculations will come from having the best data. ...of course. :)
            // ******************************************************************************
            //
            int PreviousBarsTime=(TimeHour(Time[SearchCount+1])*60)+TimeMinute(Time[SearchCount+1]);
            int CurrentBarsTime=(TimeHour(Time[SearchCount])*60)+TimeMinute(Time[SearchCount]);
            int NextBarsTime=(TimeHour(Time[SearchCount-1])*60)+TimeMinute(Time[SearchCount-1]);
      
            if (CurrentBarsTime==TimeToLookFor)
               {
               return(SearchCount);    // *** If current bar is what we are after than lets get out.
                                 // *** without mucking about with the rest of the checks.
               }
      
            // **********************************
            //    Check that previous bar doesn't
            // lay on a different day.
            //    Adjust if it is
            // **********************************
            if(PreviousBarsTime>CurrentBarsTime)  
               {                                       
               PreviousBarsTime=PreviousBarsTime-1440;
               }
            // **********************************
            //    Check that following bar doesn't
            // lay on a different day. 
            //    Adjust if it is.
            // **********************************
            if(NextBarsTime<CurrentBarsTime)         
               {
               NextBarsTime=NextBarsTime+1440;
               }
            // ******************************************
            //    If this is the best we can get
            // to the actual bar we are after, then 
            // exit, returning current bar number.
            // *******************************************    
            if(PreviousBarsTime<TimeToLookFor)
               {
                  if( TimeToLookFor<NextBarsTime)
                  {
                  return(SearchCount);
                  }
               }
            }
      }
   
   return (SuggestedBar);
   }


