//
//  LayoutView.m
//  CA3DView
//
//  Created by 魏唯隆 on 2017/6/27.
//  Copyright © 2017年 魏唯隆. All rights reserved.
//

#import "LayoutView.h"

static CGFloat ActiveDistance = 400;
static CGFloat ScaleFactor = 0.5;

@implementation LayoutView
// 返回存放在CGRect范围内所有视图的布局属性的一个数组
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *attArray = [super layoutAttributesForElementsInRect:rect];
    CGRect visRect;
    visRect.origin = self.collectionView.contentOffset;
    visRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes *layoutAttribute in attArray) {
        CGFloat distance = CGRectGetMidX(visRect) - layoutAttribute.center.x;
        CGFloat norDistance = fabs(distance/ActiveDistance);
        CGFloat zoom = 1- ScaleFactor * norDistance;
        layoutAttribute.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
        layoutAttribute.zIndex = 1;
    }
    
    return attArray;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
