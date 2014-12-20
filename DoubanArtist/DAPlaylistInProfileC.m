//
//  DAPlaylistCTableViewController.m
//  DoubanArtist
//
//  Created by liujing on 14/11/25.
//
//

#import "DAPlaylistInProfileC.h"
#import "DAPlaylistService.h"
#import "DAPlaylistInProfileCellV.h"

@interface DAPlaylistInProfileC ()

@end

@implementation DAPlaylistInProfileC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refresh: (UIRefreshControl *) refresh{
    [DAPlaylistService findPlaylistsByArtistId:[self.artist objectForKey:@"id"] callback:^(NSArray *playlists){
        [super refreshed];
        self.list = playlists;
        [self.tableView reloadData];
    }];
}

- (DAProfileSubListCellV *) createCellForIndexPath:(NSIndexPath *) indexPath{
    DAPlaylistInProfileCellV *cell = [[DAPlaylistInProfileCellV alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSString *) getBlankPlaceholderStr {
    return @"该音乐人暂无单曲";
}

@end
