//
//  DAPlaylistInProfileCellV.m
//  DoubanArtist
//
//  Created by liujing on 14/11/25.
//
//

#import "DAPlaylistInProfileCellV.h"

@implementation DAPlaylistInProfileCellV

- (void) setModel:(NSDictionary *)model{
    [super setModel:model];
    self.textLabel.text = [model objectForKey:@"title"];
}

- (void)awakeFromNib {
    // Initialization code
}

@end
