//
//  HTTPRequestController.h
//  EtsyCodingExercise
//
//  Created by Paul McGrath on 16/01/2018.
//  Copyright © 2018 Paul McGrath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPRequestController : NSObject

- (void)makeSearchWithKeyword:(NSString *)keyword offset:(int)searchOffset limit:(int)searchLimit andCompletionHandler:(void (^)(NSDictionary *, NSError *))completion;

@end
