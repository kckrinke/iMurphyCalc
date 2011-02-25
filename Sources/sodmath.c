//
//  sodmath.h
//  iMurphyCalc
//
//  Created by Kevin C. Krinke on 11-02-03.
//  Copyright 2011  Kevin C. Krinke. All rights reserved.
//

#include "sodmath.h"
#include <math.h>

float mClampF(float value,float min,float max)
{
   if (value > max)
      return max;
   if (value < min)
      return min;
   return value;
}

int mClampI(int value,int min,int max)
{
   if (value > max)
      return max;
   if (value < min)
      return min;
   return value;
}

int array_index_by_custom_perc(float value,float min,float max,int total_indices)
{
   value = mClampF(value,min,max);
   float span = max - min;
   float span_val = value - min;
   float span_perc = span_val / span * 100.0;
   float index_perc = total_indices / 100.0f;
   int result = lroundf(span_perc * index_perc);
   if (result >= total_indices)
      result = total_indices - 1;
   else if (result < 0)
      result = 0;
   return result;
}

float calculate_sod_factor_alt(float urgency,float complexity,float importance,float skill,float frequency)
{
   float step_1 = urgency + complexity + importance;
   float step_2 = 10.0f - skill;
   float step_3 = (step_1 * step_2) / 20.0f;
   float step_4 = frequency / 10.0f;
   float step_5 = sin(step_4);
   float step_6 = 1 / step_5;
   float step_7 = (step_3 * 0.7) * step_6;
   return step_7 / 10.0f;
}

float calculate_sod_factor_orig(float U,float C,float I,float S,float F)
{
   // (((U+C+I) * (1-S))/2) * A * (1/(1-Sin(F)))
   float result = (((U+C+I) * (1.0f-S)) / 2.0f) * 0.7f * (1.0f / (1.0f - sin(F)));
   return result;
}
