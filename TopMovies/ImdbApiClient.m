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

- (void)topMovies:(NSMutableArray *)movies
{
    NSString *string = BaseUrl;
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseRoot = (NSDictionary *)responseObject;
        NSDictionary *responseData = [responseRoot objectForKey:@"data"];
        NSDictionary *responseList = [responseData objectForKey:@"list"];
        NSArray *responseMovies = [responseList objectForKey:@"list"];
        for (id responseMovie in responseMovies) {
            [movies addObject:[[Movie alloc] initWithDictionary:responseMovie]];
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

@end
