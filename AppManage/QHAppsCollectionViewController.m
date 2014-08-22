//
//  QHAppsCollectionViewController.m
//  AppManage
//
//  Created by chen on 14-8-21.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "QHAppsCollectionViewController.h"

#import "QHCollectionViewLayout.h"
#import "QHAppsCollectionViewCell.h"
#import "AppsDataSource.h"

#import "SimpleAppData.h"

@interface QHAppsCollectionViewController ()<UICollectionViewDelegate>//UICollectionViewDataSource,
{
    UIScrollView *_mainScrollV;
    UICollectionView *_firstCollectionV;
    QHCollectionViewLayout *_layout;
    UICollectionViewFlowLayout *_flowLayout;
    
    AppsDataSource *_appsDataSource;
    
    UIView *_bottomMenuV;
    NSMutableArray *_arData;
}

@end

@implementation QHAppsCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createView];
}

- (void)createView
{
//    [self initData];
    [self.view setBackgroundColor:[UIColor orangeColor]];
    
    _mainScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(10, self.statusBarView.bottom, self.view.width - 20, 0)];
    [self.view addSubview:_mainScrollV];
    
    float nWidth = _mainScrollV.width/4;
    float nHeight = nWidth * 1.05;
    
    _mainScrollV.height = nHeight * 5;
    
    _layout = [[QHCollectionViewLayout alloc] init];
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(nWidth, nHeight);
    _flowLayout.minimumInteritemSpacing = 0;
    _firstCollectionV = [[UICollectionView alloc] initWithFrame:_mainScrollV.bounds collectionViewLayout:_flowLayout];
    [_firstCollectionV registerClass:[QHAppsCollectionViewCell class] forCellWithReuseIdentifier:COLLECTIONVIEWCELL];
    _firstCollectionV.delegate = self;
//    _firstCollectionV.dataSource = self;
    _firstCollectionV.backgroundColor = [UIColor clearColor];
    [_mainScrollV addSubview:_firstCollectionV];
    
    _appsDataSource = [[AppsDataSource alloc] init];
    _firstCollectionV.dataSource = _appsDataSource;
//    _appsDataSource = (AppsDataSource *)_firstCollectionV.dataSource;
    _appsDataSource.configureCellBlock = ^(QHAppsCollectionViewCell *cell, NSIndexPath *indexPath, id<AppObject> appObj)
    {
        cell.iconTitleLabel.text = appObj.appTitle;
    };
    
    _bottomMenuV = [[UIView alloc] initWithFrame:CGRectMake(0, _mainScrollV.bottom + 20, self.view.width, self.view.height - _mainScrollV.bottom - 20)];
    [_bottomMenuV setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_bottomMenuV];
    UIView *bgBottomMenuV = [[UIView alloc] initWithFrame:_bottomMenuV.bounds];
    [bgBottomMenuV setBackgroundColor:[UIColor whiteColor]];
    [bgBottomMenuV setAlpha:0.3];
    [_bottomMenuV addSubview:bgBottomMenuV];
}

//- (void)initData
//{
//    NSArray *arTemp = @[@"电话", @"短信", @"通讯录", @"浏览器", @"日历", @"时钟", @"计算器", @"地图", @"天气", @"图库"];//
//    _arData = [NSMutableArray new];
//    [arTemp enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop)
//     {
//         SimpleAppData *appdata = [SimpleAppData randomAppObjectWithTitle:obj];
//         [_arData addObject:appdata];
//     }];
//}
//
//#pragma mark - UICollectionViewDataSource
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return [_arData count];
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    id<AppObject> appObject = _arData[indexPath.item];
//    QHAppsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:COLLECTIONVIEWCELL forIndexPath:indexPath];
//    
//    cell.titleL.text = appObject.appTitle;
//    
//    return cell;
//}

@end
