#import <Cocoa/Cocoa.h>

@interface NSColor (CGColor)

+ (NSColor *)_colorWithCGColor:(CGColorRef)CGColor;
- (CGColorRef)_CGColor;

@end
