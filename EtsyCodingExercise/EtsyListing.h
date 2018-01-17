//
//  EtsyListing.h
//  EtsyCodingExercise
//
//  Created by Paul McGrath on 16/01/2018.
//  Copyright © 2018 Paul McGrath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EtsyListing : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *imageURL;

- (id)initWithTitle:(NSString *)title andImageURL:(NSURL *)imageURL;

@end
