//
//  ImdbApiClient.m
//  TopMovies
//
//  Created by Mike Mannix on 5/30/14.
//  Copyright (c) 2014 Mike Mannix. All rights reserved.
//

#import "ImdbApiClient.h"
#import <AFHTTPRequestOperation.h>
#import "Movie.h"

@implementation ImdbApiClient

static NSString * const TopMoviesURL = @"http://app.imdb.com/chart/top?api=v1&appid=iphone1&locale=en_US";

- (void)topMoviesWithCompletionBlock:(void (^)(NSArray *))block
{
    NSURL *url = [NSURL URLWithString:TopMoviesURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *responseMovies = [self moviesFromResponse:responseObject];
        
        NSMutableArray *movies = [[NSMutableArray alloc] init];
        for (int i = 0; i < [responseMovies count]; i++) {
            id responseMovie = [responseMovies objectAtIndex:i];
            Movie *movie = [Movie MR_createEntity];
            [movie populateWithDictionary:(NSDictionary *)responseMovie];
            movie.rank = [NSNumber numberWithInt:i + 1];
            [movie save];
            [movies addObject:movie];
        }
        
        if (block) {
            block([NSArray arrayWithArray:movies]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Unable to retrieve IMDB top movies"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"That stinks"
                                                  otherButtonTitles:nil];
        NSLog(@"Error retriving IMDb movies: %@", error);
        [alertView show];
    }];
    
    [operation start];
}

- (NSArray *)moviesFromResponse:(id)responseObject
{
    NSDictionary *responseRoot = (NSDictionary *)responseObject;
    NSDictionary *responseData = [responseRoot objectForKey:@"data"];
    NSDictionary *responseList = [responseData objectForKey:@"list"];
    return [responseList objectForKey:@"list"];
}

@end
