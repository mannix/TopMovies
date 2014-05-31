//
//  MovieImage.m
//  TopMovies
//
//  Created by Mike Mannix on 5/30/14.
//  Copyright (c) 2014 Mike Mannix. All rights reserved.
//

#import "MovieImage.h"

@implementation MovieImage

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if (self) {
        self.url = [dict objectForKey:@"url"];
        self.width = [dict objectForKey:@"width"];
        self.height = [dict objectForKey:@"height"];
    }
    
    return self;
}

- (UIImage *)image
{
    if (!_image) {
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.url]];
        _image = [UIImage imageWithData:imageData];
    }
    return _image;
}

@end
