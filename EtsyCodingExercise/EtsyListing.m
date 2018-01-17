//
//  EtsyListing.m
//  EtsyCodingExercise
//
//  Created by Paul McGrath on 16/01/2018.
//  Copyright © 2018 Paul McGrath. All rights reserved.
//

#import "EtsyListing.h"

@implementation EtsyListing

- (id)initWithTitle:(NSString *)title andImageURL:(NSURL *)imageURL {
    self = [super init];
    if (self) {
        self.title = title;
        self.imageURL = imageURL;
    }
    return self;
}

@end
