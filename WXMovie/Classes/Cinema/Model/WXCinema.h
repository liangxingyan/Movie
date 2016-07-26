//
//  WXCinema.h
//  WXMovie
//
//  Created by mac2 on 16/7/21.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXCinema : NSObject

/** 价格 */
@property (nonatomic, copy) NSString *lowPrice;
/** 评分 */
@property (nonatomic, copy) NSString *grade;
/** 地址 */
@property (nonatomic, copy) NSString *address;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** id */
@property (nonatomic, assign) NSInteger districtId;

@end
