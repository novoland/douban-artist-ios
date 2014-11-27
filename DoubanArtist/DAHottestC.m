//
//  DAHottestC.m
//  DoubanArtist
//
//  Created by liujing on 14-11-20.
//
//

#import "DAHottestC.h"
#import "UIViewController+RESideMenu.h"

@interface DAHottestC ()

@end

/*
 TODO：还是要把 lazy load 特性加上
*/

@implementation DAHottestC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //
        self.subControllers = [NSArray arrayWithObjects:[[DAHottestTrackC alloc] init],[[DAHottestArtistC alloc] init],nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    // 加入 segmentedControl 到 nav bar
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"IconMenu"] style:UIBarButtonItemStyleBordered target:self action:@selector(presentLeftMenuViewController:)];
    
    UISegmentedControl *segControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"热门单曲", @"热门音乐人", nil]];
    self.navigationItem.titleView = segControl;
    [segControl addTarget:self action:@selector(switchView:)
         forControlEvents:UIControlEventValueChanged];
    self.segControl = segControl;
    
    // settings for scroll view
    self.pageScrollView = [[DASwipePageScrollView alloc] initWithControllers: _subControllers parentController:self];
    
    // avoid "capture self in block will cause retain cycle"
    // 见 http://stackoverflow.com/questions/7853915/how-do-i-avoid-capturing-self-in-blocks-when-implementing-an-api
    __weak DAHottestC * that = self;
    self.pageScrollView.pageChangedCallback = ^void(DASwipePageScrollView *v){
        [that.segControl setSelectedSegmentIndex:v.curPage];
    };
    self.pageScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pageScrollView];
}

// 在这里做 layout（尺寸计算等），而非在 viewDidLoad 中。
// viewDidLoad 时，view 还未成为 view hierarchy 的一部分，self.view 的尺寸是0
// scrollview 在 uinavigationcontroller 中时，会默认为 window 的宽高
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    self.pageScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    // 初始选择第一个 view
    if(self.segControl.selectedSegmentIndex == -1){
        [self.segControl setSelectedSegmentIndex:0];
        [self.pageScrollView gotoPage:0 animated:YES];
    }
}

- (IBAction)switchView:(id)sender{
    NSInteger page = self.segControl.selectedSegmentIndex;
    [self.pageScrollView gotoPage:page animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
