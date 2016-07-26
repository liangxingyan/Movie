//
//  WXCinemaViewController.m
//  WXMovie
//
//  Created by mac2 on 16/7/18.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXCinemaViewController.h"
#import "WXCinemaCell.h"
#import "WXDistrict.h"
#import "WXCinema.h"

#define NULL_TO_NIL(obj) ({ __typeof__ (obj) __obj = (obj); __obj == [NSNull null] ? nil : obj; })



@interface WXCinemaViewController () <UITableViewDataSource, UITableViewDelegate> {
    // 作用：存放每一个分组的状态
    BOOL isOpen[19];
}

/** 影院模型 */
@property (nonatomic, strong) NSMutableArray *cinemas;

/** 地区模型 */
@property (nonatomic, strong) NSMutableArray *districts;

/** 背景图片 */
@property (nonatomic, weak) UIImageView *imageView;

/** 表视图 */
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation WXCinemaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载数据
    [self loadData];
    
    // 创建表视图
    [self setupTableView];
}

#pragma mark - 加载数据
- (void)loadData {
    
    self.cinemas = [NSMutableArray array];
    NSString *cinemaPath = [[NSBundle mainBundle] pathForResource:@"cinema_list" ofType:@"json"];
    NSData *cinemaData = [NSData dataWithContentsOfFile:cinemaPath];
    NSDictionary *cinemaDictData = [NSJSONSerialization JSONObjectWithData:cinemaData options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *cinemaList = cinemaDictData[@"cinemaList"];
    
    for (NSDictionary *dict in cinemaList) {
        WXCinema *cinema = [[WXCinema alloc] init];
        cinema.lowPrice = NULL_TO_NIL([dict objectForKey:@"lowPrice"]);
        cinema.grade = dict[@"grade"];
        cinema.name = dict[@"name"];
        cinema.districtId = [dict[@"districtId"] integerValue];
        cinema.address = dict[@"address"];
        [self.cinemas addObject:cinema];
    }
    
    
    self.districts = [NSMutableArray array];
    
    // 路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"district_list" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    // 遍历
    NSArray *array = dictData[@"districtList"];
    for (NSDictionary *dict in array) {
        WXDistrict *district = [[WXDistrict alloc] init];
        district.name = dict[@"name"];
        district.ID = [dict[@"id"] integerValue];
        
        district.cinema = [NSMutableArray array];
        
        for (WXCinema *cinema in self.cinemas) {
            if (district.ID == cinema.districtId) {
                [district.cinema addObject:cinema];
            }
        }
        
        [self.districts addObject:district];
    }
    
}

#pragma mark - 创建表视图
- (void)setupTableView {
    
    UITableView *tablView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WScreen, HScreen) style:UITableViewStylePlain];
    tablView.dataSource = self;
    tablView.delegate = self;
    tablView.rowHeight = 100;
    tablView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    tablView.backgroundColor = [UIColor clearColor];
    self.tableView = tablView;
    [self.view addSubview:tablView];
    
    // 注册
    [tablView registerNib:[UINib nibWithNibName:NSStringFromClass([WXCinemaCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.districts.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (isOpen[section]) {
        return 0;
    }
    
    WXDistrict *district = self.districts[section];
    return district.cinema.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WXCinemaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    WXDistrict *district = self.districts[indexPath.section];
    cell.cinema = district.cinema[indexPath.row];
    return cell;
    
}


#pragma mark - 创建头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(0, 0, WScreen, 50);
    [button setBackgroundImage:[UIImage imageNamed:@"hotMovieBottomImage"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 1000 + section;
    
    WXDistrict *district = self.districts[section];
    [button setTitle:district.name forState:UIControlStateNormal];
    
    return button;

}

- (void)tapAction:(UIButton *)tap {
    //a) 获取点击的分组section
    NSInteger section = tap.tag - 1000;
    
    //b) 修改分组的状态位
    isOpen[section] = !isOpen[section];
    
    //c) 定义一个IndexSet集合，作用：将section转换为set类型
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:section];

    //d) 重新加载section
    [self.tableView reloadSections:set
                  withRowAnimation:UITableViewRowAnimationNone];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

@end
