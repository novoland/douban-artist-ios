//
//  DARootC.m
//  DoubanArtist
//
//  Created by liujing on 14-11-20.
//
//

#import "DARootC.h"
#import "DAConstants.h"

@interface DARootC ()

@end

@implementation DARootC

- (id) initWithNavController:(UINavigationController *) navController
            playerController:(DAPlayerC *) playerController
{
    self = [super init];
    if(self){
        self.navController = navController;
        self.playerController = playerController;
        
        // 父子 controller 的概念及作用：
        // http://stackoverflow.com/a/17332864
        // 主要用于（系统自动）传递事件
        [self addChildViewController:navController];
        [self addChildViewController:playerController];
    }
    return self;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    // 为子 controller 的 view 设置正确的 frame，并将其 view 作为子 view 加入 root controller 的 view。
    [self.navController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - DA_PLAYER_INITIAL_HEIGHT)];
    [self.playerController.view setFrame:CGRectMake(0, self.view.frame.size.height - DA_PLAYER_INITIAL_HEIGHT, self.view.frame.size.width, DA_PLAYER_INITIAL_HEIGHT)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.navController.view];
    [self.view addSubview:self.playerController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
