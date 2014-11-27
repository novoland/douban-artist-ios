//
//  DARootC.h
//  DoubanArtist
//
//  Created by liujing on 14-11-20.
//
//

#import <UIKit/UIKit.h>
#import "DAPlayerC.h"

@interface DARootC : UIViewController

@property (nonatomic, strong) UINavigationController *navController;
@property (nonatomic, strong) DAPlayerC *playerController;

- (id) initWithNavController:(UINavigationController *) navController
            playerController:(DAPlayerC *) playerController;

@end
