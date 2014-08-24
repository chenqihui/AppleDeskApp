//
//  AppsDataSource.h
//  AppManage
//
//  Created by chen on 14-8-22.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QHAppsCollectionViewCell.h"
#import "AppObject.h"

typedef void (^ConfigureCellBlock)(QHAppsCollectionViewCell *cell, NSIndexPath *indexPath, id<AppObject> appObj);

@interface AppsDataSource : NSObject<UICollectionViewDataSource>

@property (copy, nonatomic) ConfigureCellBlock configureCellBlock;

- (id<AppObject>)eventAtIndexPath:(NSIndexPath *)indexPath;

- (int)deleteAtIndexPath:(NSIndexPath *)indexPath;

@end
