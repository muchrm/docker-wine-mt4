
#property copyright "Copyright © 2007, www.sniperforex.com"
#property link      "www.sniperforex.com"

#property indicator_separate_window
#property indicator_buffers 2
#property indicator_color1 Blue
#property indicator_color2 Red

double gd_76 = 5000.0;
double gd_unused_84 = 0.0;
double g_ibuf_92[];
double g_ibuf_96[];
double gd_100;

int init() {
   SetIndexStyle(0, DRAW_HISTOGRAM);
   SetIndexBuffer(0, g_ibuf_92);
   SetIndexEmptyValue(0, 0.0);
   SetIndexStyle(1, DRAW_HISTOGRAM);
   SetIndexBuffer(1, g_ibuf_96);
   SetIndexEmptyValue(1, 0.0);
   gd_100 = MarketInfo(Symbol(), MODE_SPREAD) * Point;
   return (0);
}

int deinit() {
   return (0);
}

int start() {
   double lda_64[100];
   string ls_0 = "2020.09.09";
   int l_str2time_8 = StrToTime(ls_0);
   if (TimeCurrent() >= l_str2time_8) {
      Alert("Trial version expired! Contact www.sniperforex.com.");
      return (0);
   }
   int li_unused_12 = IndicatorCounted();
   int li_16 = 7;
   double ld_20 = 0.7;
   int l_bars_28 = 2000;
   int li_32 = 0;
   bool li_36 = TRUE;
   double ld_40 = 0;
   double ld_48 = 0;
   double ld_56 = 0;
   int l_index_68 = 0;
   double ld_72 = 0;
   int l_index_80 = 0;
   double ld_84 = 0;
   double ld_92 = 0;
   double ld_100 = 0;
   int li_108 = 0;
   int li_112 = 0;
   double ld_116 = 0;
   double ld_124 = 2;
   double ld_unused_132 = 10;
   double ld_unused_140 = 0;
   double ld_unused_148 = 0;
   double ld_unused_156 = 0;
   double ld_unused_164 = 0;
   double ld_unused_172 = 0;
   double ld_unused_180 = 0;
   double ld_unused_188 = 0;
   double ld_unused_196 = 0;
   double ld_unused_204 = 0;
   double ld_unused_212 = 0;
   double ld_unused_220 = 0;
   double ld_unused_228 = 0;
   double ld_unused_236 = 0;
   double ld_unused_244 = 0;
   double ld_unused_252 = 0;
   double ld_unused_260 = 0;
   double ld_unused_268 = 0;
   double ld_unused_276 = 0;
   double ld_unused_284 = 0;
   double ld_unused_292 = 0;
   double ld_unused_300 = 0;
   double ld_unused_308 = 0;
   double ld_unused_316 = 0;
   double ld_unused_324 = 0;
   if (Bars < gd_76) l_bars_28 = Bars;
   else l_bars_28 = gd_76;
   if (Close[l_bars_28 - 2] > Close[l_bars_28 - 1]) li_36 = TRUE;
   else li_36 = FALSE;
   ld_40 = Close[l_bars_28 - 2];
   for (li_32 = l_bars_28 - 3; li_32 >= 0; li_32--) {
      ld_56 = gd_100 + High[li_32] - Low[li_32];
      if (MathAbs(gd_100 + High[li_32] - (Close[li_32 + 1])) > ld_56) ld_56 = MathAbs(gd_100 + High[li_32] - (Close[li_32 + 1]));
      if (MathAbs(Low[li_32] - (Close[li_32 + 1])) > ld_56) ld_56 = MathAbs(Low[li_32] - (Close[li_32 + 1]));
      if (li_32 == l_bars_28 - 3) for (l_index_80 = 0; l_index_80 <= li_16 - 1; l_index_80++) lda_64[l_index_80] = ld_56;
      lda_64[l_index_68] = ld_56;
      ld_72 = 0;
      ld_84 = li_16;
      li_112 = l_index_68;
      for (l_index_80 = 0; l_index_80 <= li_16 - 1; l_index_80++) {
         ld_72 += lda_64[li_112] * ld_84;
         ld_84 -= 1.0;
         li_112--;
         if (li_112 == -1) li_112 = li_16 - 1;
      }
      ld_72 = 2.0 * ld_72 / (li_16 * (li_16 + 1.0));
      l_index_68++;
      if (l_index_68 == li_16) l_index_68 = 0;
      ld_48 = ld_20 * ld_72;
      if (li_36 && Low[li_32] < ld_40 - ld_48) {
         li_36 = FALSE;
         ld_40 = gd_100 + High[li_32];
      }
      if (!li_36 && gd_100 + High[li_32] > ld_40 + ld_48) {
         li_36 = TRUE;
         ld_40 = Low[li_32];
      }
      if (li_36 && Low[li_32] > ld_40) ld_40 = Low[li_32];
      if (!li_36 && gd_100 + High[li_32] < ld_40) ld_40 = gd_100 + High[li_32];
      ld_116 = iATR(NULL, 0, 10, li_32) + gd_100 / 10.0;
      if (li_36) {
         if (Low[li_32] - ld_116 * ld_124 < ld_92 && ld_92 != 0.0) ld_100 = ld_92;
         else ld_100 = Low[li_32] - ld_116 * ld_124 / 3.0;
         if (li_108 == 2) ld_100 = Low[li_32] - ld_116 * ld_124 / 3.0;
         g_ibuf_92[li_32] = ld_100;
         g_ibuf_96[li_32] = 0;
         ld_92 = ld_100;
         li_108 = 1;
      } else {
         if (gd_100 + High[li_32] + ld_116 * ld_124 > ld_92 && ld_92 != 0.0) ld_100 = ld_92;
         else ld_100 = gd_100 + High[li_32] + ld_116 * ld_124 / 3.0;
         if (li_108 == 1) ld_100 = gd_100 + High[li_32] + ld_116 * ld_124 / 3.0;
         g_ibuf_92[li_32] = 0;
         g_ibuf_96[li_32] = ld_100;
         ld_92 = ld_100;
         li_108 = 2;
      }
   }
   return (0);
}