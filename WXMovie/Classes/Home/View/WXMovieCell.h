//
//  WXMovieCell.h
//  WXMovie
//
//  Created by mac2 on 16/7/19.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXMovie;

@interface WXMovieCell : UITableViewCell

/** 电影模型 */
@property (nonatomic, strong) WXMovie *movie;

@end
