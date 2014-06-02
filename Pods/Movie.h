//
//  Movie.h
//
//  Created by Mike Mannix on 6/1/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Movie : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * rank;
@property (nonatomic, retain) NSString * tconst;
@property (nonatomic, retain) NSString * year;
@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * iTunesUrl;

- (void)populateWithDictionary:(NSDictionary *)dictionary;
- (void)save;

@end
