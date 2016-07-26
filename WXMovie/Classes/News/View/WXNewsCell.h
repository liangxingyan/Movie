//
//  WXNewsCell.h
//  WXMovie
//
//  Created by mac2 on 16/7/21.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXNews;

@interface WXNewsCell : UITableViewCell

/** 新闻模型 */
@property (nonatomic, strong) WXNews *news;

@end
