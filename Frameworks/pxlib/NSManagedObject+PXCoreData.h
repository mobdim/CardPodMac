#import <CoreData/CoreData.h>

@interface NSManagedObject (PXCoreData)

+ (NSString *)entityName;
+ (NSEntityDescription *)entity;
+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext;

+ (id)newManagedObject;
+ (id)newManagedObjectInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

+ (NSUInteger)countEntity:(NSEntityDescription *)anEntity predicate:(NSPredicate *)aPredicate error:(__autoreleasing NSError **)anError;

+ (NSUInteger)countEntity:(NSEntityDescription *)anEntity predicate:(NSPredicate *)aPredicate error:(__autoreleasing NSError **)anError managedObjectContext:(NSManagedObjectContext *)aContext;

+ (NSUInteger)countAll:(NSError * __autoreleasing *)error;
+ (NSUInteger)countAllInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext error:(NSError * __autoreleasing *)error;

+ (NSArray *)fetchAll:(NSError * __autoreleasing *)error;
+ (NSArray *)fetchAllInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext error:(NSError * __autoreleasing *)error;

+ (NSArray *)fetchAllWithSortDescriptors:(NSArray *)sortDescriptors error:(NSError * __autoreleasing *)error;
+ (NSArray *)fetchAllWithSortDescriptors:(NSArray *)sortDescriptors inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext withError:(NSError * __autoreleasing *)error;

+ (id)fetchWithPredicate:(NSPredicate *)predicate error:(__autoreleasing NSError **)error;
+ (id)fetchWithPredicate:(NSPredicate *)predicate inManagedObjectContext:(NSManagedObjectContext *)context error:(__autoreleasing NSError **)error;

+ (id)fetchFirstWithPredicate:(NSPredicate *)predicate error:(NSError *__autoreleasing *)error;
+ (id)fetchFirstWithPredicate:(NSPredicate *)predicateString inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext error:(NSError *__autoreleasing *)error;

+ (id)fetchFirstByAttribute:(NSString *)attribute withValue:(id)value error:(NSError *__autoreleasing *)error;
+ (id)fetchFirstByAttribute:(NSString *)attribute withValue:(id)value inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext error:(NSError *__autoreleasing *)error;

- (void)destroy;

@end
