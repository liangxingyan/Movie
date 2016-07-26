//
//  WXImageViewController.m
//  WXMovie
//
//  Created by mac2 on 16/7/23.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXImageViewController.h"
#import "WXImage.h"
#import "WXShowViewController.h"
#import "WXImagecCell.h"


@interface WXImageViewController () <UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

/** 存放image模型 */
@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation WXImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // UICollectionView
    [self setUpCollectionView];
    
    // 加载数据
    [self loadData];
    
}

#pragma mark - 加载数据
- (void)loadData {
    
    // 路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"image_list" ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
                    
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    self.images = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        
        WXImage *image = [[WXImage alloc] init];
        
        image.image = dict[@"image"];
        
        [self.images addObject:image];
    }
    
}

#pragma mark - UICollectionView初始化
- (void)setUpCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WScreen, HScreen) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    layout.itemSize = CGSizeMake(80, 80);
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [self.view addSubview:collectionView];
    
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WXImagecCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];

}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WXImagecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    cell.images = self.images[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WXShowViewController *showVC = [[WXShowViewController alloc] init];
    showVC.images = self.images;
    showVC.indexPath = indexPath;
    
    [self presentViewController:showVC animated:YES completion:nil];
    
}

@end
