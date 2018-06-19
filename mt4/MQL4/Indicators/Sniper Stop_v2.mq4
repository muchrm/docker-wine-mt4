
#property copyright "Copyright © 2008, GJ Pavkovich.com "
#property link      "http://www.sniperforex.com/"

#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 Blue
#property indicator_color2 Red

double gd_76 = 15.0;
double g_period_84 = 14.0;
double gd_92 = 3.0;
double gd_100 = 0.0;
double g_ibuf_108[];
double g_ibuf_112[];
double g_ibuf_116[];
double g_ibuf_120[];
double g_ibuf_124[];

int init() {
   SetIndexStyle(0, DRAW_ARROW);
   SetIndexArrow(0, 159);
   SetIndexStyle(1, DRAW_ARROW);
   SetIndexArrow(1, 159);
   IndicatorBuffers(5);
   SetIndexBuffer(0, g_ibuf_108);
   SetIndexBuffer(1, g_ibuf_112);
   SetIndexBuffer(2, g_ibuf_116);
   SetIndexBuffer(3, g_ibuf_120);
   SetIndexBuffer(4, g_ibuf_124);
   string ls_0 = "Sniper Stop(" + gd_76 + ")";
   IndicatorShortName(ls_0);
   SetIndexLabel(0, "Up");
   SetIndexLabel(1, "Dn");
   SetIndexDrawBegin(0, gd_76);
   SetIndexDrawBegin(1, gd_76);
   return (0);
}

int start() {
   int li_16;
   string ls_0 = "2020.09.09";
   int l_str2time_8 = StrToTime(ls_0);
   if (TimeCurrent() >= l_str2time_8) {
      Alert("Trial version expired! Contact www.sniperforex.com.");
      return (0);
   }
   int l_ind_counted_20 = IndicatorCounted();
   if (l_ind_counted_20 > 0) li_16 = Bars - l_ind_counted_20;
   if (l_ind_counted_20 < 0) return (0);
   if (l_ind_counted_20 == 0) li_16 = Bars - gd_76 - 1.0;
   for (int li_12 = li_16; li_12 >= 0; li_12--) {
      g_ibuf_116[li_12] = High[iHighest(NULL, 0, MODE_HIGH, gd_76, li_12 + gd_100)] - gd_92 * iATR(NULL, 0, g_period_84, li_12 + gd_100);
      g_ibuf_120[li_12] = Low[iLowest(NULL, 0, MODE_LOW, gd_76, li_12 + gd_100)] + gd_92 * iATR(NULL, 0, g_period_84, li_12 + gd_100);
      g_ibuf_124[li_12] = g_ibuf_124[li_12 + 1];
      if (Close[li_12] > g_ibuf_120[li_12 + 1]) g_ibuf_124[li_12] = 1;
      if (Close[li_12] < g_ibuf_116[li_12 + 1]) g_ibuf_124[li_12] = -1;
      if (g_ibuf_124[li_12] > 0.0) {
         if (g_ibuf_116[li_12] < g_ibuf_116[li_12 + 1]) g_ibuf_116[li_12] = g_ibuf_116[li_12 + 1];
         g_ibuf_108[li_12] = g_ibuf_116[li_12];
         g_ibuf_112[li_12] = EMPTY_VALUE;
      }
      if (g_ibuf_124[li_12] < 0.0) {
         if (g_ibuf_120[li_12] > g_ibuf_120[li_12 + 1]) g_ibuf_120[li_12] = g_ibuf_120[li_12 + 1];
         g_ibuf_108[li_12] = EMPTY_VALUE;
         g_ibuf_112[li_12] = g_ibuf_120[li_12];
      }
   }
   return (0);
}