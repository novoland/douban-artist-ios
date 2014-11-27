//
//  DAProfileC.h
//  DoubanArtist
//
//  Created by liujing on 14/11/23.
//
//

#import <UIKit/UIKit.h>
#import "DZNSegmentedControl.h"

@interface DAProfileC : UIViewController <DZNSegmentedControlDelegate>

@property(strong,nonatomic) NSDictionary *artist;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImg;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UIImageView *blurBgImg;

@property (strong, nonatomic) NSArray *subControllers;

@end
