//
//  APIController.m
//  EtsyCodingExercise
//
//  Created by Paul McGrath on 16/01/2018.
//  Copyright © 2018 Paul McGrath. All rights reserved.
//

#import "APIController.h"
#import "EtsyListing.h"
@implementation APIController

- (void)makeSearchWithKeyword:(NSString *)keyword offset:(int)searchOffset limit:(int)searchLimit andCompletionHandler:(void (^)(NSArray *, NSError *))completion {
    
    NSString *baseURL = @"https://api.etsy.com/v2/listings/active?api_key=dxncnotadassftluiaelkyf8&includes=MainImage&keywords=";
    NSString *searchURL = [NSString stringWithFormat:@"%@%@&offset=%d&limit=%d",baseURL,keyword,searchOffset,searchLimit];
    
    
    NSURLSessionDataTask *urlSessionDataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:searchURL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSArray *resultList = result[@"results"];
        NSMutableArray *listings = [NSMutableArray new];
        for (NSDictionary *listing in resultList) {
            NSString *title = listing[@"title"];
            NSDictionary *imageDictionary = listing[@"MainImage"];
            NSString *fullImgURL = imageDictionary[@"url_fullxfull"];
            EtsyListing *etsyListing = [[EtsyListing alloc] initWithTitle:title andImageURL:[NSURL URLWithString:fullImgURL]];
            [listings addObject:etsyListing];
        }
        completion(listings, error);
    }];
    [urlSessionDataTask resume];
}
 
@end
