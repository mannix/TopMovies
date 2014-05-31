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

static NSString * const BaseUrl = @"http://app.imdb.com/chart/top?api=v1&appid=iphone1&locale=en_US";

- (void)topMoviesWithCompletionBlock:(void (^)(NSArray *))block
{
    NSString *string = BaseUrl;
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *responseMovies = [self moviesFromResponse:responseObject];
        
        NSMutableArray *movies = [[NSMutableArray alloc] init];
        for (id responseMovie in responseMovies) {
            [movies addObject:[[Movie alloc] initWithDictionary:responseMovie]];
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
