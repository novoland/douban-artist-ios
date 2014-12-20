//
//  DAMessageC.m
//  DoubanArtist
//
//  Created by liujing on 14/12/19.
//
//

#import "DAMessageC.h"
#import "DAArtistService.h"
#import "DAMessageCellV.h"

@interface DAMessageC ()

@end

@implementation DAMessageC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refresh: (UIRefreshControl *) refresh{
    [DAArtistService findMessagesByArtistId:[self.artist objectForKey:@"id"] callback:^(NSArray *msgs){
        [super refreshed];
        self.list = msgs;
        [self.tableView reloadData];
    }];
}

- (NSString *) getBlankPlaceholderStr {
    return @"快来发表第一条留言吧！";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *msg = [self.list objectAtIndex:indexPath.row];
    return [DAMessageCellV getHeightForMessage:msg];
}

- (DAProfileSubListCellV *) createCellForIndexPath:(NSIndexPath *) indexPath{
    DAMessageCellV *cell = [[DAMessageCellV alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:self.cellIdentifier];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
