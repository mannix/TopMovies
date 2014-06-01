//
//  Movie.m
//  TopMovies
//
//  Created by Mike Mannix on 5/30/14.
//  Copyright (c) 2014 Mike Mannix. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [self init];
    
    if (self) {
        self.title = [dict objectForKey:@"title"];
        self.year = [dict objectForKey:@"year"];
        self.tconst = [dict objectForKey:@"tconst"];
        
        NSDictionary *imageDictionary = [dict objectForKey:@"image"];
        self.imageUrl = [imageDictionary objectForKey:@"url"];
        self.imageWidth = [imageDictionary objectForKey:@"width"];
        self.imageHeight = [imageDictionary objectForKey:@"height"];
    }
    
    return self;
}

@end
