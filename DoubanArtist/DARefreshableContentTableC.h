//
//  DABaseContentC.h
//  DoubanArtist
//
//  Created by liujing on 14/11/23.
//
//

#import <Foundation/Foundation.h>
#import "DASwipePageScrollView.h"

@interface DARefreshableContentTableC : UITableViewController

@property(assign,nonatomic) NSInteger refreshInterval;
@property(assign,nonatomic) NSTimeInterval lastRefreshTime;
@property(assign,nonatomic) NSTimeInterval refreshIntervalThreshold;

- (void) refreshed;
- (void) mannualRefresh;
- (void) controllerSwitched:(DASwipePageScrollView *) pageScrollView;
@end
