#import <AppKit/AppKit.h>
@class CATransition;

@interface NSViewController (PXAppKit)

+ (id)controller;
+ (NSString *)defaultNibName;

- (id)initWithDefaultNibName __attribute__((deprecated));

+ (void)replaceViewInContainerView:(NSView *)containerView withView:(NSView *)newView;
+ (void)replaceViewInContainerView:(NSView *)containerView withView:(NSView *)newView transition:(CATransition *)transition;

@end
