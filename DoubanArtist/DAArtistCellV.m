//
//  FMMainTableViewCell.m
//  FreeMusic
//
//  Created by zhaojianguo-PC on 14-5-28.
//  Copyright (c) 2014年 xiaozi. All rights reserved.
//

#import "DAArtistCellV.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation DAArtistCellV

-(void)setArtist:(NSDictionary *)artist
{
    _artist = artist;
    /*
     {
     "picture": "http://img3.douban.com/view/site/median/public/ee5967b9751afe7.jpg",
     "style": "流派: 民谣 Folk",
     "added": "no",
     "name": "马頔",
     "rank": 1,
     "member": "成员: ",
     "follower": 63354,
     "type": "artist",
     "id": "108463"
     }
     */
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[artist objectForKey:@"picture"]] placeholderImage:[UIImage imageNamed:@"IconTrack"]];
    self.nameLabel.text = [artist objectForKey:@"name"];
    self.titleLabel.text = @"<无信息>";
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType =UITableViewCellAccessoryDisclosureIndicator;

        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 60, 60)];
        [self.contentView addSubview:self.imgView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imgView.frame.size.width+self.imgView.frame.origin.x+5, self.imgView.frame.origin.y, self.contentView.frame.size.width-self.imgView.frame.size.width-self.imgView.frame.origin.x-30, 30)];
        
        self.nameLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        [self.contentView addSubview:self.nameLabel];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.size.height+self.nameLabel.frame.origin.y+5, self.nameLabel.frame.size.width, self.nameLabel.frame.size.height-10)];
        self.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        self.titleLabel.textColor = [UIColor lightGrayColor];

        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
