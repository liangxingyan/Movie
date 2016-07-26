//
//  WXPosterCell.h
//  WXMovie
//
//  Created by mac2 on 16/7/20.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXMovie;

@interface WXPosterCell : UICollectionViewCell

/** 电影模型 */
@property (nonatomic, strong) WXMovie *movie;


- (void)hiddenDetail;

@end
