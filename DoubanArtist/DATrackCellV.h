//
//  DATrackCellVTableViewCell.h
//  DoubanArtist
//
//  Created by liujing on 14/11/21.
//
//

#import <UIKit/UIKit.h>

#define kTrackCellFullHeight 70
#define kTrackCellNoLengthHeight 62

// callbacks, 参数是 cell 的 index
typedef void (^OpBtnClicked)(NSInteger);

@interface DATrackCellV : UITableViewCell

// ui controls
@property (strong, nonatomic) UILabel *rankLabel;
// img -- img
// textLabel -- name
// detailLabel -- artist
@property (strong, nonatomic) UILabel *lengthLabel;
@property (strong, nonatomic) UIButton *opBtn;

// 控制控件是否显示
@property (assign, nonatomic) BOOL isShowRank;
@property (assign, nonatomic) BOOL isShowImg;
@property (assign, nonatomic) BOOL isShowLength;
@property (assign, nonatomic) BOOL isShowArtist;
@property (assign, nonatomic) BOOL isShowOpBtn;

// data
@property (assign,nonatomic) NSInteger rank;
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

/// block 分配在栈上，退栈则销毁，因此用 copy
@property (copy,nonatomic) OpBtnClicked opBtnClickCallback;
@property (copy,nonatomic) void(^imgClicked)(NSDictionary *track);

@end
