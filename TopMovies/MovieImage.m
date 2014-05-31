//
//  MovieImage.m
//  TopMovies
//
//  Created by Mike Mannix on 5/30/14.
//  Copyright (c) 2014 Mike Mannix. All rights reserved.
//

#import "MovieImage.h"
#import "UIImage+Helpers.h"

@implementation MovieImage

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if (self) {
        self.url = [dict objectForKey:@"url"];
        self.width = [dict objectForKey:@"width"];
        self.height = [dict objectForKey:@"height"];
        [UIImage loadFromURL:[NSURL URLWithString:self.url] callback:^(UIImage *image) {
            self.image = image;
        }];
    }
    
    return self;
}

@end
