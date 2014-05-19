//
//  CPAppDelegate.h
//  CardPodclient
//
//  Created by Patrick Dinger on 27.11.13.
//  Copyright (c) 2013 Patrick Dinger. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PXLib/PXLib.h>
#import <AddressBook/AddressBook.h>
#import <AddressBook/AddressBookUI.h>

@interface CPAppDelegate : PXAppDelegate <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:(id)sender;
@property (weak) IBOutlet NSArrayController *tableController;


@property (weak) IBOutlet ABPersonView *mePersonView;

@end
