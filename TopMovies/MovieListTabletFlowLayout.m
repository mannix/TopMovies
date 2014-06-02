//
//  MovieListTabletFlowLayout.m
//  TopMovies
//
//  Created by Mike Mannix on 5/30/14.
//  Copyright (c) 2014 Mike Mannix. All rights reserved.
//

#import "MovieListTabletFlowLayout.h"

@implementation MovieListTabletFlowLayout

- (id)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(123, 333);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
    }
    
    return self;
}

@end
