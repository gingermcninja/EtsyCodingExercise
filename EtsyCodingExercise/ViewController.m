//
//  ViewController.m
//  EtsyCodingExercise
//
//  Created by Paul McGrath on 16/01/2018.
//  Copyright © 2018 Paul McGrath. All rights reserved.
//

#import "ViewController.h"
#import "APIController.h"
#import "EtsyResultTableViewCell.h"
#import "EtsyListing.h"

@interface ViewController () {
    NSString *searchTerm;
    NSMutableArray *searchResults;
    int searchOffset;
    BOOL searchInProgress;
}

@property (nonatomic, strong) IBOutlet UITextField *searchTextfield;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    searchResults = [NSMutableArray new];
    searchOffset = 0;
    searchInProgress = NO;
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EtsyResultTableViewCell *cell = (EtsyResultTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    EtsyListing *listing = (EtsyListing *)[searchResults objectAtIndex:indexPath.row];
    cell.titleLabel.text = listing.title;
    cell.imageURL = listing.imageURL;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 394;
}

- (void)performSearch {
    NSLog(@"searching...");
    searchInProgress = YES;
    if ([searchTerm length]) {
        APIController *api = [APIController new];
        [api makeSearchWithKeyword:searchTerm offset:searchOffset limit:3 andCompletionHandler:^(NSArray *listings, NSError *error) {
            [searchResults addObjectsFromArray:listings];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                searchInProgress = NO;
            });
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    searchTerm = textField.text;
    searchOffset = 0;
    [searchResults removeAllObjects];
    [self performSearch];
    
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"yeah, stopped");
    CGFloat actualPosition = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height - self.tableView.frame.size.height;
    //NSLog(@"scroll, %f %f",actualPosition, contentHeight);
    if (actualPosition >= contentHeight && !searchInProgress) {
        searchOffset += 3;
        [self performSearch];
    }
}


@end
