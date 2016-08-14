//
//  WXSkinTool.h
//  WXMovie
//
//  Created by mac2 on 16/8/13.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXSkinTool : NSObject

+ (UIImage *)skinToolWithImageName:(NSString *)imageName;

+ (void)setSkinColor:(NSString *)skinColor;

+ (UIColor *)skinToolWithLabelColor;

@end
