//
//  DATrackCellVTableViewCell.h
//  DoubanArtist
//
//  Created by liujing on 14/11/21.
//
//

#import <UIKit/UIKit.h>

// callbacks, 参数是 cell 的 index
typedef void (^OpBtnClicked)(NSInteger);

@interface DATrackCellV : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UIButton *opBtn;
@property (weak, nonatomic) IBOutlet UIView *cellContentView;
@property (assign,nonatomic) NSInteger index;
/*
 {
 "count": 16591,
 "picture": "http://img3.douban.com/view/site/median/public/f12464319e54470.jpg",
 "name": "夜鸟 - 《诗遇上歌》",
 "artist": "程璧",
 "rank": 1,
 "id": "539332",
 "length": "4:26",
 "artist_id": "167954",
 "src": "http://mr4.douban.com/201411231114/603c6f4aba2dae3d523ef2df83d7d79f/view/musicianmp3/mp3/x16722733.mp3",
 "widget_id": "17874749"
 }
 */
@property (strong,nonatomic) NSDictionary *track;

//// block 分配在栈上，退栈则销毁，因此用 copy
@property (copy,nonatomic) OpBtnClicked opBtnClickCallback;

- (IBAction)clickOpBtn:(id)sender;

@end
