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

- (void)goToMovieInITunesIfAvailable:(Movie *)movie
{
    [self findMovie:movie withCompletionBlock:^(NSString *trackViewUrl) {
        if (trackViewUrl) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl]];
        } else {
            NSString *alertTitle = [NSString stringWithFormat:@"%@ is not available to rent or buy in iTunes", movie.title];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                                message:nil
                                                               delegate:nil
                                                      cancelButtonTitle:@"Okay"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        
    }];
}




- (void)findMovie:(Movie *)movie withCompletionBlock:(void(^)(NSString *))block
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
            if ([releaseYear isEqualToString:movie.year]) {
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

@end
