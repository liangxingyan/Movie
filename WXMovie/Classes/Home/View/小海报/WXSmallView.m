//
//  WXSmallView.m
//  WXMovie
//
//  Created by mac2 on 16/7/26.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXSmallView.h"
#import "WXSmallCell.h"

@interface WXSmallView () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation WXSmallView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        [self createHead];
        
        [self addObserver:self forKeyPath:@"posterIndex" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}

- (void)createHead {

    self.dataSource = self;
    self.delegate = self;
    
    // 注册
    [self registerClass:[WXSmallCell class] forCellWithReuseIdentifier:@"cell"];

}

#pragma mark - 数据源<UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.movies.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WXSmallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.movie = self.movies[indexPath.row];
    return cell;

    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, (self.width-100)/2, 0, (self.width-100)/2);
}

#pragma mark - scrollView的代理

// 做这个功能一定要关闭分页效果
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    // 1.根据偏移量来计算第几个item
    CGFloat offSetX = targetContentOffset->x;
    
    // 2.item的宽度
    CGFloat itemWidth = 100;
    
    // 3.页码的宽度
    NSInteger pageWith = itemWidth + 50;
    
    // 4.根据偏移量计算第几页
    NSInteger pageNum = (offSetX + pageWith/2) / pageWith;
    
    // 5.根据第几个item改变偏移量
    targetContentOffset->x = pageWith * pageNum;
    
    self.index = pageNum;
}


#pragma mark - 观察者
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    NSInteger index = [[change objectForKey:@"new"]integerValue];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    
    
    [UIView animateWithDuration:0.35 animations:^{
        
        [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }];
    
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"posterIndex"];
}

@end
