//
//  DAHottestTrackC.h
//  DoubanArtist
//
//  Created by liujing on 14-11-20.
//
//

#import <UIKit/UIKit.h>
#import "DARefreshableContentTableC.h"

@interface DAHottestTrackC : DARefreshableContentTableC

@property(strong,nonatomic) NSMutableArray *trackList;
@property(assign,nonatomic) NSInteger curExpandIndex;

@end
