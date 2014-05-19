//
//  CPAddressBookService.h
//  CardPodclient
//
//  Created by Patrick Dinger on 27.03.14.
//  Copyright (c) 2014 Patrick Dinger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface CPAddressBookService : NSObject

+ (CPAddressBookService *)sharedService;
- (void)addNewUsersFromAddressBook;

+ (NSString *)podIdentifierFromPerson:(ABPerson *)person;

- (void)applyDataFromRemoteCardForPerson:(CPPerson *)person;

@end
