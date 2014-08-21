//
//  AppsMainViewController.m
//  AppManage
//
//  Created by chen on 14-8-21.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "AppsMainViewController.h"

#import "QHAppsButton.h"

@interface AppsMainViewController ()
{
    NSMutableArray *_arData;
    
    UIView *_bottomMenuV;
}

@end

@implementation AppsMainViewController

- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor blackColor]];
//    [self.view setBackgroundColor:[UIColor colorWithRed:241/255 green:241/255 blue:241/255 alpha:1]];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 20, self.view.width - 2 * 10, self.view.height)];
    [bgView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:bgView];
    
    float nSpaceX = 10;
    float nSpaceY = 5;
    float nWidth = bgView.width/4;
    float nHeight = nWidth * 1.15;
    
    bgView.height = nHeight * 5;
    
    for (int j = 0; j < 5; j++)
    {
        for (int i = 0; i < 4; i++)
        {
            //算法1，居中排列计算：i * (nWidth + nSpaceX) + (i + 1) * nSpaceX
//            QHAppsButton *btn = [[QHAppsButton alloc] initWithFrame:CGRectMake(i * (nWidth + nSpaceX) + (i + 1) * nSpaceX, j * (nHeight + nSpaceY) + (j + 1) * nSpaceY, nWidth, nHeight)];
            
            QHAppsButton *btn = [[QHAppsButton alloc] initWithFrame:CGRectMake(i * nWidth, j * nHeight, nWidth, nHeight)];
            btn.appsTitle = @"测试";
            btn.nSpaceX = nSpaceX;
            btn.nSpaceY = nSpaceY;
            btn.iconBackgroundColor = [QHCommonUtil getRandomColor];
//            btn.backgroundColor = [QHCommonUtil getRandomColor];
            [bgView addSubview:btn];
        }
    }
    
    _bottomMenuV = [[UIView alloc] initWithFrame:CGRectMake(0, bgView.bottom + 20, self.view.width, self.view.height - bgView.bottom - 20)];
    [_bottomMenuV setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_bottomMenuV];
    UIView *bgBottomMenuV = [[UIView alloc] initWithFrame:_bottomMenuV.bounds];
    [bgBottomMenuV setBackgroundColor:[UIColor whiteColor]];
    [bgBottomMenuV setAlpha:0.3];
    [_bottomMenuV addSubview:bgBottomMenuV];
    
}

- (void)initData
{
    NSArray *arTemp = @[@"电话", @"短信", @"通讯录", @"浏览器", @"日历", @"时钟", @"计算器", @"地图", @"天气", @"图库"];
    _arData = [NSMutableArray new];
    [_arData addObjectsFromArray:arTemp];
}

@end
