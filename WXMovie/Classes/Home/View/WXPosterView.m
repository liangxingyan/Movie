//
//  WXPosterView.m
//  WXMovie
//
//  Created by mac2 on 16/7/20.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXPosterView.h"
#import "WXPosterCell.h"
#import "WXPosterDetail.h"
#import "WXSmallView.h"


@interface WXPosterView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/** cell */
@property (nonatomic, weak) WXPosterCell *cell;

/** 头部视图 */
@property (nonatomic, weak) UIImageView *headView;

/** 小海报 */
@property (nonatomic, weak) WXSmallView *smallView;

/** 大海报 */
@property (nonatomic, weak) UICollectionView *posterView;

/** 蒙版 */
@property (nonatomic, weak) UIView *hud;

/** 按钮 */
@property (nonatomic, weak) UIButton *btn;

@end

@implementation WXPosterView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        // 创建海报
        [self createPosterView];
        
        // 创建头部视图
        [self setUpHeadView];
        
        // 添加观察者
        [self.smallView addObserver:self
               forKeyPath:@"index" // 监听的值
                  options:NSKeyValueObservingOptionNew
                  context:nil];
    }
    return self;
    
}

#pragma mark - 头部视图
- (void)setUpHeadView {
    
    // 添加蒙版
    UIView *hud = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WScreen, HScreen)];
    hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    hud.hidden = YES;
    self.hud = hud;
    [self addSubview:hud];
    
    UIImageView *headView = [[UIImageView alloc] init];
    self.headView = headView;
    headView.userInteractionEnabled = YES;
    headView.frame = CGRectMake(0, -64+38, WScreen, 130);
    // 图片拉伸
    UIImage *image = [UIImage imageNamed:@"indexBG_home"];

    UIImage *stresImage = [image stretchableImageWithLeftCapWidth:0 topCapHeight:1];
    
    headView.image = stresImage;
    
    [self addSubview:headView];
    
    // 加collectionView
    [self createHeadView];
    
    
}

- (void)createHeadView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

    WXSmallView *small = [[WXSmallView alloc] initWithFrame:CGRectMake(0, 0, WScreen, self.headView.height - 40) collectionViewLayout:layout];
    
    layout.itemSize = CGSizeMake(100, self.headView.height-40);
    layout.minimumLineSpacing = 50;
    // 水平滑动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    small.showsHorizontalScrollIndicator = NO;
    
    [self.headView addSubview:small];
    
    self.smallView = small;
    
    // 创建按钮
    UIButton *button = [[UIButton alloc] init];
    self.btn = button;
    button.frame = CGRectMake((self.headView.width - 20)/2, self.headView.height - 20, 20, 20);
    [button setImage:[UIImage imageNamed:@"down_home"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"up_home"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:button];
}

#pragma mark - 显示或隐藏
- (void)shouHead {
    
    [UIView animateWithDuration:0.35 animations:^{
        
        self.headView.transform = CGAffineTransformMakeTranslation(0, self.headView.height-42);
        self.hud.hidden = NO;
        
    }];
}

- (void)hiddenHead {
    
    [UIView animateWithDuration:0.35 animations:^{
        
        self.headView.transform = CGAffineTransformIdentity;
        self.hud.hidden = YES;
        
    }];
}

- (void)selectedAction:(UIButton *)btn {

    if (!btn.selected) {
        
        [self shouHead];
        
    } else {
        
        [self hiddenHead];
    }
    
    btn.selected = !btn.selected;
}

- (void)setMovies:(NSArray *)movies {
    _movies = movies;
    self.smallView.movies = movies;
}

#pragma mark - 海报视图
- (void)createPosterView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    UICollectionView *posterView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, WScreen, self.height) collectionViewLayout:layout];
    self.posterView = posterView;
    layout.itemSize = CGSizeMake(WScreen-100, self.height-100);
    layout.minimumLineSpacing = 50;
    // 水平滑动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    posterView.backgroundColor = [UIColor orangeColor];
    posterView.hidden = NO;
    // 分页效果
//    posterView.pagingEnabled = YES;
    posterView.dataSource = self;
    posterView.delegate = self;
    posterView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:posterView];
    
    // 注册
    [posterView registerClass:[WXPosterCell class] forCellWithReuseIdentifier:@"cell"];
    
    
}

#pragma mark - 数据源<UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WXPosterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.movie = self.movies[indexPath.row];
    self.cell = cell;
    return cell;
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 50, 0, 50);
}

// 选择
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {


    WXPosterCell *cell = (WXPosterCell *)[collectionView cellForItemAtIndexPath:indexPath];

    [cell hiddenDetail];
    
}

#pragma mark - scrollView的代理

// 做这个功能一定要关闭分页效果
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    // 1.根据偏移量来计算第几个item
    CGFloat offSetX = targetContentOffset->x;
    
    // 2.item的宽度
    CGFloat itemWidth = WScreen - 100;
    
    // 3.页码的宽度
    NSInteger pageWith = itemWidth + 50;
    
    // 4.根据偏移量计算第几页
    NSInteger pageNum = (offSetX + pageWith/2) / pageWith;
    
    // 5.根据第几个item改变偏移量
    targetContentOffset->x = pageWith * pageNum;
    
    self.smallView.posterIndex = pageNum;
}

#pragma mark - 观察者
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    NSInteger index = [[change objectForKey:@"new"]integerValue];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    
    
    [UIView animateWithDuration:0.35 animations:^{
        
        [self.posterView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }];
    
}

#pragma mark - 手动移除观察者
- (void) dealloc {
    [self.smallView removeObserver:self forKeyPath:@"index"];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hiddenHead];
    self.btn.selected = NO;
}

@end
