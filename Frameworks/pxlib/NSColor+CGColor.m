//
//  NSColor+CGColor.m
//  episodes2
//
//  Created by Patrick Dinger on 21.04.13.
//  Copyright (c) 2013 skylab. All rights reserved.
//

#import "NSColor+CGColor.h"

@implementation NSColor (CGColor)

- (CGColorRef)_CGColor
{
    const NSInteger numberOfComponents = [self numberOfComponents];
    CGFloat components[numberOfComponents];
    CGColorSpaceRef colorSpace = [[self colorSpace] CGColorSpace];

    [self getComponents:(CGFloat *)&components];

    return (__bridge CGColorRef)(__bridge id)CGColorCreate(colorSpace, components);
}

+ (NSColor *)_colorWithCGColor:(CGColorRef)CGColor
{
    if (CGColor == NULL) return nil;
    return [NSColor colorWithCIColor:[CIColor colorWithCGColor:CGColor]];
}


@end
