//
//  DACommentCellV.m
//  DoubanArtist
//
//  Created by liujing on 14/12/19.
//
//

#import "DAMessageCellV.h"

#define kMessageCell_FontContent [UIFont systemFontOfSize:14]

@implementation DAMessageCellV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (NSInteger) getHeightForMessage:(NSDictionary *)msg{
    CGFloat cellHeight = 0;
    CGFloat curWidth = kScreen_Width - 40 - 2*kPaddingLeftWidth;
    NSLog(@"a: %f",[[msg objectForKey:@"content"] getHeightWithFont:kMessageCell_FontContent constrainedToSize:CGSizeMake(curWidth, CGFLOAT_MAX)]);
    cellHeight += 10 +[[msg objectForKey:@"content"] getHeightWithFont:kMessageCell_FontContent constrainedToSize:CGSizeMake(curWidth, CGFLOAT_MAX)] + 5 +20 +10;
    return cellHeight;
}

// content, author, time, icon
- (void) setModel:(NSDictionary *)model{
    [super setModel:model];
    
    // content
    self.textLabel.text = [model objectForKey:@"content"];
    
    // icon
    [self.imageView sd_setImageWithURL:[model objectForKey:@"icon"] placeholderImage:[UIImage imageNamed:@"IconTrackDefault"]];
    
    // author + time
    NSString *author = [model objectForKey:@"author"],
    *time = [model objectForKey:@"time"],
    *detail = [NSString stringWithFormat:@"%@ 发表于 %@", author,time];
    
    self.detailTextLabel.text = detail;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self applyAppStyle];
    
    CGFloat curBottomY = 10,
    textWidth = kScreen_Width - 40 - 2*kPaddingLeftWidth;
    
    self.imageView.frame = CGRectMake(kPaddingLeftWidth,curBottomY,33,33);
    [self.imageView doCircleFrame];
    
    // 评论内容自适应高度
    self.textLabel.font = kMessageCell_FontContent;
    self.textLabel.frame = CGRectMake(kPaddingLeftWidth + 40, curBottomY,textWidth,0);
//    [self.textLabel sizeToFit]; // 这句效果一样
    [self.textLabel setLongString:[self.model objectForKey:@"content"] withFitWidth:textWidth];
    
    curBottomY += CGRectGetHeight(self.textLabel.frame) + 5;
    self.detailTextLabel.frame = CGRectMake(kPaddingLeftWidth + 40, curBottomY, textWidth, 20);
    
    self.separatorInset = UIEdgeInsetsMake(0, kPaddingLeftWidth + 40, 0, 0);
}

@end
