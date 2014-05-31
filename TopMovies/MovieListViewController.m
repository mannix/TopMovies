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
#import "Movie.h"
#import "MovieCell.h"

@interface MovieListViewController ()

@property (nonatomic, strong) ImdbApiClient *imdbClient;
@property (nonatomic, strong) NSArray *movies;

@end

@implementation MovieListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imdbClient = [[ImdbApiClient alloc] init];
    self.movies = [[NSMutableArray alloc] init];
    
    [self.imdbClient topMoviesWithCompletionBlock:^(NSArray *movies) {
        self.movies = movies;
        [self.collectionView reloadData];
    }];
}

#pragma mark - Collection View Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.movies count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCell" forIndexPath:indexPath];
    Movie *movie = [self.movies objectAtIndex:indexPath.row];
    cell.title.text = movie.title;
    return cell;
}

@end
