//
//  MovieListViewController.m
//  TopMovies
//
//  Created by Mike Mannix on 5/30/14.
//  Copyright (c) 2014 Mike Mannix. All rights reserved.
//

#import "MovieListViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ImdbApiClient.h"
#import "Movie.h"
#import "MovieCell.h"
#import "MovieListPhoneFlowLayout.h"
#import "MovieListTabletFlowLayout.h"
#import "MovieDetailViewController.h"

@interface MovieListViewController ()

@property (nonatomic, strong) ImdbApiClient *imdbClient;
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) UIViewController *webViewController;

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
    
    UICollectionViewFlowLayout *flowLayout = nil;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        flowLayout = [[MovieListTabletFlowLayout alloc] init];
    } else {
        flowLayout = [[MovieListPhoneFlowLayout alloc] init];
    }
    [self.collectionView setCollectionViewLayout:flowLayout];
}

#pragma mark - Collection View Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.movies count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    }
    
    return view;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCell" forIndexPath:indexPath];
    Movie *movie = [self.movies objectAtIndex:indexPath.row];
    cell.delegate = self;
    cell.movie = movie;
    cell.rank.text = [NSString stringWithFormat:@"IMDb rank: %d", indexPath.row + 1];
    cell.title.text = [NSString stringWithFormat:@"%@ (%@)", movie.title, movie.year];
    [cell.title sizeToFit];
    
    if (!movie.image.image) {
        NSURL *url = [NSURL URLWithString:movie.image.url];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [cell.imageView setImageWithURLRequest:request
                              placeholderImage:[UIImage imageNamed:@"placeholder"]
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           if (image) {
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   Movie *movie = [self.movies objectAtIndex:indexPath.row];
                                                   movie.image.image = image;
                                                   MovieCell *updateCell = (id)[collectionView cellForItemAtIndexPath:indexPath];
                                                   if (updateCell) {
                                                       updateCell.imageView.image = image;
                                                   }
                                               });
                                           }
                                       } failure:nil];
    } else {
        cell.imageView.image = movie.image.image;
    }
    return cell;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

#pragma mark - MovieCell Protocol

- (void)showDetailsForMovie:(Movie *)movie
{
    MovieDetailViewController *viewController = [[MovieDetailViewController alloc] initWithNibName:@"MovieDetailView" bundle:nil];
    viewController.url = [NSString stringWithFormat:@"http://www.imdb.com/title/%@", movie.tconst];
    viewController.movieTitle = movie.title;
    [self presentViewController:viewController animated:YES completion:nil];
}

@end
