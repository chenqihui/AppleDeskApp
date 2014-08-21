//
//  AppsButton.m
//  AppManage
//
//  Created by chen on 14-8-21.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "QHAppsButton.h"

@interface QHAppsButton ()
{
    UIButton *_iconButton;
    UILabel *_iconTitleLabel;
    UIImageView *_iconImageView;
}

@end

@implementation QHAppsButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createView];
        _nSpaceX = 0;
        _nSpaceY = 0;
    }
    return self;
}

- (void)createView
{
    _iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _iconImageView = [[UIImageView alloc] init];
    [_iconImageView setBackgroundColor:[UIColor orangeColor]];
    [self setView:_iconImageView];
    [self addSubview:_iconImageView];
    
    _iconTitleLabel = [[UILabel alloc] init];
    [_iconTitleLabel setBackgroundColor:[UIColor clearColor]];
    [_iconTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_iconTitleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [_iconTitleLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:_iconTitleLabel];
}

- (void)layoutSubviews
{
    float width = MIN(self.frame.size.width - _nSpaceX * 2, self.frame.size.width - _nSpaceY * 2);
    [_iconImageView setFrame:CGRectMake(_nSpaceX, _nSpaceY, width, width)];
    [_iconTitleLabel setFrame:CGRectMake(0, CGRectGetMaxY(_iconImageView.frame), self.frame.size.width, (self.frame.size.height - CGRectGetMaxY(_iconImageView.frame)))];
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

- (void)setIconBackgroundColor:(UIColor *)iconBackgroundColor
{
    [_iconImageView setBackgroundColor:iconBackgroundColor];
}

- (void)setAppsTitle:(NSString *)appsTitle
{
    [_iconTitleLabel setText:appsTitle];
}

@end
