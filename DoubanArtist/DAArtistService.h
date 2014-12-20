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
// [{title:,id:,cover:}]
+ (void) findAlbumsByArtistId:(NSString *) artistId callback:(DAApiCallback) cb;
//
+ (void) findArtistById:(NSString *)artistId callback:(DAApiCallback) cb;

/**
 
 [
    {
        "kind": "song",
         "artist_img": "http://img3.douban.com/view/site/median/public/b985c473e841f92.jpg",
         "artist": "旅行団",
         "title": "天后舞厅",
         "song_id": "448407",
         "time": "2014-01-09 12:22:28",
         "widget_id": "10220174"   // playlist id
    },
 
    {
        "kind": "event",
         "artist_img": "http://img3.douban.com/view/site/median/public/b985c473e841f92.jpg",
         "artist": "旅行団",
         "url": "http://www.douban.com/event/20652645/",
         "abstract": "2014-02-14 20:30:00\n东大街菊花园饮马池 正信智能大厦 负一层",
         "title": "2.14-情人节特献：旅行团乐队新EP《于是我不再唱歌》全国巡演西安站",
         "time": "2014-01-07 05:07:24",
         "icon": "http://img3.douban.com/view/event_poster/small/public/e61a745be4f90b6.jpg"
    },
    
    {
         "kind": "note",
         "artist_img": "http://img3.douban.com/view/site/median/public/b985c473e841f92.jpg",
         "artist": "旅行団",
         "url": "http://site.douban.com/thelifejourney/widget/notes/376894/note/322794186/",
         "abstract": "【在线购买】 这是旅行团成立至今最温情的一张唱片。EP包含5首歌曲，其中的三首《B...",
         "title": "旅行团全新EP《于是我不再唱歌》现已上...",
         "time": "2013-12-24 04:06:07"
    },
 
    {
        "kind":"photo",
        "artist_img":"http:\/\/img3.douban.com\/view\/site\/median\/public\/f7db39d0b317326.jpg",
        "photo_id":"1285725060",
        "artist":"胡爱唯",
        "album_id":"1002435",
        "time":"2011-11-04 23:06:46",
        "title":"",
        "order":29,
        "icon":"http:\/\/img3.douban.com\/view\/photo\/albumicon\/public\/p1285725060.jpg"
    }
 ]
 
 [{"kind":"photo","artist_img":"http:\/\/img3.douban.com\/view\/site\/median\/public\/f7db39d0b317326.jpg","photo_id":"1285725060","artist":"胡爱唯","album_id":"1002435","time":"2011-11-04 23:06:46","title":"",order:29,icon:}]
 */
+ (void) findUpdatesByArtistId:(NSString *) artistId callback:(DAApiCallback) cb;

// [{content:,author:,icon:,time:}]
+ (void) findMessagesByArtistId:(NSString *) artistId callback:(DAApiCallback) cb;

@end
