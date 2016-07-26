//
//  WXDetailHead.h
//  WXMovie
//
//  Created by mac2 on 16/7/23.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXDetailHead : NSObject

/** 图片 */
@property (nonatomic, copy) NSString *image;
/** 标题 */
@property (nonatomic, copy) NSString *titleCn;
/** 导演 */
@property (nonatomic, strong) NSArray *directors;
/** 主演 */
@property (nonatomic, strong) NSArray *actors;
/** 类型 */
@property (nonatomic, strong) NSArray *type;
/** 发布 */
@property (nonatomic, strong) NSDictionary *Toprelease;
/** MP4地址 */
@property (nonatomic, strong) NSArray *videos;



@end
