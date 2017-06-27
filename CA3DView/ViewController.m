//
//  ViewController.m
//  CA3DView
//
//  Created by 魏唯隆 on 2017/6/26.
//  Copyright © 2017年 魏唯隆. All rights reserved.
//

#import "ViewController.h"
#import "DCollectionView.h"

@interface ViewController ()
{
    NSMutableArray *_imgDatas;
    
    DCollectionView *_collectionView;
    
}

@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation ViewController

CGFloat screenWidth;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initView];
}

- (void)_initView {
    
    _imgDatas = @[].mutableCopy;
    for (int i=1; i<=9; i++) {
        [_imgDatas addObject:[NSString stringWithFormat:@"%d.jpg", i]];
    }
    screenWidth = [UIScreen mainScreen].bounds.size.width;

    _collectionView = [[DCollectionView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, _bgView.bounds.size.height)];
    _collectionView.imgDatas = _imgDatas;
    [_bgView addSubview:_collectionView];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
