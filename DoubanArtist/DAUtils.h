//
//  DAUtils.h
//  DoubanArtist
//
//  Created by liujing on 14/11/23.
//
//

#import <Foundation/Foundation.h>
#import "DAUtils.h"

typedef void (^DAApiCallback)(id);

@interface DAUtils : NSObject

// invoke api
// TODO 登陆则加入账号信息
+ (void) invokeApiWithPath:(NSString *) path Params:(NSDictionary *)params
                  callback:(DAApiCallback) cb;


// view helper
+ (void)addBlurToView:(UIView *)view;

@end
