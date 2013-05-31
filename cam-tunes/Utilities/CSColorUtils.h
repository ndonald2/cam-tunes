//
//  CSColorUtils.h
//  CameraSound
//
//  Created by Nick Donaldson on 11/2/12.
//  Copyright (c) 2012 Nick Donaldson. All rights reserved.
//

typedef struct {
    float hue;
    float sat;
    float bright;
} CSPixelHSBFloat;

extern void hsbFloatFromRGB(unsigned char r, unsigned char g, unsigned char b, CSPixelHSBFloat *hsbOut);
extern void hsbFloatFromBGRAPixel(unsigned char * const pixel, CSPixelHSBFloat *hsbOut);
