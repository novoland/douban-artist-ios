//
//  UITableViewCell+Common.m
//  DoubanArtist
//
//  Created by liujing on 14/12/20.
//
//

#import "UITableViewCell+Common.h"

@implementation UITableViewCell(Common)

- (void) applyAppStyle{
    self.textLabel.font = kCellTitleFont;
    self.textLabel.textColor = kCellTitleColor;
    
    self.detailTextLabel.font = kCellDetailFont;
    self.detailTextLabel.textColor = kCellDetailColor;
}

@end
