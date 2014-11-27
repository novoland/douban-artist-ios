//
//  DATrackService.m
//  DoubanArtist
//
//  Created by liujing on 14/11/22.
//
//

#import "DATrackService.h"

@implementation DATrackService

// 单曲排行榜
+ (void) findMostPopularWithCallback:(DAApiCallback) cb{
    [DAUtils invokeApiWithPath:@"chart" Params:@{@"type":@"song"} callback:^(id json){
        if(cb){
            cb([((NSDictionary *)json) objectForKey:@"songs"]);
        }
    }];
}

@end
