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

+ (void) findArtistById:(NSString *)artistId callback:(DAApiCallback)cb{
    [DAUtils invokeApiWithPath:@"artist_playlist" Params:@{@"id":artistId} callback:^(id json){
        if(cb){
            cb((NSDictionary *)json);
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

+ (void) findAlbumsByArtistId:(NSString *) artistId callback:(DAApiCallback) cb{
    [DAUtils invokeApiWithPath:@"artist_album" Params:@{@"id":artistId} callback:^(id json){
        if(cb){
            cb([((NSDictionary *)json) objectForKey:@"albums"]);
        }
    }];
}

+ (void) findUpdatesByArtistId:(NSString *) artistId callback:(DAApiCallback) cb{
    [DAUtils invokeApiWithPath:@"artist_update" Params:@{@"id":artistId} callback:^(id json){
        if(cb){
            cb([((NSDictionary *)json) objectForKey:@"updates"]);
        }
    }];
}

+ (void) findMessagesByArtistId:(NSString *) artistId callback:(DAApiCallback) cb{
    [DAUtils invokeApiWithPath:@"artist_board" Params:@{@"id":artistId} callback:^(id json){
        if(cb){
            cb([((NSDictionary *)json) objectForKey:@"messages"]);
        }
    }];
}

@end
