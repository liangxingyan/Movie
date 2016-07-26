//
//  WXHomeViewController.m
//  WXMovie
//
//  Created by mac2 on 16/7/18.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXHomeViewController.h"
#import "WXMovie.h"
#import "WXMovieCell.h"
#import "UIImageView+WebCache.h"
#import "WXPosterView.h"

@interface WXHomeViewController () <UITableViewDataSource>

/** 列表按钮 */
@property (nonatomic, weak) UIButton *listBtn;

/** 海报按钮 */
@property (nonatomic, weak) UIButton *posterBtn;

/** 切换按钮父视图 */
@property (nonatomic, weak) UIView *exchangeView;

/** 列表视图 */
@property (nonatomic, weak) UIView *listView;

/** 海报视图 */
@property (nonatomic, weak) WXPosterView *posterView;

/** 电影模型 */
@property (nonatomic, strong) NSMutableArray *movies;

@end

@implementation WXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建导航栏右边按钮
    [self createRightNavigationBarItem];
    
    // 获取json数据
    [self getJsonData];
    
    // 创建海报视图
    [self createPosterView];
    
    // 创建列表视图
    [self createListView];
    
    
    
}

#pragma mark - 获取json数据
- (void)getJsonData {
    
    // 1.路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"us_box" ofType:@"json"];
    
    // 2.解析json
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    // 3.创建模型数组
    self.movies = [[NSMutableArray alloc] init];
    
    NSArray *subjects = [dict objectForKey:@"subjects"];
    
    // 4.遍历数组
    for (NSDictionary *dict in subjects) {
        
        NSDictionary *data = [dict objectForKey:@"subject"];
        WXMovie *movie = [[WXMovie alloc] init];
        movie.rating = data[@"rating"];
        movie.title = data[@"title"];
        movie.collect_count = [data[@"collect_count"] integerValue];
        movie.images = data[@"images"];
        movie.year = [data[@"year"] integerValue];
        movie.original_title = data[@"original_title"];
        [self.movies addObject:movie];
        
    }
}

#pragma mark - 创建导航栏右边按钮
- (void)createRightNavigationBarItem {
    
    // 1.创建一个父视图
    UIView *exchangeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 49, 25)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:exchangeView];
    
    
    // 2.创建两个子按钮
    
    // 列表按钮
    UIButton *listBtn = [[UIButton alloc] init];
    listBtn.frame = CGRectMake(0, 0, 49, 25);
    [listBtn setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home"] forState:UIControlStateNormal];
    [listBtn setImage:[UIImage imageNamed:@"list_home"] forState:UIControlStateNormal];
    [listBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    listBtn.hidden = YES;
    self.listBtn = listBtn;
    [exchangeView addSubview:listBtn];
    
    // 海报按钮
    UIButton *posterBtn = [[UIButton alloc] init];
    [posterBtn setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home"] forState:UIControlStateNormal];
    [posterBtn setImage:[UIImage imageNamed:@"poster_home"] forState:UIControlStateNormal];
    [posterBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    posterBtn.hidden = NO;
    posterBtn.frame = CGRectMake(0, 0, 49, 25);
    self.posterBtn = posterBtn;
    [exchangeView addSubview:posterBtn];
    
    self.exchangeView = exchangeView;
    
}

// 点击事件
- (void)buttonAction {
    
    UIViewAnimationOptions option;
    
    if (self.listBtn.hidden) {
        option = UIViewAnimationOptionTransitionFlipFromLeft;
        self.navigationItem.title = @"列表";
        
    } else {
        
        option = UIViewAnimationOptionTransitionFlipFromRight;
        self.navigationItem.title = @"北美榜";
    }
    
    // 添加动画
    [UIView transitionWithView:self.exchangeView duration:0.5 options:option animations:^{
        
        self.listBtn.hidden = !self.listBtn.hidden;
        self.posterBtn.hidden = !self.posterBtn.hidden;
        
    } completion:nil];
    
    [UIView transitionWithView:self.view duration:0.5 options:option animations:^{
        self.listView.hidden = !self.listView.hidden;
        self.posterView.hidden = !self.posterView.hidden;
    } completion:nil];
    
}

#pragma mark - 创建列表视图
- (void)createListView {
    
    UITableView *listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WScreen, HScreen) style:UITableViewStylePlain];
    listView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    listView.backgroundColor = [UIColor clearColor];
    listView.rowHeight = 150;
    listView.dataSource = self;
    listView.hidden = YES;
    self.listView = listView;
    [self.view addSubview:self.listView];
    
    // 注册
    [listView registerNib:[UINib nibWithNibName:NSStringFromClass([WXMovieCell class]) bundle:nil] forCellReuseIdentifier:@"movie"];
    
}

#pragma mark - 创建海报视图
-  (void)createPosterView {
    
    // 创建海报视图
    WXPosterView *posterView = [[WXPosterView alloc] initWithFrame:CGRectMake(0, 0, WScreen, HScreen-64-49)];
    posterView.movies = self.movies;
    posterView.hidden = NO;
    self.posterView = posterView;
    
    [self.view addSubview:posterView];
    
}

#pragma mark - 数据源<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.movies.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    WXMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movie"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.movie = self.movies[indexPath.row];
    
    return cell;
}



@end
