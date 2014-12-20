//
//  DAUpdateCellV.m
//  DoubanArtist
//
//  Created by liujing on 14/12/18.
//
//

#import "DAUpdateCellV.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define ABSTRACT_LABEL_HEIGHT 50

@implementation DAUpdateCellV

+ (NSInteger) getHeightForUpdate:(NSDictionary *) u{
//    NSString *kind = [u objectForKey:@"kind"];
    NSString *abstract = [u objectForKey:@"abstract"];
    NSString *icon = [u objectForKey:@"icon"];
    
    NSInteger baseHeight = 50;
    NSInteger abstractHeight = 0;
    
    if((abstract && [abstract length]) || (icon && [icon length])){
        abstractHeight = ABSTRACT_LABEL_HEIGHT;
    }
    return baseHeight + abstractHeight + 16;
    
    /*
     Comment *toComment = (Comment *)obj;
     CGFloat curWidth = kScreen_Width - 40 - 2*kPaddingLeftWidth;
     cellHeight += 10 +[toComment.content getHeightWithFont:kTweetDetailCommentCell_FontContent constrainedToSize:CGSizeMake(curWidth, CGFLOAT_MAX)] + 5 +20 +10
     */
}

- (void) setModel:(NSDictionary *)model{
    [super setModel:model];
    self.textLabel.text = [self getTitle];
    self.detailTextLabel.text = [model objectForKey:@"time"];
    
    [self.iconView removeFromSuperview];
    self.iconView = [[UIImageView alloc] init];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[self getIcon]] placeholderImage:[UIImage imageNamed:@"IconTrackDefault"]];
    [self addSubview:self.iconView];
    
    [self.abstractLabel removeFromSuperview];
    self.abstractLabel = [[UILabel alloc] init];
    [self addSubview:_abstractLabel];
    _abstractLabel.text = [self getAbstract];
    
//    [self.badgeView removeFromSuperview];
//    self.badgeView = [[LKBadgeView alloc] init];
//    self.badgeView.horizontalAlignment = LKBadgeViewHorizontalAlignmentLeft;
//    [self addSubview:self.badgeView];
//    self.badgeView.text = [self getBadgeText];
    
}

- (NSString *) getTitle{
    NSString *title = [self.model objectForKey:@"title"];
    return title && [title length] ? [NSString stringWithFormat:@"[%@] %@", [self getBadgeText], [self.model objectForKey:@"title"]] : nil;
}

- (NSString *) getAbstract{
    NSString *abstract = [self.model objectForKey:@"abstract"];
    return abstract && [abstract length] ? abstract : nil;
}

- (NSString *) getIcon{
    NSString *icon = [self.model objectForKey:@"icon"];
    return icon && [icon length] ? icon : nil;
}

- (NSString *) getBadgeText{
    NSString *kind = [self.model objectForKey:@"kind"];
    if ([@"note" isEqualToString:kind]) {
        return @"日记";
    }
    
    if ([@"song" isEqualToString:kind]) {
        return @"单曲";
    }
    
    if ([@"topic" isEqualToString:kind]) {
        return @"话题";
    }
    
    if ([@"event" isEqualToString:kind]) {
        return @"活动";
    }
    
    if ([@"photo" isEqualToString:kind]) {
        return @"照片";
    }
    
    return nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self applyAppStyle];
    // title abstract(可选) time，icon(可选)
    
    NSInteger iconPadding = 16, iconWidth = 60,
    cellWidth = self.frame.size.width,
    cellHeight = self.frame.size.height,
    textX = CGRectGetMinX(self.textLabel.frame),
    textWidth = cellWidth - textX * 2;
    
    // title
    self.textLabel.frame = CGRectMake(textX, 8, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
    
    // icon
    if([self getIcon]){
        self.iconView.frame = CGRectMake(cellWidth - iconPadding - iconWidth,cellHeight - iconPadding - iconWidth,iconWidth,iconWidth);
        textWidth = textWidth - iconWidth - iconPadding * 2;
    }
    
    // abstract
    if(_abstractLabel){
        _abstractLabel.frame = CGRectMake(textX, CGRectGetMaxY(self.textLabel.frame) + 8, textWidth, ABSTRACT_LABEL_HEIGHT);
        [_abstractLabel setNumberOfLines:3];
        _abstractLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _abstractLabel.font = kCellDetailFont;
    }
    
    // time
    self.detailTextLabel.frame = CGRectMake(textX, cellHeight - 24,textWidth,self.detailTextLabel.frame.size.height);
    self.detailTextLabel.textColor = kCellDetailColor;
}

@end
