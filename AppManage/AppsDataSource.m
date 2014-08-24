//
//  AppsDataSource.m
//  AppManage
//
//  Created by chen on 14-8-22.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "AppsDataSource.h"

#import "SimpleAppData.h"

@interface AppsDataSource ()
{
    NSMutableArray *_arData;
}

@end

@implementation AppsDataSource

- (void)awakeFromNib
{
    // Prepare some example events
    // In a real app, these should be retrieved from the calendar data store (EventKit.framework)
    // We use a very simple data format for our events. In a real calendar app, event times should be
    // represented with NSDate objects and correct calendrical date calculcations should be used.
    [self initData];
}

- (id)init
{
    self = [super init];
    
    [self initData];
    
    return self;
}

- (void)initData
{
    NSArray *arTemp = @[@"电话", @"短信", @"通讯录", @"浏览器",
                        @"日历", @"时钟", @"计算器", @"地图",
                        @"天气", @"图库", @"计算器", @"地图",
                        @"电话", @"短信", @"通讯录", @"浏览器",
                        @"天气", @"图库", @"计算器", @"地图"];
    _arData = [NSMutableArray new];
    [arTemp enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop)
    {
        SimpleAppData *appdata = [SimpleAppData randomAppObjectWithTitle:obj];
        [_arData addObject:appdata];
    }];
}

#pragma mark - CalendarDataSource

// The layout object calls these methods to identify the events that correspond to
// a given index path or that are visible in a certain rectangle

- (id)eventAtIndexPath:(NSIndexPath *)indexPath
{
    return _arData[indexPath.item];
}

- (int)deleteAtIndexPath:(NSIndexPath *)indexPath
{
    [_arData removeObjectAtIndex:indexPath.row];
    
    return indexPath.row;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_arData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<AppObject> appObject = _arData[indexPath.item];
    QHAppsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:COLLECTIONVIEWCELL forIndexPath:indexPath];
    
    if (self.configureCellBlock)
    {
        self.configureCellBlock(cell, indexPath, appObject);
    }
    return cell;
}

@end
