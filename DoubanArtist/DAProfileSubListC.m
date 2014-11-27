//
//  DAProfileSubListC.m
//  DoubanArtist
//
//  Created by liujing on 14/11/25.
//
//

#import "DAProfileSubListC.h"
#import "DAProfileSubListCellV.h"
#import "DASwipePageScrollView.h"

@interface DAProfileSubListC ()
@end

@implementation DAProfileSubListC

- (id) initWithArtist:(NSDictionary *) artist
       cellIdentifier:(NSString *) cellId{
    self = [super init];
    
    if(self){
        _artist = artist;
        _cellIdentifier = cellId;
    }
    return self;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DAProfileSubListCellV *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    
    if(!cell){
        cell = [self createCellForIndexPath:indexPath];
    }
    
    NSDictionary *model = [_list objectAtIndex:[indexPath row]];
    cell.model = model;
    
    return cell;
}

#pragma mark - Table view delegate

-(void)scrollViewDidScroll:(UIScrollView *)tableView {
    
//    // 如果表格向下滚动的距离超过了阈值，将 page view 调整为填满 nav controller，并移动 tab bar 的位置。
//    if (tableView.contentOffset.y >= 100 && !_pagableViewExpanded){
//        // 状态栏 + navbar 的高度
//        CGFloat y = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height;
//        
//        CGRect newPageViewFrame = CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height - y);
//        CGRect newTabFrame = CGRectMake(0, y, CGRectGetWidth(_tabBar.frame), CGRectGetHeight(_tabBar.frame));
//        
//        [UIView animateWithDuration:0.4
//                         animations:^{
//                             _pagableView.frame= newPageViewFrame;
//                             _tabBar.frame = newTabFrame;
//                         }];
//        _pagableViewExpanded = YES;
//        return;
//    }
//    
//    // 如果表格滚动距离在阈值内，还原 page view 及 tab bar。
//    if (tableView.contentOffset.y < 100 && _pagableViewExpanded){
//        [UIView animateWithDuration:0.4
//                         animations:^{
//                             _pagableView.frame= _pagableViewOriginalFrame;
//                             _tabBar.frame = CGRectMake(0, CGRectGetMinY(_pagableViewOriginalFrame),self.view.frame.size.width, self.tabBar.frame.size.height);
//                         }];
//        _pagableViewExpanded = NO;
//    }
    
    if (self.scrollViewDidScrollCallback){
        self.scrollViewDidScrollCallback(tableView);
    }
}

#pragma mark - 留给子类实现的方法
- (DAProfileSubListCellV *) createCellForIndexPath:(NSIndexPath *) indexPath{
    return nil;
}

- (void) controllerSwitched:(DASwipePageScrollView *) pageScrollView{
    [self scrollViewDidScroll:self.tableView];
    [super controllerSwitched:pageScrollView];
}
@end
