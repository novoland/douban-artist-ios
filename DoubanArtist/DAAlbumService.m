//
//  DAAlbumService.m
//  DoubanArtist
//
//  Created by liujing on 14/12/17.
//
//

#import "DAAlbumService.h"

@implementation DAAlbumService

+ (void) findPhotosByAlbumId:(NSString *) albumId callback:(DAApiCallback) cb{
    [DAUtils invokeApiWithPath:@"photos" Params:@{@"id":albumId} callback:^(id json){
        if(cb){
            cb([((NSDictionary *)json) objectForKey:@"photos"]);
        }
    }];
}

@end
