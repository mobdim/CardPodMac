#import "NSManagedObjectContext+PXCoreData.h"
#import "PXAppDelegate.h"

static NSManagedObjectContext *_defaultManagedObjectContext = nil;


@implementation NSManagedObjectContext (PXCoreData)

// //////////////////////////////////////////////////////////////////////////////
#pragma mark - Setting and Retrieving the Default Managed Object Context

+ (void)setDefaultManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    _defaultManagedObjectContext = managedObjectContext;
}

// //////////////////////////////////////////////////////////////////////////////
#pragma mark - Retrieving the Main Managed Object Context

+ (NSManagedObjectContext *)__backgroundContextForTests {
    NSManagedObjectContext *backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];

    backgroundContext.parentContext = [self mainManagedObjectContext];
    return backgroundContext;
}

// //////////////////////////////////////////////////////////////////////////////
#pragma mark - Retrieving Child Contexts

- (NSManagedObjectContext *)childContext {
    return [self childContextWithType:NSPrivateQueueConcurrencyType];
}

- (NSManagedObjectContext *)childContextWithType:(NSManagedObjectContextConcurrencyType)type {
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:type];

    [context setParentContext:self];
    [context setUndoManager:nil];
    return context;
}

+ (void)load {
    //
    //  TODO: Sometimes this doesn't work
    //  Please use safeAsync if possible
    //
    //  MethodSwizzle(self, @selector(save:), @selector(px_saveSync:));
    //
}

- (BOOL)px_saveToRoot:(NSError * __autoreleasing *)error {
    __block BOOL success;

    [self performBlockAndWait:^{
         success = [self save:error];
         if (!success) {
             NSLog (@"Unable to save MOC %@ :: Error %@ (UserInfo: %@)", self, [*error localizedDescription], [*error userInfo]);
             return;
         }
         NSLog (@"MOC %@ did save", self);
         if (self.parentContext) {
             success = [self.parentContext px_saveToRoot:error];
         }
     }];
    return success;
}

- (void)px_saveToRootInBackground {
    NSError *error;
    BOOL success = [self px_saveToRoot:&error];

    if (!success) {
        NSLog(@"Unable to save MOC %@ :: Error %@ (UserInfo: %@)", self, [error localizedDescription], [error userInfo]);
    }
    NSLog(@"MOC %@ did save", self);
    NSManagedObjectContext *parent = self.parentContext;
    if (parent) {
        [parent performBlock:^{
             [parent px_saveToRootInBackground];
         }];
    }
}

+ (NSManagedObjectContext *)mainManagedObjectContext {
    PXAppDelegate *appDelegate = [PXAppDelegate sharedDelegate];
    if (appDelegate) {
        return appDelegate.managedObjectContext;
    }
    return nil;
}


@end
