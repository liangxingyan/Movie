//
//  WXSkinTool.m
//  WXMovie
//
//  Created by mac2 on 16/8/13.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXSkinTool.h"

@implementation WXSkinTool

static NSString * _skinColor;

+ (void)initialize {
    
    _skinColor = [[NSUserDefaults standardUserDefaults] objectForKey:@"skinColor"];
    if (_skinColor == nil) {
        _skinColor = @"white";
    }
}

+ (void)setSkinColor:(NSString *)skinColor {
    
    _skinColor = skinColor;
    
    // 保存皮肤颜色
    [[NSUserDefaults standardUserDefaults] setObject:skinColor forKey:@"skinColor"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (UIImage *)skinToolWithImageName:(NSString *)imageName {
    
    NSString *imagePath = [NSString stringWithFormat:@"skin/%@/%@", _skinColor, imageName];
    
    return [UIImage imageNamed:imagePath];
}

+ (UIColor *)skinToolWithLabelColor {
    // 获取plist的路径
    NSString *plistName = [NSString stringWithFormat:@"skin/%@/bgColor.plist", _skinColor];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:nil];
    
    // 读取颜色的点击
    NSDictionary *colorDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    // 读取对应的颜色字符串
    NSString *colorString = colorDic[@"labelBgColor"];
    NSArray *colorArray = [colorString componentsSeparatedByString:@","];
    
    // 读取对应RGB
    NSInteger red = [colorArray[0] integerValue];
    NSInteger green = [colorArray[1] integerValue];
    NSInteger blue = [colorArray[2] integerValue];
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

@end
