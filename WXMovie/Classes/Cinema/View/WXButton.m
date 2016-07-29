//
//  WXButton.m
//  WXMovie
//
//  Created by mac2 on 16/7/27.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXButton.h"

@implementation WXButton

// 这样写的好处就是以后在代码里面也好使，主要是用来创建图片在上面文字在下面的按钮！
- (void)setUp {
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    
    return self;
}

- (void)awakeFromNib {
    
    [self setUp];
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // 调整文字
    self.titleLabel.x = 10;
    self.titleLabel.y = 0;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height;
    
}

@end
