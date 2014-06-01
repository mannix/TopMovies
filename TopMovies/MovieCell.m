//
//  MovieCell.m
//  TopMovies
//
//  Created by Mike Mannix on 5/30/14.
//  Copyright (c) 2014 Mike Mannix. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell

- (IBAction)viewMoreButtonTapped:(id)sender {
    [self.delegate showDetailsForMovie:self.movie];
}

@end
