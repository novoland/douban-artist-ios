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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _isShowArtist = _isShowImg = _isShowLength = _isShowOpBtn = _isShowRank = YES;
        
        [self applyAppStyle];
        self.detailTextLabel.hidden = YES;
        
        _rankLabel = [UILabel new];
        _rankLabel.font = [UIFont fontWithName:@"Georgia" size:14];
//        _rankLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:_rankLabel];
        _rankLabel.hidden = YES;
        
        _lengthLabel = [UILabel new];
        _lengthLabel.font = kCellDetailFont;
        _lengthLabel.textColor = kCellDetailColor;
        [self.contentView addSubview:_lengthLabel];
        _lengthLabel.hidden = YES;
        
        _opBtn = [UIButton new];
        [_opBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
        [self.contentView addSubview:_opBtn];
        [_opBtn setBackgroundImage:[UIImage imageWithColor:kColorEEE] forState:UIControlStateHighlighted];
        _opBtn.hidden = YES;
        
        self.imageView.hidden = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked)];
        singleTap.numberOfTapsRequired = 1;
        [self.imageView setUserInteractionEnabled:YES];
        [self.imageView addGestureRecognizer:singleTap];
    }
    return self;
}

- (void) imageClicked{
    _imgClicked(_track);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x = kPaddingLeftWidth,y = 10,wrapperHeight = CGRectGetHeight( self.contentView.frame), wrapperWidth = CGRectGetWidth(self.contentView.frame);
    // rank
    if(self.isShowRank){
        _rankLabel.hidden = NO;
        CGFloat rankWidth = 20;
        _rankLabel.frame = CGRectMake(x, y, rankWidth, wrapperHeight - y);
        x += rankWidth;
    }
    // icon
    if(_isShowImg){
        CGFloat iconPadding = 4, iconHeight = wrapperHeight - 2 * iconPadding;
        self.imageView.hidden = NO;
        [self.imageView setFrame:CGRectMake(x, iconPadding, iconHeight, iconHeight)];
        x += iconHeight + 10;
        [self.imageView doCircleFrame];
    }
    
    // op btn
    CGFloat opBtnWidth = 40;
    if(_isShowOpBtn){
        _opBtn.hidden = NO;
        _opBtn.frame = CGRectMake(wrapperWidth - opBtnWidth, 0, opBtnWidth, wrapperHeight);
    }
    
    // name + length + artist
    CGFloat insetY = x,
    textWidth = wrapperWidth - x - (_isShowOpBtn?opBtnWidth:0);
    self.textLabel.frame = CGRectMake(x, y, textWidth, 14);
    
    y += 14 + 4;
    
    if(_isShowLength){
        _lengthLabel.hidden = NO;
        _lengthLabel.frame = CGRectMake(x, y, textWidth, 14);
        y += 14 + 4;
    }else{
        y += 6;
    }
    
    
    if(_isShowArtist){
        self.detailTextLabel.hidden = NO;
        self.detailTextLabel.frame = CGRectMake(x, y, textWidth, 14);
    }
    
    self.separatorInset = UIEdgeInsetsMake(0, insetY, 0, 0);
}

- (IBAction)clickOpBtn:(id)sender {
    self.opBtnClickCallback(self.rank);
}

- (void) setTrack:(NSDictionary *)track{
    _track = track;
    
    self.textLabel.text = [track objectForKey:@"name"];
    self.detailTextLabel.text = [track objectForKey:@"artist"];
    _lengthLabel.text = [track objectForKey:@"length"];
    _rankLabel.text = [NSString stringWithFormat:@"%ld",(long)_rank];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[track valueForKey:@"picture"]]
                placeholderImage:[UIImage imageNamed:@"IconTrackDefault"]];
}
@end
