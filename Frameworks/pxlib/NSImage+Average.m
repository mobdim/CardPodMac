//
//  NSImage+Average.m
//  episodes2
//
//  Created by Patrick Dinger on 12.04.13.
//  Copyright (c) 2013 skylab. All rights reserved.
//

#import "NSImage+Average.h"
#import <Quartz/Quartz.h>

@implementation NSImage (Average)

- (NSColor *)averageColor {

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);

    NSRect rect = NSMakeRect(0, 0, 1, 1);
    CGImageRef imageRef = [self CGImageForProposedRect:&rect context:nil hints:nil];
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), imageRef);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);

    if(rgba[3] > 0) {
        CGFloat alpha = ((CGFloat)rgba[3])/255.0;
        CGFloat multiplier = alpha/255.0;

        return [NSColor colorWithCalibratedRed:((CGFloat)rgba[0])*multiplier
                               green:((CGFloat)rgba[1])*multiplier
                                blue:((CGFloat)rgba[2])*multiplier
                               alpha:alpha];
    }
    else {
        return [NSColor colorWithCalibratedRed:((CGFloat)rgba[0])/255.0
                               green:((CGFloat)rgba[1])/255.0
                                blue:((CGFloat)rgba[2])/255.0
                               alpha:((CGFloat)rgba[3])/255.0];
    }
}

@end
