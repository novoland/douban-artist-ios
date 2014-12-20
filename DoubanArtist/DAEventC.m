//
//  DAEventC.m
//  DoubanArtist
//
//  Created by liujing on 14/11/25.
//
//

#import "DAEventC.h"
#import "DAArtistService.h"
#import "DAEventCellV.h"
#import "DAProfileSubListCellV.h"
#import "PBWebViewController.h"

@interface DAEventC ()

@end

@implementation DAEventC

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
    [DAArtistService findEventsByArtistId:[self.artist objectForKey:@"id"] callback:^(NSArray *events){
        [super refreshed];
        self.list = events;
        [self.tableView reloadData];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (DAProfileSubListCellV *) createCellForIndexPath:(NSIndexPath *) indexPath{
    DAEventCellV *cell = [[DAEventCellV alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:self.cellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *url = [[self.list objectAtIndex:indexPath.row] objectForKey:@"url"];
    PBWebViewController *webViewController = [[PBWebViewController alloc] init];
    webViewController.URL = [NSURL URLWithString:url];
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (NSString *) getBlankPlaceholderStr {
    return @"该音乐人暂无活动";
}

@end
