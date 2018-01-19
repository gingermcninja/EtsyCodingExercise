//
//  EtsyListingRepository.m
//  EtsyCodingExercise
//
//  Created by Paul McGrath on 18/01/2018.
//  Copyright © 2018 Paul McGrath. All rights reserved.
//

#import "EtsyListingRepository.h"
#import "HTTPRequestController.h"
#import "EtsyListing.h"

static const int SEARCH_LIMIT = 10;

@implementation EtsyListingRepository {
    NSString *currentKeyword;
    int currentOffset;
}

- (id)init {
    self = [super init];
    if(self) {
        currentKeyword = @"";
        currentOffset = 0;
        self.listings = [NSMutableArray new];
        self.maxListingsCount = 1000;
    }
    return self;
}

- (void) performSearchWithKeyWord:(NSString *)keyword andCompletionHandler:(void (^)(NSError *))completion {
    if(![keyword length]) {
        NSError *searchError = [NSError errorWithDomain:NSArgumentDomain code:-1 userInfo:@{NSLocalizedDescriptionKey:@"The search term cannot be blank!"}];
        completion(searchError);
        return;
    }
    
    if([keyword isEqualToString:currentKeyword]) {
        currentOffset += SEARCH_LIMIT;
    } else {
        [self.listings removeAllObjects];
        self.maxListingsCount = 0;
        currentOffset = 0;
    }
    currentKeyword = keyword;
    HTTPRequestController *httpRequestController = [HTTPRequestController new];
    [httpRequestController makeSearchWithKeyword:keyword offset:currentOffset limit:SEARCH_LIMIT andCompletionHandler:^(NSDictionary *result, NSError *error) {
        if(result) {
            NSArray *resultList = result[@"results"];
            for (NSDictionary *listing in resultList) {
                NSString *title = listing[@"title"];
                NSDictionary *imageDictionary = listing[@"MainImage"];
                NSString *fullImgURL = imageDictionary[@"url_fullxfull"];
                EtsyListing *etsyListing = [[EtsyListing alloc] initWithTitle:title andImageURL:[NSURL URLWithString:fullImgURL]];
                [self.listings addObject:etsyListing];
            }
            self.maxListingsCount = [result[@"count"] integerValue];
        }
        completion(error);
    }];
}

@end
