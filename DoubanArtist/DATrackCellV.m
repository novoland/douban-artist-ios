//
//  DATrackCellVTableViewCell.m
//  DoubanArtist
//
//  Created by liujing on 14/11/21.
//
//

#import "DATrackCellV.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation DATrackCellV

- (void)awakeFromNib {
    // Initialization code
    self.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    self.img.frame = CGRectMake(10,10,40,40);
}

- (IBAction)clickOpBtn:(id)sender {
    self.opBtnClickCallback(self.index);
}

- (void) setTrack:(NSDictionary *)track{
    _track = track;
    
    self.nameLabel.text = [track objectForKey:@"name"];
    self.artistLabel.text = [track objectForKey:@"artist"];
    [self.img sd_setImageWithURL:[NSURL URLWithString:[track valueForKey:@"picture"]]
                placeholderImage:[UIImage imageNamed:@"IconTrackDefault"]];
}
@end
