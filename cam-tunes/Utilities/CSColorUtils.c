//
//  CSColorUtils.c
//  CameraSound
//
//  Created by Nick Donaldson on 11/2/12.
//  Copyright (c) 2012 Nick Donaldson. All rights reserved.
//

#include "CSColorUtils.h"
#include <math.h>

void hsbFloatFromRGB(unsigned char r, unsigned char g, unsigned char b, CSPixelHSBFloat *hsbOut)
{
    
    float rf = r / 255.0f;
    float gf = g / 255.0f;
    float bf = b / 255.0f;
    float max = fmaxf(fmaxf(rf, gf), bf);
    float min = fminf(fminf(rf, gf), bf);
    float delta = max - min;
    if (delta != 0)
    {
        float hue;
        if (rf == max)
        {
            hue = (gf - bf) / delta;
        }
        else
        {
            if (gf == max)
            {
                hue = 2 + (bf - rf) / delta;
            }
            else
            {
                hue = 4 + (rf - gf) / delta;
            }
        }
        hue *= 60;
        if (hue < 0) hue += 360;
        hsbOut->hue = hue;
    }
    else
    {
        hsbOut->hue = 0;
    }
    hsbOut->sat = max == 0 ? 0 : (max - min) / max;
    hsbOut->bright = max;
}

extern void hsbFloatFromBGRAPixel(unsigned char * const pixel, CSPixelHSBFloat *hsbOut)
{
    hsbFloatFromRGB(pixel[2], pixel[1], pixel[0], hsbOut);
}