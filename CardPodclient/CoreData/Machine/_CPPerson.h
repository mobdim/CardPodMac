// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CPPerson.h instead.

#import <CoreData/CoreData.h>



extern const struct CPPersonAttributes {
	__unsafe_unretained NSString *firstName;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *lastName;
	__unsafe_unretained NSString *lastUpdated;
	__unsafe_unretained NSString *remoteCard;
	__unsafe_unretained NSString *uid;
} CPPersonAttributes;






















@interface CPPersonID : NSManagedObjectID {}
@end

@interface _CPPerson : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (CPPersonID*)objectID;





@property (nonatomic, strong) NSString* firstName;



//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* identifier;



//- (BOOL)validateIdentifier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* lastName;



//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* lastUpdated;



//- (BOOL)validateLastUpdated:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSData* remoteCard;



//- (BOOL)validateRemoteCard:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* uid;



//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;






@end



@interface _CPPerson (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;




- (NSString*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSString*)value;




- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;




- (NSDate*)primitiveLastUpdated;
- (void)setPrimitiveLastUpdated:(NSDate*)value;




- (NSData*)primitiveRemoteCard;
- (void)setPrimitiveRemoteCard:(NSData*)value;




- (NSString*)primitiveUid;
- (void)setPrimitiveUid:(NSString*)value;




@end
