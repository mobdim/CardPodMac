//
//  CPPodIdentifierTests.m
//  CardPodclient
//
//  Created by Patrick Dinger on 02.04.14.
//  Copyright (c) 2014 Patrick Dinger. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CPPodIdentifier.h"

@interface CPPodIdentifierTests : XCTestCase

@end

@implementation CPPodIdentifierTests

- (void)testWithToken
{
    CPPodIdentifier *identifier = [[CPPodIdentifier alloc] initWithString:@"token:paxos@pod.host"];
    XCTAssertEqualObjects([identifier host], @"pod.host", @"");
    XCTAssertEqualObjects([identifier user], @"paxos", @"");
    XCTAssertEqualObjects([identifier token], @"token", @"");
}

- (void)testWithoutToken
{
    CPPodIdentifier *identifier = [[CPPodIdentifier alloc] initWithString:@"paxos@pod.host"];
    XCTAssertEqualObjects([identifier host], @"pod.host", @"");
    XCTAssertEqualObjects([identifier user], @"paxos", @"");
    XCTAssertEqualObjects([identifier token], nil, @"");
}

- (void)testWithDebugSetting {
    CPPodIdentifier *identifier = [[CPPodIdentifier alloc] initWithString:@"testboy@cardhubdev.eu:3000"];
    XCTAssertEqualObjects([identifier host], @"cardhubdev.eu:3000", @"");
    XCTAssertEqualObjects([identifier user], @"testboy", @"");
    XCTAssertEqualObjects([identifier token], nil, @"");
}

@end
