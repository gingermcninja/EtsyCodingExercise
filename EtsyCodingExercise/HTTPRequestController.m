//
//  APIController.m
//  EtsyCodingExercise
//
//  Created by Paul McGrath on 16/01/2018.
//  Copyright © 2018 Paul McGrath. All rights reserved.
//

#import "HTTPRequestController.h"
#import "EtsyListing.h"
@implementation HTTPRequestController

- (void)makeSearchWithKeyword:(NSString *)keyword offset:(int)searchOffset limit:(int)searchLimit andCompletionHandler:(void (^)(NSDictionary *, NSError *))completion {
    
    NSString *baseURL = @"https://api.etsy.com/v2/listings/active?api_key=dxncnotadassftluiaelkyf8&includes=MainImage&keywords=";
    NSString *searchURL = [NSString stringWithFormat:@"%@%@&offset=%d&limit=%d",baseURL,keyword,searchOffset,searchLimit];
    
    NSURLSessionDataTask *urlSessionDataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:searchURL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *result = nil;
        if(data) {
            result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        }
        completion(result, error);
    }];
    [urlSessionDataTask resume];
}
 
@end
