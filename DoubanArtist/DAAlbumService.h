//
//  DAAlbumService.h
//  DoubanArtist
//
//  Created by liujing on 14/12/17.
//
//

#import <Foundation/Foundation.h>
#import "DAUtils.h"

@interface DAAlbumService : NSObject

// [upload_time":"2014-01-29","photo_id":"2168229676","url":"http://a.jpg","uploader_name":"0封未","order":0,"desc":""]
+ (void) findPhotosByAlbumId:(NSString *) albumId callback:(DAApiCallback) cb;

@end
