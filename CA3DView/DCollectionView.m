//
//  DCollectionView.m
//  CA3DView
//
//  Created by 魏唯隆 on 2017/6/27.
//  Copyright © 2017年 魏唯隆. All rights reserved.
//

#import "DCollectionView.h"
#import "LayoutView.h"

@interface DCollectionView() <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
{
    LayoutView *_layout;
    NSInteger _curIndex;
}
@end

static CGFloat itemWidth = 130;
static CGFloat itemHight = 190;

@implementation DCollectionView

- (NSInteger)currentIndex {
    return _curIndex;
}

- (instancetype)initWithFrame:(CGRect)frame {
    _layout = [[LayoutView alloc]init];
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self = [super initWithFrame:frame collectionViewLayout:_layout];
    if(self){
        [self _initView];
    }
    return self;
}

- (void)_initView {
    _curIndex = 1;
    self.delegate = self;
    self.dataSource = self;
    self.pagingEnabled = NO;
 
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
}

#pragma mark collection协议
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imgDatas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imgDatas[indexPath.row]]];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 8;
    return cell;
}

// 设置每个块的宽、高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(itemWidth, itemHight);
}

// 四个边缘的间隙
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 5, 0, 5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    _curIndex = indexPath.row;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSInteger scrIndex = scrollView.contentOffset.x/(itemWidth + 10);
    // 当停止拖拽时，view不在滑动时才执行，还在滑动则调用scrollViewDidEndDecelerating
    if(!decelerate){
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:scrIndex + 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        _curIndex = scrIndex + 1;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger scrIndex = scrollView.contentOffset.x/(itemWidth + 10);
    
    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:scrIndex + 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    _curIndex = scrIndex + 1;
}

@end
