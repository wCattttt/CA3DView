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
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    /*
     let array = super.layoutAttributesForElements(in: rect)
     var visibleRect = CGRect()
     visibleRect.origin = self.collectionView!.contentOffset
     visibleRect.size = self.collectionView!.bounds.size
     
     for attributes in array!{
     let distance = visibleRect.midX - attributes.center.x
     let normalizedDistance = abs(distance/ActiveDistance)
     let zoom = 1 - ScaleFactor * normalizedDistance
     attributes.transform3D = CATransform3DMakeScale(1.0, zoom, 1.0)
     attributes.zIndex = 1
     //            let alpha = 1 - normalizedDistance
     //            attributes.alpha = alpha
     }
     return array
     */
    
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
