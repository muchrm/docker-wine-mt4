
#property copyright "GJ Pavkovich"
#property link      "http://www.sniperforex.Comment"

#property indicator_separate_window
#property indicator_buffers 2
#property indicator_color1 Red
#property indicator_color2 Blue

double g_ibuf_76[];
double g_ibuf_80[];
extern double Sniper = 0.01;
extern double SniperSS = 0.1;
extern int SniperP = 7;
extern bool AlertsEnabled = FALSE;
double g_bars_108;

int init() {
   SetIndexStyle(0, DRAW_HISTOGRAM);
   SetIndexStyle(1, DRAW_HISTOGRAM);
   SetIndexBuffer(0, g_ibuf_76);
   SetIndexBuffer(1, g_ibuf_80);
   SetIndexArrow(0, 115);
   SetIndexArrow(1, 115);
   IndicatorShortName("Sniper Trend B");
   SetIndexLabel(0, "Up Trend");
   SetIndexLabel(1, "Down Trend");
   SetIndexDrawBegin(0, 2);
   SetIndexDrawBegin(1, 2);
   return (0);
}

int deinit() {
   return (0);
}

int start() {
   double ld_24;
   string ls_0 = "2020.09.09";
   int l_str2time_8 = StrToTime(ls_0);
   if (TimeCurrent() >= l_str2time_8) {
      Alert("Trial version expired! Contact www.sniperforex.com.");
      return (0);
   }
   int li_16 = IndicatorCounted();
   if (li_16 < 0) li_16 = 0;
   if (li_16 > 0) li_16--;
   int li_12 = Bars - li_16;
   for (int li_20 = 0; li_20 < li_12; li_20++) {
      ld_24 = NormalizeDouble(iSAR(Symbol(), 0, Sniper, SniperSS, li_20), SniperP);
      if (ld_24 >= iHigh(Symbol(), 0, li_20)) {
         if (AlertsEnabled == TRUE && g_ibuf_76[li_20] == 0.0 && Bars > g_bars_108) {
            Alert("Parabolic SAR Going Down on ", Symbol(), "-", Period());
            g_bars_108 = Bars;
         }
         g_ibuf_76[li_20] = ld_24;
         g_ibuf_80[li_20] = 0;
      } else {
         if (AlertsEnabled == TRUE && g_ibuf_80[li_20] == 0.0 && Bars > g_bars_108) {
            Alert("Sniper Trend Directional Change on", Symbol(), "-", Period());
            g_bars_108 = Bars;
         }
         g_ibuf_76[li_20] = 0;
         g_ibuf_80[li_20] = ld_24;
      }
   }
   return (0);
}