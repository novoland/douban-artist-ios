//
//  DAPlayerC.h
//  DoubanArtist
//
//  Created by liujing on 14-11-20.
//
//

#import <UIKit/UIKit.h>
#import <STKAudioPlayer.h>

@interface DAPlayerC : UIViewController<STKAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *trackImg;
@property (weak, nonatomic) IBOutlet UILabel *trackTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (strong, nonatomic) UIProgressView *progressBar;

- (IBAction)clickListBtn:(id)sender;
- (IBAction)clickPlayBtn:(id)sender;
- (IBAction)clickNextBtn:(id)sender;


@end
