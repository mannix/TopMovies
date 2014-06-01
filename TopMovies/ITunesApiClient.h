//
//  ITunesApiClient.h
//  TopMovies
//
//  Created by Mike Mannix on 6/1/14.
//  Copyright (c) 2014 Mike Mannix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"

@interface ITunesApiClient : NSObject

- (void)goToMovieInITunesIfAvailable:(Movie *)movie;

@end
