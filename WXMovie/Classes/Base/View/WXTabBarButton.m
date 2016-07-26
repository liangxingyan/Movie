//
//  WXTabBarButton.m
//  WXMovie
//
//  Created by mac2 on 16/7/18.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXTabBarButton.h"

@implementation WXTabBarButton

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withImage:(NSString *)image {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // 1.创建image
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 20) / 2, 5, 20, 20)];
        imageView.image = [UIImage imageNamed:image];
        // 图片填充类型
        imageView.contentMode = UIViewContentModeScaleAspectFit;

        // 2.创建label
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 20)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.text = title;
        titleLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:imageView];
        [self addSubview:titleLabel];
    }
    
    return self;
}

@end
