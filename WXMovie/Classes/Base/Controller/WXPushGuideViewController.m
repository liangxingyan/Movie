//
//  WXPushGuideViewController.m
//  WXMovie
//
//  Created by mac2 on 16/7/29.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXPushGuideViewController.h"
#import "WXTabBarController.h"

@interface WXPushGuideViewController () <UIScrollViewDelegate>

@end

@implementation WXPushGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建滑动视图
    [self createGuide];
    
    
}

- (void)createGuide {
    
    // 创建滑动视图
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, WScreen, HScreen);
    scrollView.contentSize = CGSizeMake(WScreen * 5, 0);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i < 5; i++) {
        
        // 图片
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide%d", i+1]];
        imageView.frame = CGRectMake(i * WScreen, 0, WScreen, HScreen);
        
        // 分页图片
        UIImageView *pageImageView = [[UIImageView alloc] init];
        pageImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guideProgress%d", i+1]];
        pageImageView.frame = CGRectMake(0, HScreen - 30, WScreen, 30);
        // 这个属性可以，变成原始大小
        pageImageView.contentMode = UIViewContentModeCenter;
        
        [imageView addSubview:pageImageView];
        [scrollView addSubview:imageView];
        
    }
    
    [self.view addSubview:scrollView];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView.contentOffset.x > WScreen * 4) {
     
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        WXTabBarController *tabBar = [storyBoard instantiateInitialViewController];
        
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
