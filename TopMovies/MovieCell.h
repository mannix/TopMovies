//
//  MovieCell.h
//  TopMovies
//
//  Created by Mike Mannix on 5/30/14.
//  Copyright (c) 2014 Mike Mannix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@protocol MovieDetails

- (void)buyOrRentMovie:(Movie *)movie;
- (void)showDetailsForMovie:(Movie *)movie;

@end

@interface MovieCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *rank;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *buyRentButton;
@property (strong, nonatomic) Movie *movie;


@property (retain) id delegate;

@end
