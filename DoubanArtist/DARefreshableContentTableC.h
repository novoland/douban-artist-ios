//
//  DABaseContentC.h
//  DoubanArtist
//
//  Created by liujing on 14/11/23.
//
//

#import <Foundation/Foundation.h>
#import "DASwipePageScrollView.h"
#import "UIScrollView+EmptyDataSet.h"

@interface DARefreshableContentTableC : UITableViewController<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property(assign,nonatomic) NSInteger refreshInterval;
@property(assign,nonatomic) NSTimeInterval lastRefreshTime;
@property(assign,nonatomic) NSTimeInterval refreshIntervalThreshold;

// callback for scroll
@property (copy, nonatomic) void (^scrollViewDidScrollCallback) (UIScrollView *);

- (void) refreshed;
- (void) mannualRefresh;
- (void) controllerSwitched:(DASwipePageScrollView *) pageScrollView;
@end
