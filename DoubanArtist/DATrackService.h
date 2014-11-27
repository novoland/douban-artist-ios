//
//  DATrackService.h
//  DoubanArtist
//
//  Created by liujing on 14/11/22.
//
//

#import <Foundation/Foundation.h>
#import "DAUtils.h"

@interface DATrackService : NSObject

// 排行榜
/*
 format:
 [
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
 },
 {...},
 {...}
 ]
 
 */
+ (void) findMostPopularWithCallback:(DAApiCallback) cb;

@end
