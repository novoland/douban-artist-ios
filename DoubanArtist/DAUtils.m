//
//  DAUtils.m
//  DoubanArtist
//
//  Created by liujing on 14/11/23.
//
//

#import "DAUtils.h"
#import "AFNetworking.h"
#import "DAConstants.h"

@implementation DAUtils

+ (void) invokeApiWithPath:(NSString *) path Params:(NSDictionary *)params
                  callback:(DAApiCallback) cb{
    params = [self prepareParams:params];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:DA_API]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager.requestSerializer setValue:@"text/javascript" forHTTPHeaderField:@"Accept"];
//    [manager.requestSerializer setValue:@"*" forHTTPHeaderField:@"User-Agent"];
    
    [manager GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 从原始 jsonp 中提取响应内容，并转成 dict
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *jsonStr = [string substringWithRange:NSMakeRange([DA_API_CB length] + 1, [string length] - [DA_API_CB length] - 3) ];
        
        NSError* error;
        NSDictionary *json =
        [NSJSONSerialization JSONObjectWithData: [jsonStr dataUsingEncoding:NSUTF8StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: &error];
        
        if(cb)
            cb(json);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

+ (NSMutableDictionary *)prepareParams:(NSDictionary *)params
{
    NSMutableDictionary *result = [params mutableCopy];
    if (!result) {
        result = [NSMutableDictionary new];
    }
    
    // Here adding some parameters that required on every request
    [result setObject:DA_API_CB forKey:@"cb"];
    [result setObject:DA_APP_NAME forKey:@"app_name"];
    [result setObject:DA_API_VERSION forKey:@"version"];
    
    // TODO 已登陆账号信息
//    'user_id':curUser.user_id,
//    'token':curUser.token,
//    'expire':curUser.expire
    
    return result;
}

+ (void)addBlurToView:(UIView *)view {
    UIView *blurView = nil;
    
    if([UIBlurEffect class]) { // iOS 8
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurView.frame = view.frame;
        
    } else { // workaround for iOS 7
        blurView = [[UIToolbar alloc] initWithFrame:view.bounds];
    }
    
    [blurView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [view addSubview:blurView];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[blurView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(blurView)]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[blurView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(blurView)]];
}

@end
