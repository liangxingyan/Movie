//
//  WXNews.h
//  WXMovie
//
//  Created by mac2 on 16/7/21.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXNews : NSObject

/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 概述 */
@property (nonatomic, copy) NSString *summary;
/** 图片 */
@property (nonatomic, copy) NSString *image;
/** 类型 */
@property (nonatomic, assign, getter=isType) BOOL type;

@end
