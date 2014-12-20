//
//  DABaseContentC.m
//  DoubanArtist
//
//  Created by liujing on 14/11/23.
//
//

#import "DARefreshableContentTableC.h"
#import "DASwipePageScrollView.h"
#import "UIScrollView+EmptyDataSet.h"

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
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
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

- (NSString *) getBlankPlaceholderStr {
    return @"暂无内容";
}

#pragma mark - Callback for swipe-page-view
// 当切换到该 page 时，按需自动刷新
- (void)controllerSwitched:(DASwipePageScrollView *) pageScrollView
{
    if ([[NSDate date] timeIntervalSince1970] - self.lastRefreshTime > self.refreshIntervalThreshold)
        [self mannualRefresh];
}

# pragma mark - UIScrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)tableView {
    if (self.scrollViewDidScrollCallback){
        self.scrollViewDidScrollCallback(tableView);
    }
}

#pragma mark - DZNEmptyDataSet datasource

// The attributed string for the title of the empty dataset:
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = @"暂无动态";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    return nil;
}

// The attributed string for the description of the empty dataset:
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = [self getBlankPlaceholderStr];
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//    return nil;
}

//The attributed string to be used for the specified button state:
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0]};
    
//    return [[NSAttributedString alloc] initWithString:@"Continue" attributes:attributes];
    return nil;
}

// The image for the empty dataset:
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    return [UIImage imageNamed:@"IconTrackDefault"];
}

// The background color for the empty dataset:
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    
    return [UIColor whiteColor];
}

#pragma mark - DZNEmptyDataSet delegate

// Asks to know if the empty dataset should be rendered and displayed (Default is YES) :
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    
    // 只有刷新过才允许显示 emptydataset
    return _lastRefreshTime > 0;
}

// Asks for interaction permission (Default is YES) :
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    
    return YES;
}

// Asks for scrolling permission (Default is NO) :
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    
    return YES;
}

// Notifies when the dataset view was tapped:
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    
}

// Notifies when the dataset call to action button was tapped:
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView {
    
}

@end
