//
//  WXTop520.h
//  WXMovie
//
//  Created by mac2 on 16/7/20.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXTop520 : NSObject

/** 评分 */
@property (nonatomic, strong) NSDictionary *rating;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 图片 */
@property (nonatomic, strong) NSDictionary *images;


@end
