//
//  UIView+MTExtension.h
//  美团
//
//  Created by lxy on 16/6/16.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MTExtension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;


@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;


- (UIViewController *)viewController;

@end
