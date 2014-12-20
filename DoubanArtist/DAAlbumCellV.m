//
//  DAAlbumCellV.m
//  DoubanArtist
//
//  Created by liujing on 14/12/17.
//
//

#import "DAAlbumCellV.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation DAAlbumCellV

- (void) setModel:(NSDictionary *)model{
    [super setModel:model];
    self.textLabel.text = [model objectForKey:@"title"];
    [self.imageView sd_setImageWithURL:[model objectForKey:@"cover"] placeholderImage:[UIImage imageNamed:@"IconTrackDefault"]];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self applyAppStyle];
    self.imageView.frame = CGRectMake(10,10,40,40);
    self.textLabel.frame = CGRectMake(60,self.textLabel.frame.origin.y,self.textLabel.frame.size.width - 60 + self.textLabel.frame.origin.x,self.textLabel.frame.size.height);
//    self.detailTextLabel.frame = CGRectMake(60,self.detailTextLabel.frame.origin.y + 4,self.detailTextLabel.frame.size.width - 60 + self.detailTextLabel.frame.origin.x,self.detailTextLabel.frame.size.height);
    self.separatorInset = UIEdgeInsetsMake(0, 60, 0, 0);
}


@end
