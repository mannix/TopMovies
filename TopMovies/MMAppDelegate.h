//
//  MMAppDelegate.h
//  TopMovies
//
//  Created by Mike Mannix on 5/30/14.
//  Copyright (c) 2014 Mike Mannix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (NSURL *)applicationDocumentsDirectory;

@end
