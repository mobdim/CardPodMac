//
// Created by Patrick Dinger on 02.04.14.
// Copyright (c) 2014 Patrick Dinger. All rights reserved.
//

#import "CPPodIdentifier.h"


@implementation CPPodIdentifier {
}

// Give me something like that: paxos@hub.de or token:paxos@hub.de
- (instancetype)initWithString:(NSString *)string {
    self = [super init];
    if (self) {
        _string = string;
    }
    return self;
}

- (NSString *)host {
    NSArray *components = [self.string componentsSeparatedByString:@"@"];
    return components[1];
}

- (NSString *)user {
    NSArray *components = [self.string componentsSeparatedByString:@"@"];
    if (!components[0]) {
        return nil;
    }

    NSArray *userComponents = [((NSString *) components[0]) componentsSeparatedByString:@":"];
    if ([userComponents count] > 1) {
        return userComponents[1];
    } else {
        return userComponents[0];
    }
}

- (NSString *)token {
    NSArray *components = [self.string componentsSeparatedByString:@"@"];
    if (!components[0]) {
        return nil;
    }

    NSArray *userComponents = [((NSString *) components[0]) componentsSeparatedByString:@":"];
    if ([userComponents count] > 1) {
        return userComponents[0];
    } else {
        return nil;
    }
}


@end