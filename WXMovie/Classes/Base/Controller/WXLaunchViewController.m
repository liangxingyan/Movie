//
//  WXLaunchViewController.m
//  WXMovie
//
//  Created by mac2 on 16/7/29.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXLaunchViewController.h"
#import "WXTabBarController.h"

@interface WXLaunchViewController ()

/** 图片数组 */
@property (nonatomic, strong) NSMutableArray *imageArray;

/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation WXLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建图片
    [self createImageView];
    
    // 开启定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(showImage) userInfo:nil repeats:YES];
}

int cout = 0;

- (void)showImage {
    
    if (cout == 24) {
        
        [self.timer invalidate];
        self.timer = nil;
        
        // 切换控制器
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        WXTabBarController *tabBarVc = [storyBoard instantiateInitialViewController];
        
        self.view.window.rootViewController = tabBarVc;
        
    } else {
        
        UIImageView *imageView = self.imageArray[cout];
        imageView.alpha = 1;
    }
    
    cout ++;
}

- (void)createImageView {
    
    CGFloat width = WScreen / 4;
    CGFloat height = HScreen / 6;
    CGFloat x = 0;
    CGFloat y = 0;
    
    self.imageArray = [NSMutableArray array];
    
    for (int i = 0; i < 24; i++) {
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", i+1]];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        imageView.alpha = 0;
        
        imageView.frame = CGRectMake(0, 0, width, height);
        
        if (i < 4) {
            x = i * width;
            y = 0;
        } else if (i < 8) {
            x = 3 * width;
            y = height * (i-3);
        } else if (i < 12) {
            x = WScreen - width * (i-7);
            y = HScreen - height;
        } else if (i < 16) {
            x = 0;
            y = HScreen - height * (i-10);
        } else if (i < 18) {
            x = width * (i-15);
            y = height;
        } else if (i < 20) {
            x = width * 2;
            y = height * (i-16);
        } else if (i < 22) {
            x = WScreen - width * (i-18);
            y = HScreen - height * 2;
        } else if (i < 24) {
            x = width;
            y = HScreen - height * (i-19);
        }
        
        imageView.origin = CGPointMake(x, y);
        [self.imageArray addObject:imageView];
        [self.view addSubview:imageView];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
