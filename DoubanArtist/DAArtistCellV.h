//
//  FMMainTableViewCell.h
//  FreeMusic
//
//  Created by zhaojianguo-PC on 14-5-28.
//  Copyright (c) 2014年 xiaozi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAArtistCellV: UITableViewCell
    
@property (nonatomic,strong) UIImageView * imgView;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) NSDictionary * artist;

@end
