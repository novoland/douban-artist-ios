//
//  DAUpdateC.m
//  DoubanArtist
//
//  Created by liujing on 14/12/18.
//
//

#import "DAUpdateC.h"
#import "DAUpdateCellV.h"
#import "DAArtistService.h"

@interface DAUpdateC ()

@end

@implementation DAUpdateC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refresh: (UIRefreshControl *) refresh{
    [DAArtistService findUpdatesByArtistId:[self.artist objectForKey:@"id"] callback:^(NSArray *updates){
        [super refreshed];
        self.list = updates;
        [self.tableView reloadData];
    }];
}

- (NSString *) getBlankPlaceholderStr {
    return @"该音乐人暂无动态";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *u = [self.list objectAtIndex:indexPath.row];
    return [DAUpdateCellV getHeightForUpdate:u];
}

- (DAProfileSubListCellV *) createCellForIndexPath:(NSIndexPath *) indexPath{
    DAUpdateCellV *cell = [[DAUpdateCellV alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:self.cellIdentifier];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
