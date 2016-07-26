//
//  WXDistrict.h
//  WXMovie
//
//  Created by mac2 on 16/7/21.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXDistrict : NSObject

/** 地区名 */
@property (nonatomic, strong) NSString *name;

/** ID */
@property (nonatomic, assign) NSInteger ID;

/** cinema数组 */
@property (nonatomic, strong) NSMutableArray *cinema;

@end
