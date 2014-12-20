//
//  DAProfileC.m
//  DoubanArtist
//
//  Created by liujing on 14/11/23.
//
//

#import "DAProfileC.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+BlurredFrame.h"
#import "Colours.h"
#import "DZNSegmentedControl.h"
#import "DAHottestArtistC.h"
#import "DAHottestTrackC.h"
#import "DASwipePageScrollView.h"
#import "DAPlaylistInProfileC.h"
#import "DAEventC.h"
#import "DAUtils.h"
#import "DAAlbumC.h"
#import "DAUpdateC.h"
#import "DAMessageC.h"

@interface DAProfileC ()<DZNSegmentedControlDelegate>

@property (nonatomic, strong) NSArray *tabItems;
@property (nonatomic, strong) DZNSegmentedControl *tabBar;
@property (nonatomic, strong) DASwipePageScrollView *pagableView;

// 自适应 page view 的高度
@property (nonatomic, assign) CGRect pagableViewOriginalFrame;
@property(assign,nonatomic) BOOL pagableViewExpanded;
@property(assign,nonatomic) CGFloat scrollDistanceThreshold;
@property (assign,nonatomic) CGFloat pagableViewAnimationDuration;
@end

@implementation DAProfileC

/**
 * {
 *  picture:
 * "added":"no",
 * "name":"红花会 Padma Family",
 * "style":"流派: 说唱 Rap",
 * "member":"成员: ",
 * "follower":5959,
 * "type":"artist",
 * "id":"144637"
 * }
 **/
- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self restoreNavBar];
}

- (void) restoreNavBar{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
    
    self.navigationController.navigationBar.tintColor = nil;
    [self.navigationController.navigationBar setTitleTextAttributes:nil];
}

- (void) setupNavBar{
    // transparent nav bar
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    // tint color for nav bar
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setupNavBar];
    
    // 根据 model 正确设置 view 的展示内容
    self.title = [_artist valueForKey:@"name"];
    self.genreLabel.text = [[(NSString *)[_artist valueForKey:@"style"] componentsSeparatedByString:@":"] lastObject];
    self.followersLabel.text = [NSString stringWithFormat:@"%@ 关注", [_artist valueForKey:@"follower"]];
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:[_artist valueForKey:@"picture"]]
                      placeholderImage:[UIImage imageNamed:@"IconSettings"]
     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         CGRect frame = CGRectMake(0, 0, image.size.width, image.size.height);
         self.blurBgImg.image = [image applyTinyDarkEffectAtFrame:frame];
     }];
}

- (void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    // 在这里调整 layout
    // blur bg img size adjustment
    [self.blurBgImg setFrame:CGRectMake(0, 0, self.view.frame.size.width, CGRectGetWidth(self.view.frame))];
    
    // pageable view 的位置
    CGFloat bottomY = CGRectGetMaxY(self.genreLabel.frame) + 12;
    
    // tabbar 的位置
    [self.tabBar setFrame:CGRectMake(0, bottomY,self.view.frame.size.width, self.tabBar.frame.size.height)];
    
    bottomY += self.tabBar.frame.size.height;
    [_pagableView setFrame:CGRectMake(0, bottomY, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - bottomY)];
    
    if(_tabBar.selectedSegmentIndex == -1){
        _tabBar.selectedSegmentIndex = 0;
    }
}

- (void) viewDidLoad{
    [super viewDidLoad];
    
    // 在 view 加载后进行 view tree 的构造及初始化
    
    // blur bg image
    UIImage *defaultBgImg = [UIImage imageNamed:@"Stars"];
    CGRect frame = CGRectMake(0, 0, defaultBgImg.size.width, defaultBgImg.size.height);
    self.blurBgImg.image = [defaultBgImg applyDarkEffectAtFrame:frame];
    
    // avatar img
    self.avatarImg.layer.cornerRadius = self.avatarImg.frame.size.width / 2;
    self.avatarImg.clipsToBounds = YES;
    
    // swipable view
    self.pagableView = [[DASwipePageScrollView alloc] initWithControllers:self.subControllers parentController:self];
    __weak DAProfileC *selff = self;
    _pagableView.backgroundColor = [UIColor whiteColor];
    _pagableView.pageChangedCallback = ^(DASwipePageScrollView * v){
        selff.tabBar.selectedSegmentIndex = v.curPage;
    };
    [self.view addSubview: _pagableView];
    
    // DZSegmentedControl
    [self.view addSubview:[self tabBar]];

}

//  创建 tabbar：@"曲库", @"活动", @"相册", @"动态", @"留言"
- (DZNSegmentedControl *)tabBar
{
    if (!_tabBar)
    {
        _tabBar = [[DZNSegmentedControl alloc] initWithItems:self.tabItems];
        _tabBar.delegate = self;
        _tabBar.bouncySelectionIndicator = YES;
        _tabBar.showsCount = NO;
        _tabBar.height = 34;
        _tabBar.autoAdjustSelectionIndicatorWidth = NO;
        _tabBar.adjustsFontSizeToFitWidth = YES;
        
        [_tabBar addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventValueChanged];
    }
    return _tabBar;
}

- (void)selectedTab:(DZNSegmentedControl *)tabBar{
    [_pagableView gotoPage:[tabBar selectedSegmentIndex] animated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _tabItems = @[@"曲库", @"活动", @"相册", @"动态", @"留言"];
        _scrollDistanceThreshold = 100;
        _pagableViewAnimationDuration = 0.35;
    }
    return self;
}

// 创建 tab 内容页对应的 vc 数组
- (NSArray *) subControllers{
    if(!_subControllers){
        DAPlaylistInProfileC * one = [[DAPlaylistInProfileC alloc] initWithArtist:self.artist cellIdentifier:@"playlistInProfileCell"];
        DAEventC *two = [[DAEventC alloc] initWithArtist:self.artist cellIdentifier:@"eventCell"];
        DAAlbumC *three = [[DAAlbumC alloc] initWithArtist:self.artist cellIdentifier:@"albumCell"];
        DAUpdateC *four = [[DAUpdateC alloc] initWithArtist:self.artist cellIdentifier:@"updateCell"];
        DAMessageC *five = [[DAMessageC alloc] initWithArtist:self.artist cellIdentifier:@"messageCell"];
        
        
        
        // 为这些子 controller 设置滚动监听器，实现自适应 page view
        void (^scrollCb)(UIScrollView *) = ^void(UIScrollView *tableView){
                // 如果表格向下滚动的距离超过了阈值，将 page view 调整为填满 nav controller，并移动 tab bar 的位置。
                if (tableView.contentOffset.y >= _scrollDistanceThreshold && !_pagableViewExpanded){
                    // 状态栏 + navbar 的高度
                    CGFloat y = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height;
            
                    CGRect newPageViewFrame = CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height - y);
                    CGRect newTabFrame = CGRectMake(0, y, CGRectGetWidth(_tabBar.frame), CGRectGetHeight(_tabBar.frame));
            
                    [UIView animateWithDuration:_pagableViewAnimationDuration
                                     animations:^{
                                         _pagableView.frame= newPageViewFrame;
                                         _tabBar.frame = newTabFrame;
                                     }];
                    _pagableViewExpanded = YES;
                    return;
                }
            
                // 如果表格滚动距离在阈值内，还原 page view 及 tab bar。
                if (tableView.contentOffset.y < _scrollDistanceThreshold && _pagableViewExpanded){
                    [UIView animateWithDuration:_pagableViewAnimationDuration
                                     animations:^{
                                         _pagableView.frame= _pagableViewOriginalFrame;
                                         _tabBar.frame = CGRectMake(0, CGRectGetMinY(_pagableViewOriginalFrame),self.view.frame.size.width, self.tabBar.frame.size.height);
                                     }];
                    _pagableViewExpanded = NO;
                }
        };
//        one.scrollViewDidScrollCallback = scrollCb;
//        two.scrollViewDidScrollCallback = scrollCb;
        
        _subControllers = [NSArray arrayWithObjects:one, two, three, four, five, nil];
    }
    return _subControllers;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma DZNSegmentedControlDelegate
- (UIBarPosition)positionForBar:(id <UIBarPositioning>)view
{
    return UIBarPositionAny;
}

@end
