//
//  MovieCell.m
//  TopMovies
//
//  Created by Mike Mannix on 5/30/14.
//  Copyright (c) 2014 Mike Mannix. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell

- (id)init
{
    self = [super init];
    if (self) {
        self.buyRentButton.layer.cornerRadius = 2;
        self.buyRentButton.layer.borderWidth = 1;
        self.buyRentButton.layer.borderColor = (__bridge CGColorRef)([UIColor lightGrayColor]);
    }
    return self;
}
- (IBAction)viewMoreButtonTapped:(id)sender {
    [self.delegate showDetailsForMovie:self.movie];
}

- (IBAction)rentBuyButtonTapped:(id)sender {
    [self.delegate buyOrRentMovie:self.movie];
}

- (void)initView
{
    self.buyRentButton.layer.borderWidth = 1;
    self.buyRentButton.layer.cornerRadius = 4;
    self.buyRentButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
}

@end
