//
//  MovieImage.h
//  TopMovies
//
//  Created by Mike Mannix on 5/30/14.
//  Copyright (c) 2014 Mike Mannix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieImage : NSObject

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSNumber *width;
@property (nonatomic, strong) NSNumber *height;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
