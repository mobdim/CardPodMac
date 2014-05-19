#import "NSManagedObject+PXCoreData.h"
#import "NSManagedObjectContext+PXCoreData.h"

@implementation NSManagedObject (PXCoreData)

+ (NSString *)entityName {
    return [self className];
}

+ (NSEntityDescription *)entity {
    return [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:[NSManagedObjectContext mainManagedObjectContext]];
}

+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    return [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:managedObjectContext];
}

+ (id)newManagedObject {
    return [self newManagedObjectInManagedObjectContext:[NSManagedObjectContext mainManagedObjectContext]];
}

+ (id)newManagedObjectInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    NSEntityDescription *entity = [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:managedObjectContext];

    return [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:managedObjectContext];
}

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    if (!(self = [self initWithEntity:[[self class] entityInManagedObjectContext:managedObjectContext] insertIntoManagedObjectContext:managedObjectContext])) {
        return nil;
    }

    return self;
}

+ (NSUInteger)countEntity:(NSEntityDescription *)anEntity predicate:(NSPredicate *)aPredicate error:(NSError * __autoreleasing *)anError {
    return [self countEntity:anEntity predicate:aPredicate error:anError managedObjectContext:[NSManagedObjectContext mainManagedObjectContext]];
}

+ (NSUInteger)countEntity:(NSEntityDescription *)anEntity predicate:(NSPredicate *)aPredicate error:(NSError * __autoreleasing *)anError managedObjectContext:(NSManagedObjectContext *)aContext {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];

    [request setEntity:anEntity];
    [request setPredicate:aPredicate];
    NSUInteger count = [aContext countForFetchRequest:request error:anError];
    return count;
}

+ (NSUInteger)countAll:(NSError * __autoreleasing *)error {
    return [self countAllInManagedObjectContext:[NSManagedObjectContext mainManagedObjectContext] error:error];
}

+ (NSUInteger)countAllInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext error:(NSError * __autoreleasing *)error {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];

    [request setEntity:[self entityInManagedObjectContext:managedObjectContext]];
    return [managedObjectContext countForFetchRequest:request error:error];
}

+ (NSArray *)fetchAll:(NSError * __autoreleasing *)error {
    return [self fetchAllWithSortDescriptors:nil inManagedObjectContext:[NSManagedObjectContext mainManagedObjectContext] withError:error];
}

+ (NSArray *)fetchAllInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext error:(NSError * __autoreleasing *)error {
    return [self fetchAllWithSortDescriptors:nil inManagedObjectContext:managedObjectContext withError:error];
}

+ (NSArray *)fetchAllWithSortDescriptors:(NSArray *)sortDescriptors error:(NSError * __autoreleasing *)error {
    return [self fetchAllWithSortDescriptors:sortDescriptors inManagedObjectContext:[NSManagedObjectContext mainManagedObjectContext] withError:error];
}

+ (NSArray *)fetchAllWithSortDescriptors:(NSArray *)sortDescriptors inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext withError:(NSError * __autoreleasing *)error {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];

    [request setEntity:[self entityInManagedObjectContext:managedObjectContext]];

    if (sortDescriptors) {
        [request setSortDescriptors:sortDescriptors];
    }

    return [managedObjectContext executeFetchRequest:request error:error];
}

+ (id)fetchWithPredicate:(NSPredicate *)predicate error:(NSError * __autoreleasing *)error {
    return [self fetchWithPredicate:predicate inManagedObjectContext:[NSManagedObjectContext mainManagedObjectContext] error:error];
}

+ (id)fetchWithPredicate:(NSPredicate *)predicate inManagedObjectContext:(NSManagedObjectContext *)context error:(NSError * __autoreleasing *)error {
    NSFetchRequest *fetchRequest = [NSFetchRequest new];

    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:[self entityInManagedObjectContext:context]];
    NSArray *objects = [context executeFetchRequest:fetchRequest error:error];
    return objects;
}

+ (id)fetchFirstWithPredicate:(NSPredicate *)predicate error:(NSError * __autoreleasing *)error
{
    return [self fetchFirstWithPredicate:predicate inManagedObjectContext:nil error:error];
}

+ (id)fetchFirstWithPredicate:(NSPredicate *)predicate inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext error:(NSError * __autoreleasing *)error
{
    NSManagedObject *result;
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    NSManagedObjectContext *context = (managedObjectContext != nil) ? managedObjectContext : [NSManagedObjectContext mainManagedObjectContext];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:[self entityInManagedObjectContext:context]];
    NSArray *objects = [context executeFetchRequest:fetchRequest error:error];
    if ([objects count] == 0) {
        return nil;
    }
//    NSAssert([objects count] <= 1, @"You asked to fetch a single entity of %@ with predicate %@ but the store contains %ld objects that match this predicate.\n%@", [self entityName], [predicate description], [objects count], objects);
    result = objects[0];
    return result;
}

+ (id)fetchFirstByAttribute:(NSString *)attribute withValue:(id)value error:(NSError * __autoreleasing *)error {
    return [self fetchFirstByAttribute:attribute withValue:value inManagedObjectContext:[NSManagedObjectContext mainManagedObjectContext] error:error];
}

+ (id)fetchFirstByAttribute:(NSString *)attribute withValue:(id)value inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext error:(NSError * __autoreleasing *)error {
    NSManagedObjectContext *context = (managedObjectContext != nil) ? managedObjectContext : [NSManagedObjectContext mainManagedObjectContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    [fetchRequest setEntity:[self entityInManagedObjectContext:context]];
    [fetchRequest setFetchLimit:1];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", attribute, value];
    [fetchRequest setPredicate:predicate];

    NSArray *objects = [context executeFetchRequest:fetchRequest error:error];
    NSManagedObject *result = objects[0];
    return result;
}

- (void)destroy {
    [[self managedObjectContext] deleteObject:self];
}

@end
