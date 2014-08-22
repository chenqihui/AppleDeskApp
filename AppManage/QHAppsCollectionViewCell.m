//
//  QHAppsCollectionViewCell.m
//  AppManage
//
//  Created by chen on 14-8-22.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "QHAppsCollectionViewCell.h"

@interface QHAppsCollectionViewCell ()
{
    float _nSpaceX;
    float _nSpaceY;
}

@end

@implementation QHAppsCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _nSpaceX = 10;
    _nSpaceY = 5;
    
//    [self.contentView setFrame:CGRectMake(_nSpaceX, _nSpaceY, self.contentView.frame.size.width - 2 * _nSpaceX, self.contentView.frame.size.height - 2 * _nSpaceY)];
    
    _iconImageView = [[UIImageView alloc] init];
    [_iconImageView setBackgroundColor:[UIColor greenColor]];
    [self setView:_iconImageView];
    [self.contentView addSubview:_iconImageView];
    
    _iconTitleLabel = [[UILabel alloc] init];
    [_iconTitleLabel setBackgroundColor:[UIColor clearColor]];
    [_iconTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_iconTitleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [_iconTitleLabel setTextColor:[UIColor whiteColor]];
    [self.contentView addSubview:_iconTitleLabel];
}

- (void)layoutSubviews
{
    float width = MIN(self.contentView.frame.size.width - _nSpaceX * 2, self.contentView.frame.size.width - _nSpaceY * 2);
    [_iconImageView setFrame:CGRectMake(_nSpaceX, _nSpaceY, width, width)];
    [_iconTitleLabel setFrame:CGRectMake(0, CGRectGetMaxY(_iconImageView.frame), self.contentView.frame.size.width, (self.contentView.frame.size.height - CGRectGetMaxY(_iconImageView.frame)))];
}

- (void)setView:(UIView *)view
{
    //设置圆角度数
    view.layer.cornerRadius = 12;
    //设置边框的宽度
    view.layer.borderWidth = 1;
    //设置边框颜色
    view.layer.borderColor = [[UIColor whiteColor] CGColor];
}

@end
