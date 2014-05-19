//
//  NSString+UID.m
//  episodes2
//
//  Created by Patrick Dinger on 13.04.13.
//  Copyright (c) 2013 skylab. All rights reserved.
//

#import "NSString+UID.h"

@implementation NSString (UID)

+ (NSString *)makeUID {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge_transfer NSString *)string;
}

@end
