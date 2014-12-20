//
//  DAAlbumC.m
//  DoubanArtist
//
//  Created by liujing on 14/12/17.
//
//

#import "DAAlbumC.h"
#import "DAArtistService.h"
#import "DAAlbumCellV.h"
#import "MBProgressHUD.h"
#import "DAAlbumService.h"
#import "MWPhotoBrowser.h"

@interface DAAlbumC ()

@property(strong,nonatomic) NSMutableArray *photos;

@end

@implementation DAAlbumC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refresh: (UIRefreshControl *) refresh{
    [DAArtistService findAlbumsByArtistId:[self.artist objectForKey:@"id"] callback:^(NSArray *albums){
        [super refreshed];
        self.list = albums;
        [self.tableView reloadData];
    }];
}

- (NSString *) getBlankPlaceholderStr {
    return @"该音乐人暂未创建相册";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (DAProfileSubListCellV *) createCellForIndexPath:(NSIndexPath *) indexPath{
    DAAlbumCellV *cell = [[DAAlbumCellV alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    [DAAlbumService findPhotosByAlbumId:[[self.list objectAtIndex:indexPath.row] objectForKey:@"id"] callback:^(NSArray *photos){
        [hud hide:YES];
        
        // 将拿到的 photos 数组转成 MWPhotoBrowser 需要的格式
        _photos = [[NSMutableArray alloc] init];
        if(photos && [photos count] > 0){
            for (int i=0; i<[photos count]; i++) {
                NSDictionary *p = [photos objectAtIndex:i];
                MWPhoto *newp = [MWPhoto photoWithURL:[NSURL URLWithString:[p valueForKey:@"url"]]];
                NSString *desc = (NSString *)[p valueForKey:@"desc"];
                newp.caption = [desc length] > 0? desc:nil;
                [_photos addObject:newp];
            }
        }
        
        // Create browser (must be done each time photo browser is
        // displayed. Photo browser objects cannot be re-used)
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        
        // Set options
        browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
        browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
        browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
        browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
        browser.alwaysShowControls = YES; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
        browser.enableGrid = NO; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
        browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
        
        // Present
        [self.navigationController pushViewController:browser animated:YES];
    }];
}


#pragma MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}


@end
