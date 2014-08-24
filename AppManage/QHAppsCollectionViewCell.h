//
//  QHAppsCollectionViewCell.h
//  AppManage
//
//  Created by chen on 14-8-22.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define COLLECTIONVIEWCELL  @"collectionviewcell"
#define APP_DELETE_TAG 946

@class QHAppsCollectionViewCell;

@protocol QHAppsCollectionViewCellDelegate <NSObject>

- (void)deleteAppsCell:(QHAppsCollectionViewCell *)collectionViewCell;

@end

@interface QHAppsCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *iconTitleLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *deleteView;

@property (nonatomic, weak) id<QHAppsCollectionViewCellDelegate> delegate;

@end
