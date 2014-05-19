//
//  CPCardRemoteService.h
//  CardPodclient
//
//  Created by Patrick Dinger on 02.04.14.
//  Copyright (c) 2014 Patrick Dinger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPCardRemoteService : NSObject

+ (CPCardRemoteService *)sharedService;

- (void)fetchRemoteCardsForAllUsers;


- (void)uploadMyCard;
@end
