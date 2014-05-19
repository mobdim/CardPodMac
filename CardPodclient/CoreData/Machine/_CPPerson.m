// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CPPerson.m instead.

#import "_CPPerson.h"


const struct CPPersonAttributes CPPersonAttributes = {
	.firstName = @"firstName",
	.identifier = @"identifier",
	.lastName = @"lastName",
	.lastUpdated = @"lastUpdated",
	.remoteCard = @"remoteCard",
	.uid = @"uid",
};








@implementation CPPersonID
@end

@implementation _CPPerson

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CPPerson" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CPPerson";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CPPerson" inManagedObjectContext:moc_];
}

- (CPPersonID*)objectID {
	return (CPPersonID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic firstName;






@dynamic identifier;






@dynamic lastName;






@dynamic lastUpdated;






@dynamic remoteCard;






@dynamic uid;











@end




