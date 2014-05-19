//
//  PXEmptyBox.m
//  episodes2
//
//  Created by Patrick Dinger on 08.02.13.
//  Copyright (c) 2013 skylab. All rights reserved.
//

#import "PXEmptyBox.h"

@implementation PXEmptyBox

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.borderType = NSNoBorder;
        self.title = @"";
        self.titlePosition = NSNoTitle;
        self.boxType = NSBoxCustom;
        self.contentViewMargins = NSMakeSize(0, 0);
    }

    return self;
}

@end
