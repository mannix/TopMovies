//
//  ITunesApiClient.m
//  TopMovies
//
//  Created by Mike Mannix on 6/1/14.
//  Copyright (c) 2014 Mike Mannix. All rights reserved.
//

#import "ITunesApiClient.h"
#import "Movie.h"
#import <AFHTTPRequestOperation.h>

@implementation ITunesApiClient

static NSString * const FindMoviesURL = @"https://itunes.apple.com/search?media=movie&entity=movie&term=%@";

- (void)searchForMovie:(Movie *)movie withCompletionBlock:(void (^)(NSString *))block
{
    NSString *urlString = [NSString stringWithFormat:FindMoviesURL, movie.title];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        NSArray *searchResults = [responseDictionary objectForKey:@"results"];
        NSString *trackViewUrl = nil;
        
        for (NSDictionary *result in searchResults) {
            NSString *releaseDate = [result objectForKey:@"releaseDate"];
            NSString *releaseYear = [releaseDate substringToIndex:4];
            if ([releaseYear isEqualToString:movie.year] || [searchResults count] == 1) {
                trackViewUrl = [result objectForKey:@"trackViewUrl"];
                break;
            }
        }
        
        if (block) {
            block(trackViewUrl);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"There was an error communicating with iTunes"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Bummer"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    [operation start];
}

- (void)openMovieInITunes:(Movie *)movie
{
    if (movie.iTunesUrl) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:movie.iTunesUrl]];
    }
}

@end
