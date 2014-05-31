//
//  ImdbApiClient.h
//  TopMovies
//
//  Created by Mike Mannix on 5/30/14.
//  Copyright (c) 2014 Mike Mannix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImdbApiClient : NSObject

- (void)topMoviesWithCompletionBlock:(void (^)(NSArray *movies))block;

@end
