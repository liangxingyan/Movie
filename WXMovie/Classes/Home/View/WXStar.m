//
//  WXStar.m
//  WXMovie
//
//  Created by mac2 on 16/7/19.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXStar.h"

@interface WXStar ()

/** 灰色视图 */
@property (nonatomic, weak) UIView *grayView;
/** 黄色视图 */
@property (nonatomic, weak) UIView *yellowView;

@end

@implementation WXStar

- (void)awakeFromNib {
    
    // 创建星星
    [self createStar];
    
}

- (void)createStar {
    
    // 灰色图片
    UIImage *grayImage = [UIImage imageNamed:@"gray"];
    // 黄色图片
    UIImage *yellowImage = [UIImage imageNamed:@"yellow"];
    
    // 创建灰色视图
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, grayImage.size.width * 5, grayImage.size.height)];
  
    grayView.backgroundColor = [UIColor colorWithPatternImage:grayImage];
    self.grayView = grayView;
    
    
    // 创建黄色视图
    UIView *yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, yellowImage.size.width * 5, yellowImage.size.height)];
    yellowView.backgroundColor = [UIColor colorWithPatternImage:yellowImage];
    self.yellowView = yellowView;
    
    [self addSubview:grayView];
    [self addSubview:yellowView];
    
    // 缩放比例
    float scale = self.frame.size.height / yellowImage.size.height;
    grayView.transform = CGAffineTransformMakeScale(scale, scale);
    yellowView.transform = CGAffineTransformMakeScale(scale, scale);
    
    // 坐标归零
    grayView.origin = CGPointZero;
    yellowView.origin = CGPointZero;
    
}

- (void)setRating:(float)rating {
    _rating = rating;
    
    self.yellowView.width = self.frame.size.width * (rating / 10);

}

@end
