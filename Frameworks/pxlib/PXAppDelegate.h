#import <Foundation/Foundation.h>

@interface PXAppDelegate : NSObject<NSApplicationDelegate, NSUserNotificationCenterDelegate>

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+ (instancetype)sharedDelegate;

@end
