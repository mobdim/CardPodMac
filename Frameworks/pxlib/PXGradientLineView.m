#import "PXGradientLineView.h"

@implementation PXGradientLineView

- (void)drawRect:(NSRect)dirtyRect {
    NSColor *shadowColor = [[NSColor whiteColor] colorWithAlphaComponent:0.4];
    NSColor *mainColor = [NSColor colorWithDeviceWhite:0.812 alpha:1.000];
    if (self.customMainColor) {
        mainColor = self.customMainColor;
    }
    
    NSColor *transparentColor = [NSColor colorWithSRGBRed:1 green:1 blue:1 alpha:0];

    NSRect frame = self.bounds;

    // center vertically
    frame.origin.y = round(frame.size.height / 2); // if no round, a float number could cause a 2pixel height line
    frame.size.height = 1;

    [NSGraphicsContext saveGraphicsState];

    // Setup Gradient
    NSGradient *gradient = [[NSGradient alloc] initWithColorsAndLocations:
                            transparentColor, 0.0,
                            mainColor, 0.05,

                            mainColor, 0.95,
                            transparentColor, 1.0,
                            nil];

    NSGradient *gradientShadow = [[NSGradient alloc] initWithColorsAndLocations:
                                  transparentColor, 0.0,
                                  shadowColor, 0.5,


                                  transparentColor, 1.0,
                                  nil];

    [gradient drawInRect:frame angle:0.0];
    [gradientShadow drawInRect:NSOffsetRect(frame, 0, -1) angle:0.0];

    [NSGraphicsContext restoreGraphicsState];
}

@end
