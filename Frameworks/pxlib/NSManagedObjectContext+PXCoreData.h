#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (PXCommon)

// //////////////////////////////////////////////////////////////////////////////
#pragma mark - Setting and Retrieving the Default Managed Object Context

/** @name Setting and Retrieving the Default Managed Object Context */

/**
   Sets the default Managed Object Context used by the default Core Data stack. This will also be the
   Managed Object Context for the main thread.

   @param managedObjectModel A Managed Object Context that should be the default used by the default Core Data stack
 */
+ (void)setDefaultManagedObjectContext:(NSManagedObjectContext *)managedObjectContext __deprecated;

/**
   Save all pending changes via performBlock().
   Error will be logged to console via DDLogError().
   If the context has a parentContext, -px_saveToRootInBackground is called on the parent.
 */
- (void)px_saveToRootInBackground;
/**
   Save all pending changes via performBlockAndWait()
   If the context has a background parentContext, -px_saveToRoot is called on the parent.
   Return immediately if an error occurs
 */
- (BOOL)px_saveToRoot:(NSError * __autoreleasing *)error;

/**
   Retrieves the current default Managed Object Context used by the default Core Data stack.
   @returns The default Managed Object Context used by the default Core Data stack
 */
+ (NSManagedObjectContext *)defaultManagedObjectContext __deprecated;

// //////////////////////////////////////////////////////////////////////////////
#pragma mark - Retrieving the Main Managed Object Context

/** @name Retrieving the Main Managed Object Context */

/**
   Return the `NSManagedObjectContext` that is used on the main queue (NSMainQueueConcurrencyType)
 */
+ (NSManagedObjectContext *)mainManagedObjectContext;
/**
   Return the `NSManagedObjectContext` that is used on a background queue (NSPrivateQueueConcurrencyType)
 */
+ (NSManagedObjectContext *)backgroundManagedObjectContext;

// //////////////////////////////////////////////////////////////////////////////
#pragma mark - Retrieving Child Contexts

/** @name Retrieving Child Contexts */

/*
   Create new NSManagedObjectContext and self as parent.
   Default type is NSPrivateQueueConcurrencyType
 */
- (NSManagedObjectContext *)childContext;
- (NSManagedObjectContext *)childContextWithType:(NSManagedObjectContextConcurrencyType)type;

// //////////////////////////////////////////////////////////////////////////////
#pragma mark - For Unit Testing

+ (void)tearDownAllContexts;

@end
