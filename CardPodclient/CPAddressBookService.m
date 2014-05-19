//
//  CPAddressBookService.m
//  CardPodclient
//
//  Created by Patrick Dinger on 27.03.14.
//  Copyright (c) 2014 Patrick Dinger. All rights reserved.
//

#import "CPAddressBookService.h"
#import "CPAppDelegate.h"

@implementation CPAddressBookService

static CPAddressBookService *sharedService = nil;

+ (CPAddressBookService *)sharedService {
    if (nil != sharedService) {
        return sharedService;
    }

    static dispatch_once_t pred;        // Lock
    dispatch_once(&pred, ^{             // This code is called at most once per app
        sharedService = [[[self class] alloc] init];
    });

    return sharedService;
}

- (void)addNewUsersFromAddressBook {
    ABAddressBook *addressBook = [ABAddressBook addressBook];

    ABSearchElement *cardPodAttributeIsNotEmpty =
    [ABPerson searchElementForProperty:kABSocialProfileProperty
                                 label:@"cardPod"
                                   key:nil
                                 value:nil
                            comparison:kABNotEqual];

    // Array of ABPerson
    NSArray *addressBookUsers = [addressBook recordsMatchingSearchElement:cardPodAttributeIsNotEmpty];

    for (ABPerson *person in addressBookUsers) {

        NSString *identifier = [CPAddressBookService podIdentifierFromPerson:person];

        if (PXIsEmptyString(identifier)) {
            continue;
        }

        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@",@"identifier", identifier];
        NSError *error;
        NSUInteger personCount = [CPPerson countEntity:[CPPerson entity] predicate:predicate error:&error];

        // if not existing, add new user
        if (personCount == 0) {
            CPPerson *newPerson = [CPPerson newManagedObject];
            newPerson.identifier = identifier;
            newPerson.firstName = [person valueForProperty:kABFirstNameProperty];
            newPerson.lastName = [person valueForProperty:kABLastNameProperty];
            newPerson.uid = person.uniqueId;
        }

        //  CPUs
        // [[CPAppDelegate sharedDelegate] managedObjectContext] fet
        
    }
    
    
}

+ (NSString *)podIdentifierFromPerson:(ABPerson *)person {

    NSString *identifier;
    ABMultiValue *socialProperties = [person valueForProperty:kABSocialProfileProperty];
    NSUInteger socialPropertiesCount = [socialProperties count];

    // find the cardpod username
    for (int i = 0; i <= socialPropertiesCount; ++i) {
        NSString *labelAtIndex = [socialProperties labelAtIndex:i];

        if ([labelAtIndex isEqualToString:@"cardPod"]) {
            identifier = [[socialProperties valueAtIndex:i] valueForKey:@"username"];
            break;
        }
    }

    return identifier;
}

- (void)applyDataFromRemoteCardForPerson:(CPPerson *)person {
    ABAddressBook *addressBook = [ABAddressBook addressBook];
    ABPerson *remoteRecord = [[ABPerson alloc] initWithVCardRepresentation:person.remoteCard];

    // It should be a ABRecord, but its a ABPerson in fact which is good (need that for picture management)
    id something = [addressBook recordForUniqueId:person.uid];
    if (![something isKindOfClass:[ABPerson class]]) {
        return;
    }

    ABPerson *currentRecord = ((ABPerson *)[addressBook recordForUniqueId:person.uid]);

    if (currentRecord && remoteRecord) {

        NSArray *properties = @[
                                kABFirstNameProperty,
                                kABLastNameProperty,
                                kABFirstNamePhoneticProperty,
                                kABLastNamePhoneticProperty,
                                kABNicknameProperty,
                                kABMaidenNameProperty,
                                kABBirthdayProperty,
                                kABBirthdayComponentsProperty,
                                kABOrganizationProperty,
                                kABJobTitleProperty,
                                kABHomePageProperty,
                                kABURLsProperty,
                                kABCalendarURIsProperty,
                                kABEmailProperty,
                                kABAddressProperty,
                                kABOtherDatesProperty,
                                kABOtherDateComponentsProperty,
                                kABRelatedNamesProperty,
                                kABDepartmentProperty,
                                kABPersonFlags,
                                kABPhoneProperty,
                                kABInstantMessageProperty,
//                                kABAIMInstantProperty,
//                                kABJabberInstantProperty,
//                                kABMSNInstantProperty,
//                                kABYahooInstantProperty,
//                                kABICQInstantProperty,
                                kABNoteProperty,
                                kABSocialProfileProperty,
                                kABMiddleNameProperty,
                                kABMiddleNamePhoneticProperty,
                                kABTitleProperty,
                                kABSuffixProperty
                                ];

        for (NSString *property in properties) {
            [currentRecord setValue:[remoteRecord valueForProperty:property] forProperty:property];
            [currentRecord setValue:[remoteRecord valueForProperty:property] forProperty:property];
        }

        // what about the picture?
        NSData *picture = remoteRecord.imageData;
        if (picture) {
            [currentRecord setImageData:picture];
        }
    }

    NSError *error;
    BOOL saved = [addressBook saveAndReturnError:&error];
    if (!saved) {
        NSLog(@"%@",[error localizedDescription]);
    }
}



@end
