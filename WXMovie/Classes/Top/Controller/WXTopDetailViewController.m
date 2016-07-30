//
//  WXTopDetailViewController.m
//  WXMovie
//
//  Created by mac2 on 16/7/23.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXTopDetailViewController.h"
#import "WXDetailCell.h"
#import "WXDetail.h"
#import "WXDetailHeadView.h"
#import "WXDetailHead.h"

@interface WXTopDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 评论模型 */
@property (nonatomic, strong) NSMutableArray *details;

/** head模型 */
@property (nonatomic, strong) WXDetailHead *head;

@end

@implementation WXTopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 加载数据
    [self loadData];
    
    // 加载头部视图
    [self setupHeadView];
    
    self.tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WXDetailCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

#pragma mark - 加载数据
- (void)loadData {
    
    // 路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"movie_comment" ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *listArray = dict[@"list"];
    
    self.details = [NSMutableArray array];
    
    for (NSDictionary *dict in listArray) {
        
        WXDetail *detail = [[WXDetail alloc] init];
        detail.userImage = dict[@"userImage"];
        detail.nickname = dict[@"nickname"];
        detail.rating = [dict[@"rating"] floatValue];
        detail.content = dict[@"content"];
     
        [self.details addObject:detail];
    }
    
}

#pragma mark - 头部视图
- (void)setupHeadView {
    
    
    // 加载head模型
   NSString *path = [[NSBundle mainBundle] pathForResource:@"movie_detail" ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    self.head = [[WXDetailHead alloc] init];
    self.head.image = dict[@"image"];
    self.head.titleCn = dict[@"titleCn"];
    self.head.directors = dict[@"directors"];
    self.head.type = dict[@"type"];
    self.head.actors = dict[@"actors"];
    self.head.Toprelease = dict[@"release"];
    self.head.videos = dict[@"videos"];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WScreen, 250)];
    view.backgroundColor = [UIColor redColor];
    
    WXDetailHeadView *headView = [[[NSBundle mainBundle] loadNibNamed:@"WXDetailHeadView" owner:self options:nil] lastObject];
    headView.head = self.head;
    headView.frame = CGRectMake(0, 0, WScreen, 250);
    
    [view addSubview:headView];
    self.tableView.tableHeaderView = view;
}


#pragma mark -  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.details.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WXDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.details = self.details[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WXDetail *detail = self.details[indexPath.row];
    
    CGSize maxSize = CGSizeMake(WScreen - 110, MAXFLOAT);
    
    CGFloat textH = [detail.content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height;
    
    return textH + 81;
}

@end
