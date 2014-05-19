//
// Created by Patrick Dinger on 02.04.14.
// Copyright (c) 2014 Patrick Dinger. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CPPodIdentifier : NSObject

- (instancetype)initWithString:(NSString *)string;

@property (readwrite, nonatomic, copy) NSString *string;

- (NSString *)host;
- (NSString *)user;
- (NSString *)token;

@end