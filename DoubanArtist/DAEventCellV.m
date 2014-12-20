//
//  DAEventCellV.m
//  DoubanArtist
//
//  Created by liujing on 14/11/25.
//
//

#import "DAEventCellV.h"
#import "UIImageView+WebCache.h"

@implementation DAEventCellV

- (void) setModel:(NSDictionary *)model{
    [super setModel:model];
    self.textLabel.text = [model objectForKey:@"title"];
    self.detailTextLabel.text = [model objectForKey:@"abstract"];
    [self.imageView sd_setImageWithURL:[model objectForKey:@"icon"] placeholderImage:[UIImage imageNamed:@"IconTrackDefault"]];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self applyAppStyle];
    self.imageView.frame = CGRectMake(10,10,40,40);
    self.textLabel.frame = CGRectMake(60,self.textLabel.frame.origin.y,self.textLabel.frame.size.width - 60 + self.textLabel.frame.origin.x,self.textLabel.frame.size.height);
    self.detailTextLabel.frame = CGRectMake(60,self.detailTextLabel.frame.origin.y + 4,self.detailTextLabel.frame.size.width - 60 + self.detailTextLabel.frame.origin.x,self.detailTextLabel.frame.size.height);
    self.separatorInset = UIEdgeInsetsMake(0, 60, 0, 0);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
