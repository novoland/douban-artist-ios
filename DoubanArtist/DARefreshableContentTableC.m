//
//  DABaseContentC.m
//  DoubanArtist
//
//  Created by liujing on 14/11/23.
//
//

#import "DARefreshableContentTableC.h"
#import "DASwipePageScrollView.h"

@implementation DARefreshableContentTableC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.lastRefreshTime = -1;
        self.refreshIntervalThreshold = 60;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // hide empty cells
    [self.tableView setTableFooterView:[UIView new]];
    
    // refresh controls
    UIRefreshControl *refreshMe = [[UIRefreshControl alloc] init];
    refreshMe.attributedTitle = [[NSAttributedString alloc] initWithString:@""];
    [refreshMe addTarget:self action:@selector(refresh:)
        forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshMe;
}

- (void) refresh: (UIRefreshControl *) refresh
{
    NSLog(@"parent refresh");
    // TO BE overrided，注意在刷新成功后调用 refreshed 方法
}

- (void) refreshed
{
    [self.refreshControl endRefreshing];
    self.lastRefreshTime = [[NSDate date] timeIntervalSince1970];
}


- (void)mannualRefresh {
    [self.tableView scrollsToTop];
    [self.refreshControl beginRefreshing];
    if (self.tableView.contentOffset.y == 0) {
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^(void){
            self.tableView.contentOffset = CGPointMake(0, -self.refreshControl.frame.size.height);
            
        } completion:^(BOOL finished){
            [self refresh:self.refreshControl];
        }];
        
    }
}

#pragma mark - Callback for swipe-page-view
// 当切换到该 page 时，按需自动刷新
- (void)controllerSwitched:(DASwipePageScrollView *) pageScrollView
{
    if ([[NSDate date] timeIntervalSince1970] - self.lastRefreshTime > self.refreshIntervalThreshold)
        [self mannualRefresh];
}
@end
