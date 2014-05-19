//
//  CPMainWindowController.h
//  CardPodclient
//
//  Created by Patrick Dinger on 10.04.14.
//  Copyright (c) 2014 Patrick Dinger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBook/AddressBookUI.h>

@interface CPMainWindowController : NSObject<NSTableViewDelegate>

@property (weak) IBOutlet NSArrayController *personArrayController;
@property (weak) IBOutlet ABPersonView *selectedPersonView;

@end
