//
//  DAPlaylistService.m
//  DoubanArtist
//
//  Created by liujing on 14/11/25.
//
//

#import "DAPlaylistService.h"
#import "DAUtils.h"

@implementation DAPlaylistService

+ (void) findPlaylistsByArtistId:(NSString *) artistId callback:(DAApiCallback) cb{
    [DAUtils invokeApiWithPath:@"artist_playlist" Params:@{@"id":artistId} callback:^(id json){
        if(cb){
            cb([((NSDictionary *)json) objectForKey:@"playlist"]);
        }
    }];
}

@end
