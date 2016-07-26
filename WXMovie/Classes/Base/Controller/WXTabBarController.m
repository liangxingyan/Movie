//
//  WXTabBarController.m
//  WXMovie
//
//  Created by mac2 on 16/7/18.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXTabBarController.h"
#import "WXTabBarButton.h"

@interface WXTabBarController ()

/** 选中图片 */
@property (nonatomic, strong) UIImageView *selectdImage;

@end

@implementation WXTabBarController

// 这里要注意：因为storyboard创建出来的界面后显示，所有移除的方法应该写在这
- (void)viewWillAppear:(BOOL)animated {
    // 一定要记得调用父类方法
    [super viewWillAppear:animated];
    
    // 1.移除系统上的button
    [self removeSystemBtn];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 2.用自己的button
    [self createTabBarBtn];
    
}

#pragma mark - 移除系统上的button
- (void)removeSystemBtn {
    
    for (UIView *view in self.tabBar.subviews) {
        
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {

            [view removeFromSuperview];
            
        }
    }
    
}

#pragma mark - 用自己的button
- (void)createTabBarBtn {
    
    // 1.标题
    NSArray *titles = @[@"首页", @"新闻", @"Top", @"影院", @"更多"];
    
    // 2.图片
    NSArray *imageNames = @[@"movie_home", @"msg_new", @"start_top250", @"icon_cinema", @"more_setting"];
    
    // 3.按钮宽度
    CGFloat btnWidth = [UIScreen mainScreen].bounds.size.width / imageNames.count;
    
    // 4.背景图片
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tab_bg_all"];
    
    // 5.选中图片
    self.selectdImage = [[UIImageView alloc] init];
    self.selectdImage.frame = CGRectMake(0, 0, btnWidth, 49);
    self.selectdImage.image = [UIImage imageNamed:@"selectTabbar_bg_all"];
    [self.tabBar addSubview:self.selectdImage];
    
    for (NSInteger i = 0; i < imageNames.count; i++) {
        
        CGRect btnRect = CGRectMake(i * btnWidth, 0, btnWidth, 49);
        
        WXTabBarButton *button = [[WXTabBarButton alloc] initWithFrame:btnRect withTitle:titles[i] withImage:imageNames[i]];

        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        button.tag = 1000 + i;

        [self.tabBar addSubview:button];
        
    }

}

#pragma mark - 切换按钮事件
- (void)buttonAction:(UIButton *)button {
    
    self.selectedIndex = button.tag - 1000;
    
    self.selectdImage.center = button.center;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
