//
//  sodmath.h
//  iMurphyCalc
//
//  Created by Kevin C. Krinke on 11-02-03.
//  Copyright 2011  Kevin C. Krinke. All rights reserved.
//

/**
 Clamp a given float value between minumum and maximum values
 */
float mClampF(float value,float min,float max);

/**
 Clamp a given integer value between minimum and maximum values
 */
int mClampI(int value,int min,int max);

/**
 The purpose of this function is to help determin which index of an array is
 suitable based on a given value within an arbitrary range. As an example;
 there are 13 items in an array with a slider that varies between 1.0 and 9.0.
 Given a slider value of 9.0 the result would be 12 and given a slider value
 of 1.0 the result would be 0.
 */
int array_index_by_custom_perc(float value,float min,float max,int num_indices);

/**
 The British Gas study on Murphy's Law (aka: Sod's Law) resulted in two
 mathmatical formulas but not on purpose. The original formula somehow got lost
 in translation when the reporters made their headlines and a slightly different
 formula was advertised. This function evaluates the "reported" formula.

 All variable arguments are of the range 1.0f - 9.0f
 */
float calculate_sod_factor_alt(float urgency,float complexity,float importance,float skill,float frequency);

/**
 The British Gas study on Murphy's Law (aka: Sod's Law) resulted in two
 mathmatical formulas but not on purpose. The original formula somehow got lost
 in translation when the reporters made their headlines and a slightly different
 formula was advertised. This function evaluates the "original" formula.

 All variable arguments are of the range >0 and <1
*/
float calculate_sod_factor_orig(float U,float C,float I,float S,float F);
