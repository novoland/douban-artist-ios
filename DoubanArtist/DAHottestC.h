//
//  DAHottestC.h
//  DoubanArtist
//
//  Created by liujing on 14-11-20.
//
//

#import <UIKit/UIKit.h>
#import "UIViewController+RESideMenu.h"
#import "DAHottestArtistC.h"
#import "DAHottestTrackC.h"
#import "DASwipePageScrollView.h"

@interface DAHottestC : UIViewController<UIScrollViewDelegate>

@property (strong,nonatomic) NSArray *subControllers;

@property (weak,nonatomic) UISegmentedControl *segControl;
@property (retain,nonatomic) DASwipePageScrollView *pageScrollView;

@end
