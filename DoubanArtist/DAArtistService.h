//
//  DAArtistService.h
//  DoubanArtist
//
//  Created by liujing on 14/11/23.
//
//

#import <Foundation/Foundation.h>
#import "DAUtils.h"

@interface DAArtistService : NSObject

+ (void) findMostPopularWithCallback:(DAApiCallback) cb;
// [{title:,url:,abstract:,month:,day:,icon:}]
+ (void) findEventsByArtistId:(NSString *) artistId callback:(DAApiCallback) cb;

@end
