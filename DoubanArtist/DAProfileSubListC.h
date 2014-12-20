//
//  DAProfileSubListC.h
//  DoubanArtist
//
//  Created by liujing on 14/11/25.
//
//

#import <UIKit/UIKit.h>
#import "DARefreshableContentTableC.h"

@interface DAProfileSubListC : DARefreshableContentTableC

@property(strong,nonatomic) NSDictionary *artist;
@property(strong,nonatomic) NSArray *list;
@property(strong,nonatomic) NSString *cellIdentifier;

- (id) initWithArtist:(NSDictionary *) artist
       cellIdentifier:(NSString *) cellId;

@end
