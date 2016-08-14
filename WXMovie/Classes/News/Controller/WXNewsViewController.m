//
//  WXNewsViewController.m
//  WXMovie
//
//  Created by mac2 on 16/7/18.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXNewsViewController.h"
#import "WXNews.h"
#import "WXNewsCell.h"
#import "UIImageView+WebCache.h"
#import "WXWebViewController.h"
#import "WXImageViewController.h"

@interface WXNewsViewController () <UITableViewDataSource, UITableViewDelegate>

/** 新闻模型 */
@property (nonatomic, strong) NSMutableArray *news;

/** 表视图 */
@property (nonatomic, weak) UITableView *tableView;

/** 头部图片 */
@property (nonatomic, weak) UIImageView *imageView;

/** title */
@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation WXNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 数据解析
    [self loadData];
    
    // 创建表视图
    [self setupTableView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[WXSkinTool skinToolWithImageName:@"bg"]];
}

#pragma mark - 数据解析
- (void)loadData {
    
    self.news = [NSMutableArray array];
    
    // 路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"news_list" ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *dict in dataArray) {
        WXNews *news = [[WXNews alloc] init];
        news.title = dict[@"title"];
        news.image = dict[@"image"];
        news.type = [dict[@"type"] boolValue];
        news.summary = dict[@"summary"];
        [self.news addObject:news];
    }
    
}

#pragma mark - 表视图
- (void)setupTableView {
    // 创建
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WScreen, HScreen) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    tableView.rowHeight = 100;
    self.tableView = tableView;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // 创建头部视图
    [self setupHeaderView];
    
    // 注册
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WXNewsCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)setupHeaderView {
    
    // 放一个空view,制造假象
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WScreen, 250)];
    view.backgroundColor = [UIColor greenColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 64, WScreen, 200+50);
    WXNews *news = [self.news firstObject];
    self.imageView = imageView;
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:news.image]];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.height-30+64, WScreen, 30)];
    title.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    title.text = news.title;
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = title;
    
    self.tableView.tableHeaderView = view;
    
    // 在self.view放imageview，实现放大的效果
    [self.view addSubview:imageView];
    [self.view addSubview:title];
    
    
    // 移除第一条数据
    [self.news removeObjectAtIndex:0];

}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    WXNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.news = self.news[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}


#pragma mark - scroview代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y > -64) { // 往上拉，图片跟着滚
        
        self.imageView.top = - scrollView.contentOffset.y;
        
        self.titleLabel.top = - scrollView.contentOffset.y + 220;
        
    } else { // 往下拉，实现放大
        
        CGFloat newHeight = ABS(scrollView.contentOffset.y + 64) + 250;
        // 375       200
        // newWidth  newHeight
        CGFloat newWidth = 375*newHeight/250;
        
        self.imageView.frame = CGRectMake(-(newWidth-WScreen)/2, 64, newWidth, newHeight);
        self.titleLabel.frame = CGRectMake(0, 34+newHeight, WScreen, 30);
        
    }
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WXNews *news = self.news[indexPath.row];

    if (news.type) {
        
        WXImageViewController *imageVc = [[WXImageViewController alloc] init];
        imageVc.view.backgroundColor = [UIColor whiteColor];
        imageVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:imageVc animated:YES];
        
    } else {

        WXWebViewController *webVc = [[WXWebViewController alloc] init];
        webVc.view.backgroundColor = [UIColor whiteColor];
        webVc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:webVc animated:YES];
        
    }
}

@end
