//
//  MovieDetailViewController.m
//  TopMovies
//
//  Created by Mike Mannix on 5/31/14.
//  Copyright (c) 2014 Mike Mannix. All rights reserved.
//

#import "MovieDetailViewController.h"

@interface MovieDetailViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    self.navItem.title = self.movieTitle;
    [self.webView loadRequest:urlRequest];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarOrientation = self.interfaceOrientation;
}

- (IBAction)closeButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
