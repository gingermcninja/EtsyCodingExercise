//
//  EtsyListingRepository.h
//  EtsyCodingExercise
//
//  Created by Paul McGrath on 18/01/2018.
//  Copyright © 2018 Paul McGrath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EtsyListingRepository : NSObject

@property (nonatomic, strong) NSMutableArray *listings;
@property (nonatomic) NSInteger maxListingsCount;

- (void) performSearchWithKeyWord:(NSString *)keyword andCompletionHandler:(void (^)(NSError *))completion;

@end
