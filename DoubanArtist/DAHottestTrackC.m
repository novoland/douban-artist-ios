//
//  DAHottestTrackC.m
//  DoubanArtist
//
//  Created by liujing on 14-11-20.
//
//

#import "DAHottestTrackC.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DATrackCellV.h"
#import "DATrackService.h"
#import "MBProgressHUD.h"
#import "DAArtistService.h"
#import "DAProfileC.h"
#import "JDStatusBarNotification.h"

@implementation DAHottestTrackC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.curExpandIndex = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // custom xib-based cell
//    UINib *nib = [UINib nibWithNibName:@"DATrackCellV" bundle:nil];
//    [[self tableView] registerNib:nib forCellReuseIdentifier:@"trackListCell"];
}

- (void) refresh:(UIRefreshControl *) refreshMe
{
    [DATrackService findMostPopularWithCallback:^(NSMutableArray *list){
        [super refreshed];
        
        self.trackList = list;
        [self.tableView reloadData];
    }];
}

#pragma mark - TableView delegate & datasource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kTrackCellNoLengthHeight;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.trackList count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DATrackCellV *cell =[tableView dequeueReusableCellWithIdentifier:@"trackListCell"];
    
    if(!cell){
        cell = [[DATrackCellV alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"trackListCell"];
    }
    
    NSDictionary *track = (NSDictionary *)[self.trackList objectAtIndex:indexPath.row];
    cell.rank = indexPath.row + 1;
    cell.track = track;
    cell.isShowLength = NO;
    
    // 设置回调
    cell.imgClicked = ^void(NSDictionary *track){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        [DAArtistService findArtistById:[track objectForKey:@"artist_id"] callback:^void(NSDictionary *artist){
            [hud hide:YES];
            DAProfileC *profileC = [[DAProfileC alloc] init];
            profileC.artist = artist;
            [self.navigationController pushViewController:profileC animated:YES];
        }];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:_trackList forKey:@"playlist"];
    [param setObject:[NSNumber numberWithLong:indexPath.row] forKey:@"index"];
    
    NSNotification *n = [NSNotification notificationWithName:@"player.playList" object:self userInfo:param];
    
    [[NSNotificationCenter defaultCenter] postNotification:n];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
