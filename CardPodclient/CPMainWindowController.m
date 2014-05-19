//
//  CPMainWindowController.m
//  CardPodclient
//
//  Created by Patrick Dinger on 10.04.14.
//  Copyright (c) 2014 Patrick Dinger. All rights reserved.
//

#import "CPMainWindowController.h"

@implementation CPMainWindowController

////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSTableViewDelegate

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification {
    NSTableView *tableView = [aNotification object];
    NSInteger selectedRow = [tableView selectedRow];
    if (selectedRow >= 0) {
        CPPerson *selection = [[self.personArrayController arrangedObjects] objectAtIndex:selectedRow];
        if (selection.uid) {
            ABRecord *record = [[ABAddressBook addressBook] recordForUniqueId:selection.uid];
            [self.selectedPersonView setPerson:((ABPerson *)record)];
        }
    }
}

@end
