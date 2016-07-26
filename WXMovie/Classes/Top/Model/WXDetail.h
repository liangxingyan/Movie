//
//  WXDetail.h
//  WXMovie
//
//  Created by mac2 on 16/7/23.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXDetail : NSObject

/** 图片 */
@property (nonatomic, copy) NSString *userImage;
/** 用户名 */
@property (nonatomic, copy) NSString *nickname;
/** 评分 */
@property (nonatomic, assign) float rating;
/** 内容 */
@property (nonatomic, copy) NSString *content;

@end
