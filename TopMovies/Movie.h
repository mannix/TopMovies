//
//  Movie.h
//  TopMovies
//
//  Created by Mike Mannix on 5/30/14.
//  Copyright (c) 2014 Mike Mannix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieImage.h"

@interface Movie : NSObject

@property (nonatomic, strong) NSNumber *numVotes;
@property (nonatomic, strong) NSString *tconst;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) MovieImage *image;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
