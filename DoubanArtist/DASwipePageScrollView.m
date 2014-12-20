//
//  DASwipePageScrollView.m
//  DoubanArtist
//
//  Created by liujing on 14/11/24.
//
//

#import "DASwipePageScrollView.h"

@implementation DASwipePageScrollView

// 确保在调用该方法前，scroll view 已经有了正确的 frame 和 contentSize！
- (void)loadScrollViewWithPage:(NSUInteger)page
{
    if (page >= self.subControllerList.count)
        return;
    
    UIViewController *controllerToLoad = (UIViewController *)[self.subControllerList objectAtIndex:page];
    
    // add the controller's view to the scroll view if nessesary
    if (controllerToLoad && controllerToLoad.view.superview == nil){
        [controllerToLoad.view setFrame:CGRectMake([self getPageWidth] * page, 0, [self getPageWidth], [self getPageHeight])];
        
        // 一定要维护 controller 之间的父子关系，不能只加入 view。否则各种事件不会在 controller 树中传播。
        // 即，我们需要同时维护 controller & view 两棵树。
        [_parentController addChildViewController:controllerToLoad];
        [self addSubview:controllerToLoad.view];
        [controllerToLoad didMoveToParentViewController:_parentController];
    }
}

- (void)gotoPage:(NSInteger) page animated:(BOOL)animated
{
    if(self.curPage == page)
        return;
    NSLog(@"goto page: %ld",page);
    
    self.curPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    //[self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    //[self loadScrollViewWithPage:page + 1];
    
    // update the scroll view to the appropriate page
    CGRect bounds = self.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) * page;
    bounds.origin.y = 0;
    [self scrollRectToVisible:bounds animated:animated];
    
    // 回调方法
    if(!self.controllerSwitchedCallback){
        self.controllerSwitchedCallback = NSSelectorFromString(@"controllerSwitched:");
    }
    [self invokeCallbackForIndex:page selector:self.controllerSwitchedCallback];
}

- (void) invokeCallbackForIndex:(NSInteger) index selector:(SEL) sel
{
    UIViewController* curController = [self.subControllerList objectAtIndex:index];
    if([curController canPerformAction:sel withSender:self]){
        [curController performSelector:sel withObject:self afterDelay:0];
    }
}

// 在滑动停止时载入对应的 ViewController
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    // 判断要滚动到哪个 page
    CGFloat pageWidth = [self getPageWidth];
    NSUInteger page = floor((self.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    [self gotoPage:page animated:YES];
    
    // 回调
    if(self.pageChangedCallback){
        self.pageChangedCallback(self);
    }
}

- (void) setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self adjustContentSize];
    [self adjustSubViewsSize];
}

// 设置 scroll view 的 contentSize，使其不可垂直滚动。注意 contentInset 的影响。
- (void) adjustContentSize{
    self.contentSize = CGSizeMake([self getPageWidth] * self.subControllerList.count, [self getPageHeight]);
}

- (void) adjustSubViewsSize{
    NSArray *subviews = self.subviews;
    for(int i=0;i<subviews.count;i++){
        UIView *v = [subviews objectAtIndex:i];
        [v setFrame:CGRectMake([self getPageWidth] * i, 0, [self getPageWidth], [self getPageHeight])];
    }
}

- (CGFloat) getPageWidth{
    return self.frame.size.width - self.contentInset.left - self.contentInset.right;
}

- (CGFloat) getPageHeight{
    return self.frame.size.height - self.contentInset.top - self.contentInset.bottom;
}

- (id) initWithControllers: (NSArray *) controllers
          parentController: (UIViewController *) parentController{
    self = [super init];
    if (self) {
        self.subControllerList = controllers;
        self.curPage = -1;
        self.scrollsToTop = NO;
        self.bounces = YES;
        self.pagingEnabled = YES;
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
        self.parentController = parentController;
        self.delegate = self;
    }
    return self;
    
}

@end
