//
//  DAUpdateCellV.h
//  DoubanArtist
//
//  Created by liujing on 14/12/18.
//
//

#import "DAProfileSubListCellV.h"

@interface DAUpdateCellV : DAProfileSubListCellV

@property(strong,nonatomic) UILabel *abstractLabel;
@property(strong,nonatomic) UIImageView *iconView;

+ (NSInteger) getHeightForUpdate:(NSDictionary *) update;

@end
