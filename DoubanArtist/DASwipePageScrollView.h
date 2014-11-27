//
//  DASwipePageScrollView.h
//  DoubanArtist
//
//  Created by liujing on 14/11/24.
//
//

#import <UIKit/UIKit.h>

@interface DASwipePageScrollView : UIScrollView <UIScrollViewDelegate>

@property (assign,nonatomic) NSInteger curPage;
@property (weak,nonatomic) NSArray *subControllerList;
@property (nonatomic,assign) SEL controllerSwitchedCallback;
@property (nonatomic,copy) void (^pageChangedCallback) (DASwipePageScrollView *);
@property (nonatomic,weak) UIViewController *parentController;

- (void)gotoPage:(NSInteger) page animated:(BOOL)animated;
- (id) initWithControllers: (NSArray *) controllers
          parentController: (UIViewController *) parentController;
@end


