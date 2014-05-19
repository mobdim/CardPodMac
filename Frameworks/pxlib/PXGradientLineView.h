#import <Cocoa/Cocoa.h>


/**
 * Draws an GradientLine in Style of 10.8 Settings (e.G. General)
 * Setup in IB using an "horizontal line" and set class to PXGradientLineView
 */
@interface PXGradientLineView : NSBox

@property (nonatomic, copy) NSColor *customMainColor;

@end
