//
//  WXMoreViewController.m
//  WXMovie
//
//  Created by mac2 on 16/7/18.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXMoreViewController.h"
#import "SDImageCache.h"

@interface WXMoreViewController () <UITableViewDataSource, UITableViewDelegate>

/** 图片数据 */
@property (nonatomic, strong) NSArray *imageArray;

/** title */
@property (nonatomic, strong) NSArray *titles;

/** 缓存 */
@property (nonatomic, weak) UILabel *label;

/** 表视图 */
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation WXMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    // 数据
    self.imageArray = @[@"moreClear", @"moreScore", @"moreVersion", @"moreBusiness", @"moreWelcome", @"moreAbout"];
    
    self.titles = @[@"清除缓存", @"给个评价", @"检查新版本", @"商务合作", @"欢迎页", @"关于"];
    
    // 创建tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WScreen, HScreen) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.contentInset = UIEdgeInsetsMake(64 + 50, 0, 49, 0);
    tableView.rowHeight = 50;
    tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

- (void)viewWillAppear:(BOOL)animated {
    // 获取缓存
    NSUInteger size = [[SDImageCache sharedImageCache] getSize];
    // 默认是b，显示的是MB
    self.label.text = [NSString stringWithFormat:@"%.2fMB", size/1024.0/1024.0];

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    if (indexPath.row == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WScreen - 100, 0, 100, 30)];
        label.centerY = tableView.rowHeight*0.5;
        label.textColor = [UIColor whiteColor];
        [cell.contentView addSubview:label];
        // 获取缓存
        NSUInteger size = [[SDImageCache sharedImageCache] getSize];
        // 默认是b，显示的是MB
        label.text = [NSString stringWithFormat:@"%.2fMB", size/1024.0/1024.0];

        self.label = label;
    }
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.textLabel.text = self.titles[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        // 创建alterControl
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定清除所有缓存" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            // 获取缓存
            [[SDImageCache sharedImageCache] clearDisk];
            
            // 获取缓存
            NSUInteger size = [[SDImageCache sharedImageCache] getSize];
            // 默认是b，显示的是MB
            self.label.text = [NSString stringWithFormat:@"%.2fMB", size/1024.0/1024.0];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        }];
                                    
        [alert addAction:okAction];
        [alert addAction:cancelAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
