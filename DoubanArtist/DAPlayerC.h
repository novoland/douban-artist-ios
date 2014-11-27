//
//  DAPlayerC.h
//  DoubanArtist
//
//  Created by liujing on 14-11-20.
//
//

#import <UIKit/UIKit.h>

@interface DAPlayerC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *trackImg;
@property (weak, nonatomic) IBOutlet UILabel *trackTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

- (IBAction)clickListBtn:(id)sender;
- (IBAction)clickPlayBtn:(id)sender;
- (IBAction)clickNextBtn:(id)sender;


@end
