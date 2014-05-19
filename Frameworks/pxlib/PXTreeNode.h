#import <Cocoa/Cocoa.h>

// TODO: Move to Application
typedef NS_ENUM(NSUInteger, NSSidebarNodeType) {
    EPSidebarNodeTypeDashboard,
    EPSidebarNodeTypeShow,
    EPSidebarNodeTypeRootNode,
    EPSidebarNodeTypeUpNext
};

@interface PXTreeNode : NSTreeNode

@property (copy) NSString *name;
@property (assign) NSUInteger nodeType;
@property (copy, nonatomic) NSImage *icon;
@property (copy) NSColor *textColor;

+ (id)treeNodeWithRepresentedObject:(id)modelObject name:(NSString *)name;
- (id)initWithRepresentedObject:(id)modelObject name:(NSString *)name;

@end
