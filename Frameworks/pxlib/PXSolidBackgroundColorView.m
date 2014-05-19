//
//  PXSolidBackgroundColorView.m
//  episodes2
//
//  Created by Patrick Dinger on 31.03.13.
//  Copyright (c) 2013 skylab. All rights reserved.
//

#import "PXSolidBackgroundColorView.h"

@implementation PXSolidBackgroundColorView

- (void)drawRect:(NSRect)dirtyRect
{
    [self.backgroundColor setFill];
    NSRectFill(self.bounds);
}

@end
