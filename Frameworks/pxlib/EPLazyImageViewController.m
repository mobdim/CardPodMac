//
//  EPLazyImageViewController.m
//  episodes2
//
//  Created by Patrick Dinger on 07.04.13.
//  Copyright (c) 2013 skylab. All rights reserved.
//

#import "EPLazyImageViewController.h"

@interface EPLazyImageViewController ()

@end

@implementation EPLazyImageViewController

- (void)setFileURL:(NSURL *)fileURL {
    [self.imageView setImage:nil];
    [self.label setHidden:NO];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:fileURL
                                           cachePolicy: NSURLRequestReturnCacheDataElseLoad
                                       timeoutInterval:15.0];

    [self.progressView startAnimation:self];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSImage *image = [[NSImage alloc] initWithData:data];
//        if (!image) {
//            image = [NSImage imageNamed:NSImageNameUserGuest];
//        }

        [self.imageView setImage:image];
        [self.progressView stopAnimation:self];
        [self.label setHidden:YES];
    }];
}

@end
