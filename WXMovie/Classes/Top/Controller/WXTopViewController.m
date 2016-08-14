//
//  WXTopViewController.m
//  WXMovie
//
//  Created by mac2 on 16/7/18.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXTopViewController.h"
#import "WXTop520.h"
#import "WXTopCell.h"

@interface WXTopViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

/** top模型 */
@property (nonatomic, strong) NSMutableArray *tops;

@end

@implementation WXTopViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[WXSkinTool skinToolWithImageName:@"bg"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 解析数据
    [self loadData];
    
    // 创建集合视图
    [self setupCollectionView];
}


#pragma mark - 解析数据
- (void)loadData {
    
    // 1、拿到路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"top250" ofType:@"json"];
    
    // 2.创建tops
    self.tops = [[NSMutableArray alloc] init];
    
    // 解析json
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSArray *subjects = dict[@"subjects"];
    
    for (NSDictionary *arraydata in subjects) {
        
        WXTop520 *top = [[WXTop520 alloc] init];
        top.title = arraydata[@"title"];
        top.rating = arraydata[@"rating"];
        top.images = arraydata[@"images"];
        
        [self.tops addObject:top];
    }
    
}


#pragma mark - 创建集合视图
- (void)setupCollectionView {
 
    // 创建布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(110, 180);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WScreen, HScreen) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsVerticalScrollIndicator = NO;
    
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WXTopCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:collectionView];
}

#pragma mark - 数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tops.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WXTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.tops = self.tops[indexPath.row];
    return cell;
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 获取storyboard
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *topDetailView = [mainStoryBoard instantiateViewControllerWithIdentifier:@"TopDetail"];
    topDetailView.view.backgroundColor = [UIColor whiteColor];
    topDetailView.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:topDetailView animated:YES];
    
}

@end
