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
#import "QHDialogView.h"

#define PAGECONTROL_HEIGHT 20
#define BOTTOM_ALPHA 0.3

@interface QHAppsCollectionViewController ()<UICollectionViewDelegate, UIScrollViewDelegate, QHAppsCollectionViewCellDelegate>
{
    UIScrollView *_mainScrollV;
    UICollectionView *_firstCollectionV;
    UICollectionView *_secondCollectionV;
    UICollectionView *_thirdCollectionV;
    QHCollectionViewLayout *_layout;
    UICollectionViewFlowLayout *_flowLayout;
    
    AppsDataSource *_appsDataSource;
    
    UIPageControl *_pageC;
    UIView *_bottomMenuV;
    
    BOOL _bTransform;
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
    [_mainScrollV setPagingEnabled:YES];
    [_mainScrollV setShowsHorizontalScrollIndicator:NO];
    [_mainScrollV setBackgroundColor:[UIColor yellowColor]];
    _mainScrollV.delegate = self;
    [self.view addSubview:_mainScrollV];
    
    float nWidth = _mainScrollV.width/4;
    float nHeight = nWidth * 1.15;
    
    _mainScrollV.height = nHeight * 5;
    
    {
        //        _layout = [[QHCollectionViewLayout alloc] init];
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(nWidth, nHeight);
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;//列距
    
        _firstCollectionV = [[UICollectionView alloc] initWithFrame:_mainScrollV.bounds collectionViewLayout:_flowLayout];
        [_firstCollectionV registerClass:[QHAppsCollectionViewCell class] forCellWithReuseIdentifier:COLLECTIONVIEWCELL];
        _firstCollectionV.delegate = self;
        //    _firstCollectionV.dataSource = self;
        _firstCollectionV.backgroundColor = [UIColor grayColor];
        [_mainScrollV addSubview:_firstCollectionV];
        
        _appsDataSource = [[AppsDataSource alloc] init];
        _firstCollectionV.dataSource = _appsDataSource;
        //    _appsDataSource = (AppsDataSource *)_firstCollectionV.dataSource;
        __block id this = self;
        _appsDataSource.configureCellBlock = ^(QHAppsCollectionViewCell *cell, NSIndexPath *indexPath, id<AppObject> appObj)
        {
            cell.iconTitleLabel.text = appObj.appTitle;
            [cell.iconImageView setBackgroundColor:[QHCommonUtil getRandomColor]];
            cell.delegate = this;
        };
        
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPressGestureRecognizer:)];
        [_firstCollectionV addGestureRecognizer:lpgr];
        
        UITapGestureRecognizer *tapGestureTel2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TwoPressGestureRecognizer:)];
        [tapGestureTel2 setNumberOfTapsRequired:2];
        [tapGestureTel2 setNumberOfTouchesRequired:1];
        [_firstCollectionV addGestureRecognizer:tapGestureTel2];
    }
    
    {
        UICollectionViewFlowLayout *flowLayout2 = [[UICollectionViewFlowLayout alloc] init];
        flowLayout2.itemSize = CGSizeMake(nWidth, nHeight);
        
        _secondCollectionV = [[UICollectionView alloc] initWithFrame:_mainScrollV.bounds collectionViewLayout:flowLayout2];
        _secondCollectionV.left = _mainScrollV.width;
        [_secondCollectionV registerClass:[QHAppsCollectionViewCell class] forCellWithReuseIdentifier:COLLECTIONVIEWCELL];
        _secondCollectionV.delegate = self;
        _secondCollectionV.backgroundColor = [UIColor blueColor];
        [_mainScrollV addSubview:_secondCollectionV];
    }
    
    {
        UICollectionViewFlowLayout *_flowLayout3 = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout3.itemSize = CGSizeMake(nWidth, nHeight);
        _thirdCollectionV = [[UICollectionView alloc] initWithFrame:_mainScrollV.bounds collectionViewLayout:_flowLayout3];
        _thirdCollectionV.left = _mainScrollV.width * 2;
        [_thirdCollectionV registerClass:[QHAppsCollectionViewCell class] forCellWithReuseIdentifier:COLLECTIONVIEWCELL];
        _thirdCollectionV.delegate = self;
        _thirdCollectionV.backgroundColor = [UIColor redColor];
        [_mainScrollV addSubview:_thirdCollectionV];
    }
    
    [_mainScrollV setContentSize:CGSizeMake(_mainScrollV.width * 3, _mainScrollV.height)];
    
    _pageC = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _mainScrollV.bottom, self.view.width, PAGECONTROL_HEIGHT)];
    _pageC.numberOfPages = 3;
    _pageC.centerX = _mainScrollV.centerX;
    [self.view addSubview:_pageC];
    [_pageC addTarget:self action:@selector(changePage:)forControlEvents:UIControlEventValueChanged];
    
    _bottomMenuV = [[UIView alloc] initWithFrame:CGRectMake(0, _pageC.bottom, self.view.width, self.view.height - _pageC.bottom)];
    [_bottomMenuV setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_bottomMenuV];
    UIView *bgBottomMenuV = [[UIView alloc] initWithFrame:_bottomMenuV.bounds];
    [bgBottomMenuV setBackgroundColor:[UIColor whiteColor]];
    [bgBottomMenuV setAlpha:BOTTOM_ALPHA];
    [_bottomMenuV addSubview:bgBottomMenuV];
}

#pragma mark - action

- (void)changePage:(UIPageControl *)pageC
{
    [_mainScrollV scrollRectToVisible:CGRectMake(_mainScrollV.width * pageC.currentPage, 0, _mainScrollV.width, _mainScrollV.height) animated:YES];
}

- (void)LongPressGestureRecognizer:(UIGestureRecognizer *)gr
{
    if (gr.state == UIGestureRecognizerStateBegan)
    {
        if (_bTransform)
            return;
        
        for (UIView *view in _firstCollectionV.subviews)
        {
            view.userInteractionEnabled = YES;
            if ([view isMemberOfClass:[QHAppsCollectionViewCell class]])
                [[view viewWithTag:APP_DELETE_TAG] setHidden:NO];
        }
        _bTransform = YES;
        [QHCommonUtil BeginWobble:_firstCollectionV];
    }
}

-(void)TwoPressGestureRecognizer:(UIGestureRecognizer *)gr
{
    if(_bTransform==NO)
        return;
    
    for (UIView *view in _firstCollectionV.subviews)
    {
        view.userInteractionEnabled = NO;
        if ([view isMemberOfClass:[QHAppsCollectionViewCell class]])
            [[view viewWithTag:APP_DELETE_TAG] setHidden:YES];
    }
    _bTransform = NO;
    [QHCommonUtil EndWobble:_firstCollectionV];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    _pageC.currentPage = index;
}

#pragma mark - QHAppsCollectionViewCellDelegate

- (void)deleteAppsCell:(QHAppsCollectionViewCell *)collectionViewCell
{
    NSString *appTitle = (NSString *)collectionViewCell.iconTitleLabel.text;
    QHDialogView *dialogV = [[QHDialogView alloc] initWithFrame:self.view.frame];
    [dialogV createDialogWithTitle:[NSString stringWithFormat:@"删除“%@”", appTitle] content:[NSString stringWithFormat:@"若删除“%@”，其所有数据也将被删除。", appTitle]];
    dialogV.sureBlock = ^(BOOL bSure)
    {
        NSIndexPath *indexPath = [_firstCollectionV indexPathForCell:collectionViewCell];
        [_appsDataSource deleteAtIndexPath:indexPath];
        [_firstCollectionV deleteItemsAtIndexPaths:@[indexPath]];
        
        [QHCommonUtil EndWobble:_firstCollectionV];
        [QHCommonUtil BeginWobble:_firstCollectionV];
    };
    [self.view addSubview:dialogV];
}

@end
