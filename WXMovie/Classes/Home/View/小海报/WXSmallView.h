//
//  WXSmallView.h
//  WXMovie
//
//  Created by mac2 on 16/7/26.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXSmallView : UICollectionView

/** 模型数组 */
@property (nonatomic, strong) NSArray *movies;

/** 下标实现联动 */
@property (nonatomic, assign) NSInteger index;

/** 大海报 */
@property (nonatomic, assign) NSInteger posterIndex;

@end
