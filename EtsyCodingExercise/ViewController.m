//
//  ViewController.m
//  EtsyCodingExercise
//
//  Created by Paul McGrath on 16/01/2018.
//  Copyright © 2018 Paul McGrath. All rights reserved.
//

#import "ViewController.h"
#import "EtsyResultTableViewCell.h"
#import "EtsyListing.h"
#import "EtsyListingRepository.h"

@interface ViewController () {
    EtsyListingRepository *repository;
    NSString *searchTerm;
}

@property (nonatomic, strong) IBOutlet UITextField *searchTextfield;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    repository = [EtsyListingRepository new];
    self.tableView.backgroundColor = [UIColor clearColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [repository.listings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EtsyResultTableViewCell *cell = (EtsyResultTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    EtsyListing *listing = (EtsyListing *)[repository.listings objectAtIndex:indexPath.row];
    cell.titleLabel.text = listing.title;
    cell.imageURL = listing.imageURL;
    cell.etsyImageView.image = [UIImage imageNamed:@"Etsy-logo"];
    NSURLSessionDataTask *imageLoadTask = [[NSURLSession sharedSession] dataTaskWithURL:listing.imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error && data) {
            UIImage *image = [[UIImage alloc] initWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                EtsyResultTableViewCell *etsyCell = (EtsyResultTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                if(etsyCell && etsyCell.imageURL == listing.imageURL) {
                    etsyCell.etsyImageView.image = image;
                }
            });
        }
    }];
    [imageLoadTask resume];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 394;
}

- (void)performSearch {
    if ([searchTerm length]) {
        [repository performSearchWithKeyWord:searchTerm andCompletionHandler:^(NSError *searchError) {
            if(searchError) {
                NSLog(@"Error: %@",searchError.localizedDescription);
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:searchError.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:okAction];
                [self presentViewController:alert animated:NO completion:nil];
                
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    if(![textField.text isEqualToString:searchTerm]) {
        [self.tableView setContentOffset:CGPointZero animated:NO];
        searchTerm = textField.text;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self performSearch];
        });
    }
    
    return YES;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if ([repository.listings count] - indexPath.row == 2 && ([repository.listings count] < repository.maxListingsCount) ) {
        [self performSearch];
    }
}


@end
