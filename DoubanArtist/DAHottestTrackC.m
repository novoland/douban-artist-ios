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
#import "POP.h"

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
    UINib *nib = [UINib nibWithNibName:@"DATrackCellV" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"trackListCell"];
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
    static NSInteger INIT_CELL_HEIGHT = 72;
    // If our cell is selected, return double height
    if(self.curExpandIndex == indexPath.row) {
        return INIT_CELL_HEIGHT + 40;
    }
    
    // Cell isn't selected so return single height
    return INIT_CELL_HEIGHT;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.trackList count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DATrackCellV *cell =[tableView dequeueReusableCellWithIdentifier:@"trackListCell"];
    
    NSDictionary *track = (NSDictionary *)[self.trackList objectAtIndex:indexPath.row];
    cell.index = indexPath.row;
    cell.track = track;
    
    // 设置回调
    cell.opBtnClickCallback = ^void(NSInteger index){
        if(self.curExpandIndex == index){
            self.curExpandIndex = -1;
        }else
            self.curExpandIndex = index;
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
        
//        NSIndexPath *path = [[NSIndexPath alloc] init];
//        path.section = 0;
//        
//        DATrackCellV *cell = (DATrackCellV *)[tableView cellForRowAtIndexPath:];
        
//        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
//        anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 400, 400)];
//        [layer pop_addAnimation:anim forKey:@"size"];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"dfdafdaf");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
