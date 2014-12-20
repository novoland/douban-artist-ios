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

#pragma mark - 留给子类实现的方法
- (DAProfileSubListCellV *) createCellForIndexPath:(NSIndexPath *) indexPath{
    return nil;
}

- (void) controllerSwitched:(DASwipePageScrollView *) pageScrollView{
    [self scrollViewDidScroll:self.tableView];
    [super controllerSwitched:pageScrollView];
}
@end
