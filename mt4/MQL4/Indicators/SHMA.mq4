
#property copyright "Freely Available"
#property link      "keeper-of-the-thatch@thepub.co.za"

#property indicator_chart_window
#property indicator_buffers 3
#property indicator_color1 White
#property indicator_color2 Blue
#property indicator_color3 Red

extern int period = 34;
extern int method = 3;
extern int price = 0;
extern string C = "";
double g_ibuf_96[];
double g_ibuf_100[];
double g_ibuf_104[];
int gi_108 = 0;

int init() {
   gi_108 = TimeCurrent() - TimeCurrent() % (60 * Period()) - 60 * Period();
   IndicatorBuffers(3);
   SetIndexBuffer(1, g_ibuf_96);
   SetIndexBuffer(2, g_ibuf_100);
   SetIndexBuffer(0, g_ibuf_104);
   ArraySetAsSeries(g_ibuf_104, TRUE);
   SetIndexStyle(0, DRAW_LINE, STYLE_SOLID, 2);
   SetIndexStyle(1, DRAW_LINE, STYLE_SOLID, 2);
   SetIndexStyle(2, DRAW_LINE, STYLE_SOLID, 2);
   IndicatorShortName("Hull Moving Average alert(" + period + ")");
   return (0);
}

int deinit() {
   return (0);
}

double WMA(int ai_0, int a_period_4) {
   return (iMA(NULL, 0, a_period_4, 0, method, price, ai_0));
}

int start() {
   int li_0;
   int li_4;
   int li_8;
   int l_period_12;
   int li_16;
   double lda_20[];
   double lda_24[];
   if (C == "Sniper Forex, copyright GJ Pavkovich 88754897533568") {
      li_0 = IndicatorCounted();
      if (li_0 < 0) return (-1);
      if (li_0 > 0) li_0--;
      li_4 = Bars - li_0;
      li_8 = 0;
      l_period_12 = MathSqrt(period);
      li_16 = Bars - li_0 + period + 1;
      if (li_16 > Bars) li_16 = Bars;
      ArrayResize(lda_20, li_16);
      ArraySetAsSeries(lda_20, TRUE);
      ArrayResize(lda_24, li_16);
      ArraySetAsSeries(lda_24, TRUE);
      for (li_8 = 0; li_8 < li_16; li_8++) lda_20[li_8] = 2.0 * WMA(li_8, period / 2) - WMA(li_8, period);
      for (li_8 = 0; li_8 < li_16 - period; li_8++) g_ibuf_104[li_8] = iMAOnArray(lda_20, 0, l_period_12, 0, method, li_8);
      for (li_8 = li_16 - period; li_8 >= 0; li_8--) {
         lda_24[li_8] = lda_24[li_8 + 1];
         if (g_ibuf_104[li_8] > g_ibuf_104[li_8 + 1]) lda_24[li_8] = 1;
         if (g_ibuf_104[li_8] < g_ibuf_104[li_8 + 1]) lda_24[li_8] = -1;
         if (lda_24[li_8] > 0.0) {
            g_ibuf_96[li_8] = g_ibuf_104[li_8];
            if (lda_24[li_8 + 1] < 0.0) g_ibuf_96[li_8 + 1] = g_ibuf_104[li_8 + 1];
            g_ibuf_100[li_8] = EMPTY_VALUE;
         } else {
            if (lda_24[li_8] < 0.0) {
               g_ibuf_100[li_8] = g_ibuf_104[li_8];
               if (lda_24[li_8 + 1] > 0.0) g_ibuf_100[li_8 + 1] = g_ibuf_104[li_8 + 1];
               g_ibuf_96[li_8] = EMPTY_VALUE;
            }
         }
      }
      return (0);
   }
}