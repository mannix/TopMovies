//
//  MovieDetailViewController.h
//  TopMovies
//
//  Created by Mike Mannix on 5/31/14.
//  Copyright (c) 2014 Mike Mannix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *movieTitle;

@end
