//
//  UIImage+Helpers.h
//  TopMovies
//
//  Created by Mike Mannix on 5/31/14.
//  Copyright (c) 2014 Mike Mannix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helpers)

+ (void)loadFromURL:(NSURL *)url callback:(void (^)(UIImage *image))callback;

@end
