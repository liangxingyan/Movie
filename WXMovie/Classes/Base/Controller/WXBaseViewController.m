//
//  WXBaseViewController.m
//  WXMovie
//
//  Created by mac2 on 16/7/19.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXBaseViewController.h"

@interface WXBaseViewController ()

@end

@implementation WXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WScreen, HScreen)];
    imageView.image = [UIImage imageNamed:@"bg_main"];
    
    [self.view addSubview:imageView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
