//
//  PXTreeNode.m
//  episodes2
//
//  Created by Patrick Dinger on 14.02.13.
//  Copyright (c) 2013 skylab. All rights reserved.
//

#import "PXTreeNode.h"

@implementation PXTreeNode

+ (id)treeNodeWithRepresentedObject:(id)modelObject name:(NSString *)name {
    PXTreeNode *object = [super treeNodeWithRepresentedObject:modelObject];

    object.name = name;
    return object;
}

- (id)initWithRepresentedObject:(id)modelObject name:(NSString *)name {
    self = [super initWithRepresentedObject:modelObject];
    if (self) {
        self.name = name;
    }
    return self;
}

//- (NSString *)description {
//    return self.name;
//}

//- (NSUInteger)hash {
//    return self.hash;
//}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        BOOL result = self.representedObject == object;
//        DDLogVerbose(@"%@ - %@", self.name, [object name]);
        return result;
    }
    return NO;
}

- (NSUInteger)hash {
//    DDLogVerbose(@"hash of %ul, %@", [self.name hash], self.name);
    return [self.name hash];
}

- (id)copyWithZone:(NSZone *)zone {
    PXTreeNode *node = [[PXTreeNode alloc] initWithRepresentedObject:self.representedObject name:self.name];
    node.nodeType = self.nodeType;
    node.icon = self.icon;
    return node;
}


@end
