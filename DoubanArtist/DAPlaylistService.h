//
//  DAPlaylistService.h
//  DoubanArtist
//
//  Created by liujing on 14/11/25.
//
//

#import <Foundation/Foundation.h>
#import "DAUtils.h"

@interface DAPlaylistService : NSObject

// [{id:,title:}]
+ (void) findPlaylistsByArtistId:(NSString *) artistId callback:(DAApiCallback) cb;

@end
