//
//  EPAppDelegate.m
//  PXLib
//
//  Created by Patrick Dinger on 23.04.13.
//  Copyright (c) 2013 skylab. All rights reserved.
//

#import "PXAppDelegate.h"

@implementation PXAppDelegate

+ (instancetype)sharedDelegate {
    return [NSApp delegate];
}

@end
