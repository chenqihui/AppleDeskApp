//
//  QHCollectionViewLayout.m
//  AppManage
//
//  Created by chen on 14-8-21.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "QHCollectionViewLayout.h"

@implementation QHCollectionViewLayout

- (CGSize)collectionViewContentSize
{
    // Don't scroll horizontally
//    CGFloat contentWidth = self.collectionView.bounds.size.width;
//    CGFloat contentHeight = self.collectionView.bounds.size.height;
//    CGRect r = [self frameForIndexPath:[NSIndexPath indexPathForItem:7 inSection:1]];
    
//    return CGSizeMake(contentWidth, r.size.height + r.origin.y);//需要动态计算
    
    return self.collectionView.bounds.size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    //    CGSize size = self.collectionView.frame.size;
    //    CGPoint _center = CGPointMake(size.width / 2.0, size.height / 2.0);
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    attributes.alpha = 1.0;
    attributes.frame = [self frameForIndexPath:path];
    //    attributes.center = CGPointMake(_center.x, _center.y);
    
    return attributes;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attributes = [NSMutableArray array];
    for (NSInteger i = 0 ; i < 8; i++)
    {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForInsertedItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (CGRect)frameForIndexPath:(NSIndexPath *)path
{
    float h = 100;
    CGRect frame = CGRectZero;
    frame.origin.x = 0;
    frame.origin.y = [path row]*100;
    frame.size.width = 100;
    frame.size.height = h;
    
    //    frame = CGRectInset(frame, HorizontalSpacing/2.0, 0);
    
    return frame;
}

@end
