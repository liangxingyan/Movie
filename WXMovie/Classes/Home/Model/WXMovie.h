//
//  WXMovie.h
//  WXMovie
//
//  Created by mac2 on 16/7/19.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXMovie : NSObject

/** 评分 */
@property (nonatomic, strong) NSDictionary *rating;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 收藏数 */
@property (nonatomic, assign) NSInteger collect_count;
/** 图片 */
@property (nonatomic, strong) NSDictionary *images;
/** 年份 */
@property (nonatomic, assign) NSInteger year;
/** 英文名 */
@property (nonatomic, copy) NSString *original_title;

@end
