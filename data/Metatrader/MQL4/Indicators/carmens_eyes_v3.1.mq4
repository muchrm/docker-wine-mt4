//        +-------------------------------------------------------------------------------------------------------+
//        |                                                                                  carmens_eyes_v3.1mq4 |
//        |                                                                                    November 26th 2009 |
//        +-------------------------------------------------------------------------------------------------------+   

#property indicator_chart_window
#property indicator_buffers 5
#property indicator_color1 White
#property indicator_color2 Orange
#property indicator_color3 Red
#property indicator_color4 Blue
#property indicator_color5 Yellow
    
extern string Warning="DEFAULT SETTINGS ARE FOR GBP/USD";    
extern int    average=3; 
extern double space=1;  
extern bool   try_again=false; 
extern bool   Display_TakeProfit=true;   
extern string SetOne="**********************Set_One_Settings***************";                       
extern double Main_expand_rate_1=75;
extern double LineOne_expand_rate_1=20;
extern double LineTwo_expand_rate_1=10;
extern string SetTwo="**********************Set_Two_Settings***************"; 
extern double start_at_pips_profit_2=50;
extern double Main_expand_rate_2=65;
extern double LineOne_expand_rate_2=40;
extern double LineTwo_expand_rate_2=20;
extern string SetThree="**********************Set_Three_Settings***********";
extern double start_at_pips_profit_3=100;
extern double Main_expand_rate_3=50;
extern double LineOne_expand_rate_3=25;
extern double LineTwo_expand_rate_3=15;
extern string SetFour="**********************Set_Four_Settings***********";
extern double start_at_pips_profit_4=150;
extern double Main_expand_rate_4=35;
extern double LineOne_expand_rate_4=15;
extern double LineTwo_expand_rate_4=10;

//                                                        DESCRIPTION OF SETTINGS 
//
//                 average: Determines period of quick EMA
//                  space : Determines the width between the channel, ie Top and Bottom. Each standard deviation is equal to 6 pips.                
//              try_again : Easter Egg :) 
//                                                                Set One                                                                                              
//     Main_expand_rate_1 : Determines how closely the channel(Blue & Yellow) will follow the price before profit has reached start_at_pips_profit_2.  
//  LineOne_expand_rate_1 : Determines how closely the first Take Profit line will follow the price before profit has reached start_at_pips_profit_2.  
//  LineTwo_expand_rate_1 : Determines how closely the second Take Profit line will follow the price before profit has reached start_at_pips_profit_2. 
//                                                                Set Two    
// start_at_pips_profit_2 : Determines how profitible trade must be before switching to Set Two settings.
//     Main_expand_rate_2 : Determines how closely the channel(Blue & Yellow) will follow the price when profit is between start_at_pips_profit_2 and start_at_pips_profit_3.  
//  LineOne_expand_rate_2 : Determines how closely the first Take Profit line will follow the price when profit is between start_at_pips_profit_2 and start_at_pips_profit_3.  
//  LineTwo_expand_rate_2 : Determines how closely the second Take Profit line will follow the price when profit is between start_at_pips_profit_2 and start_at_pips_profit_3.  
//                                                                Set Three    
// start_at_pips_profit_3 : Determines how profitible trade must be before switching to Set Three settings.
//     Main_expand_rate_3 : Determines how closely the channel(Blue & Yellow) will follow the price when profit is between start_at_pips_profit_3 and start_at_pips_profit_4.  
//  LineOne_expand_rate_3 : Determines how closely the first Take Profit line will follow the price when profit is between start_at_pips_profit_3 and start_at_pips_profit_4.
//  LineTwo_expand_rate_3 : Determines how closely the second Take Profit line will follow the price when profit is between start_at_pips_profit_3 and start_at_pips_profit_4.
//                                                                Set Four    
// start_at_pips_profit_3 : Determines how profitible trade must be before switching to Set Three settings.
//     Main_expand_rate_4 : Determines how closely the channel(Blue & Yellow) will follow the price when profit is greater than start_at_pips_profit_4.  
//  LineOne_expand_rate_4 : Determines how closely the first Take Profit line will follow the price before profit is greater than start_at_pips_profit_4.  
//  LineTwo_expand_rate_4 : Determines how closely the second Take Profit line will follow the price before profit is greater than start_at_pips_profit_4.       


double averagefx[];
double range1[];
double range2[];
double top[];
double bottom[];

int max,order;
double bed,tal,atr,step1,step2,step3,deviation,bu,sl,maxlow,maxhigh,isranging,istime,cat,dif,spaceX,profitX=0,
       expand_rateX1,expand_rateX2,expand_rateX3;
bool ranging,step2Close,step3Close;

int init()
  {
   max=50;  
   
   SetIndexStyle(0,DRAW_LINE);
   SetIndexBuffer(0,averagefx);
   SetIndexStyle(1,DRAW_LINE);
   SetIndexBuffer(1,range1);
   SetIndexStyle(2,DRAW_LINE);
   SetIndexBuffer(2,range2);
   SetIndexStyle(3,DRAW_LINE);
   SetIndexBuffer(3,top);
   SetIndexStyle(4,DRAW_LINE);
   SetIndexBuffer(4,bottom);
 
   
   SetIndexDrawBegin(0,max);
   SetIndexDrawBegin(1,max);
   SetIndexDrawBegin(2,max);
   SetIndexDrawBegin(3,max);
   SetIndexDrawBegin(4,max);
   
   if(Digits==5 || Digits==3)  { dif=Point*10; } else dif=Point; 
 
   return(0);
  }

int start()
  {
   int    i,k,x,counted_bars=IndicatorCounted(),limit;
   double buffer,sum,newres,BandsDeviation,distance,sub,mh;
   bool condition1=false;
   
   if(Bars<=max) { return(0); }
   if(counted_bars<1)
      for(i=1;i<=max;i++)
        {
         averagefx[Bars-i]=EMPTY_VALUE;
         range1[Bars-i]=EMPTY_VALUE;
         range2[Bars-i]=EMPTY_VALUE;
         top[Bars-i]=EMPTY_VALUE;
         bottom[Bars-i]=EMPTY_VALUE; }

   if(counted_bars>0) { limit++; counted_bars--; }
   limit=Bars-counted_bars-1;
 
   for(i=0; i<limit; i++)
      averagefx[i]=iMA(NULL,0,average,0,MODE_EMA,PRICE_CLOSE,i);

   i=Bars-max+1;
   if(counted_bars>max-1) i=Bars-counted_bars-1;
   while(i>=0)
     {
     if(order==0) { profitX=1; }
     if(profitX<start_at_pips_profit_2) {
         expand_rateX1=Main_expand_rate_1*dif;
         expand_rateX2=LineOne_expand_rate_1*dif; 
         expand_rateX3=LineTwo_expand_rate_1*dif; }
     if(profitX>=start_at_pips_profit_2 && profitX<start_at_pips_profit_3) {
         expand_rateX1=Main_expand_rate_2*dif;
         expand_rateX2=LineOne_expand_rate_2*dif; 
         expand_rateX3=LineTwo_expand_rate_2*dif; } 
     if(profitX>=start_at_pips_profit_3 && profitX<start_at_pips_profit_4) { 
         expand_rateX1=Main_expand_rate_3*dif; 
         expand_rateX2=LineOne_expand_rate_3*dif;
         expand_rateX3=LineTwo_expand_rate_3*dif; } 
    if(profitX>start_at_pips_profit_4) { 
         expand_rateX1=Main_expand_rate_4*dif;
         expand_rateX2=LineOne_expand_rate_4*dif;
         expand_rateX3=LineTwo_expand_rate_4*dif; }
         
      buffer=6*spaceX;
      spaceX=space*dif;
  
      if(order==0) { step1=averagefx[i]; }
      if(order==1) { // Buy
         if((averagefx[i]>step1) && MathAbs(averagefx[i]-step1)>expand_rateX1)    { step1=averagefx[i]-expand_rateX1;  }
         if((averagefx[i]>step2) && MathAbs(averagefx[i]-step2)>expand_rateX2)    { step2=averagefx[i]-expand_rateX2;  }
         if((averagefx[i]>step3) && MathAbs(averagefx[i]-step3)>expand_rateX3)    { step3=averagefx[i]-expand_rateX3;  }}
      if(order==2) { // Sell
         if((averagefx[i]<step1) && MathAbs(averagefx[i]-step1)>expand_rateX1)    { step1=averagefx[i]+expand_rateX1;  }
         if((averagefx[i]<step2) && MathAbs(averagefx[i]-step2)>expand_rateX2)    { step2=averagefx[i]+expand_rateX2;  }
         if((averagefx[i]<step3) && MathAbs(averagefx[i]-step3)>expand_rateX3)    { step3=averagefx[i]+expand_rateX3;  }}
 
      if(order==1) { 
         top[i]=step1;
         bottom[i]=step1-buffer;
         if(step2Close==false) { range1[i]=step2;  } 
         if(step2Close==true)  { range1[i]=top[i]; }
         if(step3Close==false) { range2[i]=step3;  } 
         if(step3Close==true)  { range2[i]=top[i]; }}
      if(order==2) { 
         top[i]=step1+buffer;
         bottom[i]=step1;
         if(step2Close==false) { range1[i]=step2;  } 
         if(step2Close==true)  { range1[i]=bottom[i]; }
         if(step3Close==false) { range2[i]=step3;  } 
         if(step3Close==true)  { range2[i]=bottom[i]; }}
      
      if(order==1) { 
         if((averagefx[i]<step2) && (step2!=step1)) { step2Close=true; } 
         if((averagefx[i]<step3) && (step3!=step1)) { step3Close=true; }} 
      if(order==2) { 
         if((averagefx[i]>step2) && (step2!=step1)) { step2Close=true; } 
         if((averagefx[i]>step3) && (step3!=step1)) { step3Close=true; }} 
      
      if(try_again==true) { 
      if(order==1) { 
         if((step2Close==true) && (averagefx[i]<top[i])) { step2Close=false; step2=top[i]; } 
         if((step3Close==true) && (averagefx[i]<top[i])) { step3Close=false; step3=top[i]; }}
      if(order==2) { 
         if((step2Close==true) && (averagefx[i]>bottom[i])) { step2Close=false; step2=bottom[i];} 
         if((step3Close==true) && (averagefx[i]>bottom[i])) { step3Close=false; step3=bottom[i];}}}
     

      if(averagefx[i]>top[i])    { order=1; if(bu==0) { step1=top[i];    bu=averagefx[i]; sl=0; profitX=0; step2=top[i]; step3=top[i]; step2Close=false; step3Close=false; }}
      if(averagefx[i]<bottom[i]) { order=2; if(sl==0) { step1=bottom[i]; sl=averagefx[i]; bu=0; profitX=0; step2=bottom[i]; step3=bottom[i];step2Close=false; step3Close=false; }}
      
      if(order==1) { if(MathAbs(averagefx[i]-bu)>(profitX*dif)) { profitX=MathAbs(averagefx[i]-bu)*(1/dif); }}
      if(order==2) { if(MathAbs(averagefx[i]-sl)>(profitX*dif)) { profitX=MathAbs(averagefx[i]-sl)*(1/dif); }}
      
      if(Display_TakeProfit==false) { range1[i]=top[i]; range2[i]=top[i]; }
      
      i--; }
 
   return(0);
  }
  
  