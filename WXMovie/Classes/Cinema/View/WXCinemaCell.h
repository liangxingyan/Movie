//
//  WXCinemaCell.h
//  WXMovie
//
//  Created by mac2 on 16/7/21.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXCinema;

@interface WXCinemaCell : UITableViewCell

/** 影院模型 */
@property (nonatomic, strong) WXCinema *cinema;

@end
