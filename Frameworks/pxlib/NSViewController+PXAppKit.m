#import "NSViewController+PXAppKit.h"
#import <Quartz/Quartz.h>

@implementation NSViewController (PXAppKit)

#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Factory Methods

+ (id)controller {
    return [[self alloc] initWithNibName:[self defaultNibName] bundle:nil];
}

+ (NSString *)defaultNibName
{
    NSString *className = NSStringFromClass(self);
    NSString *defaultNibName;
    NSRange range = [className rangeOfString:@"Controller" options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch|NSBackwardsSearch)];
    if (range.location != NSNotFound)
    {
        defaultNibName = [className substringToIndex:range.location];
        return defaultNibName;
    }
    else
    {
        return nil;
    }
}

#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Initialization

- (id)initWithDefaultNibName {
    NSString *className = NSStringFromClass([self class]);
    NSString *defaultNibName;
    NSRange range = [className rangeOfString:@"Controller" options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch|NSBackwardsSearch)];
    if (range.location != NSNotFound)
    {
        defaultNibName = [className substringToIndex:range.location];
        return [self initWithNibName:defaultNibName bundle:nil];
    }
    else
    {
        return nil;
    }
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - View Switchting

+ (void)replaceViewInContainerView:(NSView *)containerView withView:(NSView *)newView {

    NSView *currentView = [[containerView subviews] lastObject];

    if (!currentView) {
        [containerView addSubview:newView];
    }

    if (currentView != newView) {

        [containerView replaceSubview:currentView with:newView];

        [newView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[newView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(newView)]];
        [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[newView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(newView)]];
    }
}

+ (void)replaceViewInContainerView:(NSView *)containerView withView:(NSView *)newView transition:(CATransition *)transition {

    NSView *currentView = [[containerView subviews] lastObject];

    if (!currentView) {
        [containerView addSubview:newView];
    }

    if (currentView != newView) {

        NSDictionary *ani = [NSDictionary dictionaryWithObject:transition
                                                        forKey:@"subviews"];
        [containerView setAnimations:ani];


        [[containerView animator] replaceSubview:currentView with:newView];

        [newView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[newView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(newView)]];
        [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[newView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(newView)]];
    }
}

@end
