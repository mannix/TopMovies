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
#import "ITunesApiClient.h"
#import "Movie.h"
#import "MovieCell.h"
#import "MovieListPhoneFlowLayout.h"
#import "MovieListTabletFlowLayout.h"
#import "MovieDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MovieListViewController ()

@property (nonatomic, strong) ImdbApiClient *imdbClient;
@property (nonatomic, strong) ITunesApiClient *iTunesClient;
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) UIViewController *webViewController;

@end

@implementation MovieListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imdbClient = [[ImdbApiClient alloc] init];
    self.iTunesClient = [[ITunesApiClient alloc] init];
    
    self.movies = [Movie MR_findAllSortedBy:@"rank" ascending:YES];
    if (!self.movies || [self.movies count] == 0) {
        [self loadMovies];
    }
    
    UICollectionViewFlowLayout *flowLayout = nil;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        flowLayout = [[MovieListTabletFlowLayout alloc] init];
    } else {
        flowLayout = [[MovieListPhoneFlowLayout alloc] init];
    }
    [self.collectionView setCollectionViewLayout:flowLayout];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (IBAction)refreshMovies:(id)sender {
    [Movie MR_truncateAll];
    [self loadMovies];
}

- (void)loadMovies
{
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
    cell.delegate = self;
    cell.buyRentButton.layer.borderWidth = 1;
    cell.buyRentButton.layer.cornerRadius = 4;
    cell.buyRentButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    cell.movie = movie;
    cell.rank.text = [NSString stringWithFormat:@"#%d", indexPath.row + 1];
    cell.title.text = [NSString stringWithFormat:@"%@ (%@)", movie.title, movie.year];
    [cell.title sizeToFit];
    
    if (!movie.image) {
        NSURL *url = [NSURL URLWithString:movie.imageUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [cell.imageView setImageWithURLRequest:request
                              placeholderImage:[UIImage imageNamed:@"placeholder"]
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           if (image) {
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   Movie *movie = [self.movies objectAtIndex:indexPath.row];
                                                   movie.image = UIImageJPEGRepresentation(image, 0.7);
                                                   [movie save];
                                                   MovieCell *updateCell = (id)[collectionView cellForItemAtIndexPath:indexPath];
                                                   if (updateCell) {
                                                       updateCell.imageView.image = image;
                                                   }
                                               });
                                           }
                                       } failure:nil];
    } else {
        cell.imageView.image = [UIImage imageWithData:movie.image];
    }
    return cell;
}

#pragma mark - Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Movie *selectedMovie = [self.movies objectAtIndex:indexPath.row];
    [self showDetailsForMovie:selectedMovie];
}

#pragma mark - MovieCell Protocol

- (void)buyOrRentMovie:(Movie *)movie
{
    [self.iTunesClient goToMovieInITunesIfAvailable:movie];
}

- (void)showDetailsForMovie:(Movie *)movie
{
    MovieDetailViewController *viewController = [[MovieDetailViewController alloc] initWithNibName:@"MovieDetailView" bundle:nil];
    viewController.url = [NSString stringWithFormat:@"http://www.imdb.com/title/%@", movie.tconst];
    viewController.movieTitle = movie.title;
    [self presentViewController:viewController animated:YES completion:nil];
}

@end
