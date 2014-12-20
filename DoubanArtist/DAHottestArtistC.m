//
//  DAHottestArtistC.m
//  DoubanArtist
//
//  Created by liujing on 14-11-20.
//
//

#import "DAHottestArtistC.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DAArtistCellV.h"
#import "DAArtistService.h"
#import "POP.h"
#import "DAProfileC.h"

@implementation DAHottestArtistC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void) refresh:(UIRefreshControl *) refreshMe
{
    [DAArtistService findMostPopularWithCallback:^(NSMutableArray *list){
        [super refreshed];
        
        self.artistList = list;
        [self.tableView reloadData];
    }];
}

#pragma mark - TableView delegate & datasource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.artistList count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DAArtistCellV *cell =[tableView dequeueReusableCellWithIdentifier:@"artistListCell"];
    
    if(!cell){
        cell = [[DAArtistCellV alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"artistListCell"];
    }
    
    NSDictionary *artist = (NSDictionary *)[self.artistList objectAtIndex:indexPath.row];
    cell.artist = artist;
    
    // 设置回调
//    cell.opBtnClickCallback = ^void(NSInteger index){
//        if(self.curExpandIndex == index){
//            self.curExpandIndex = -1;
//        }else
//            self.curExpandIndex = index;
//        [self.tableView beginUpdates];
//        [self.tableView endUpdates];
//    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *artist = (NSDictionary *)[self.artistList objectAtIndex:indexPath.row];
    DAProfileC *profileC = [[DAProfileC alloc] init];
    profileC.artist = artist;
    [self.navigationController pushViewController:profileC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
