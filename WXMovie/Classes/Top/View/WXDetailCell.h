//
//  WXDetailCell.h
//  WXMovie
//
//  Created by mac2 on 16/7/23.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXDetail;

@interface WXDetailCell : UITableViewCell

/** 详情模型 */
@property (nonatomic, strong) WXDetail *details;

@end
