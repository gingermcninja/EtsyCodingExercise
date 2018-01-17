//
//  EtsyResultTableViewCell.h
//  EtsyCodingExercise
//
//  Created by Paul McGrath on 16/01/2018.
//  Copyright © 2018 Paul McGrath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EtsyResultTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIImageView *etsyImageView;
@property (nonatomic, strong) NSURL *imageURL;

@end
