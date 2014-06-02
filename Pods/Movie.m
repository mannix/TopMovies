//
//  Movie.m
//
//  Created by Mike Mannix on 6/1/14.
//
//

#import "Movie.h"


@implementation Movie

@dynamic title;
@dynamic rank;
@dynamic tconst;
@dynamic year;
@dynamic imageUrl;
@dynamic image;
@dynamic iTunesUrl;

- (void)populateWithDictionary:(NSDictionary *)dictionary
{
    self.title = [dictionary objectForKey:@"title"];
    self.tconst = [dictionary objectForKey:@"tconst"];
    self.year = [dictionary objectForKey:@"year"];
    NSDictionary *imageDictionary = [dictionary objectForKey:@"image"];
    self.imageUrl = [imageDictionary objectForKey:@"url"];
}

- (void)save
{
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

@end
