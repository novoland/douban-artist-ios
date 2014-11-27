//
//  DAArtistService.m
//  DoubanArtist
//
//  Created by liujing on 14/11/23.
//
//

#import "DAArtistService.h"

@implementation DAArtistService

// 音乐人排行榜
+ (void) findMostPopularWithCallback:(DAApiCallback) cb{
    [DAUtils invokeApiWithPath:@"chart" Params:@{@"type":@"artist"} callback:^(id json){
        if(cb){
            cb([((NSDictionary *)json) objectForKey:@"artists"]);
        }
    }];
}

+ (void) findEventsByArtistId:(NSString *) artistId callback:(DAApiCallback) cb{
    [DAUtils invokeApiWithPath:@"artist_event" Params:@{@"id":artistId} callback:^(id json){
        if(cb){
            cb([((NSDictionary *)json) objectForKey:@"events"]);
        }
    }];
}

@end
