#import <Cocoa/Cocoa.h>

@interface EPLazyImageViewController : NSObject

@property (nonatomic, copy)  NSURL *fileURL;
@property (strong) IBOutlet NSProgressIndicator *progressView;
@property (strong) IBOutlet NSImageView *imageView;
@property (strong) IBOutlet NSTextField *label;

@end
