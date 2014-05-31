//
//  MovieListViewController.m
//  TopMovies
//
//  Created by Mike Mannix on 5/30/14.
//  Copyright (c) 2014 Mike Mannix. All rights reserved.
//

#import "MovieListViewController.h"
#import <AFHTTPRequestOperation.h>
#import "ImdbApiClient.h"

@interface MovieListViewController ()

@property (nonatomic, strong) ImdbApiClient *imdbClient;
@property (nonatomic, strong) NSMutableArray *movies;

@end

@implementation MovieListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imdbClient = [[ImdbApiClient alloc] init];
    self.movies = [[NSMutableArray alloc] init];
    [self.imdbClient topMovies:self.movies];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
