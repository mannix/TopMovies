//
//  Movie.m
//  TopMovies
//
//  Created by Mike Mannix on 5/30/14.
//  Copyright (c) 2014 Mike Mannix. All rights reserved.
//

#import "Movie.h"
#import "MovieImage.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [self init];
    
    if (self) {
        self.numVotes = [dict objectForKey:@"num_voties"];
        self.tconst = [dict objectForKey:@"tconst"];
        self.title = [dict objectForKey:@"title"];
        self.rating = [dict objectForKey:@"rating"];
        self.image = [[MovieImage alloc] initWithDictionary:[dict objectForKey:@"image"]];
        self.year = [dict objectForKey:@"year"];
    }
    
    return self;
}

@end
