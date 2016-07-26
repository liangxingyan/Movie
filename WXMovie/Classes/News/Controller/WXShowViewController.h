//
//  WXShowViewController.h
//  WXMovie
//
//  Created by mac2 on 16/7/23.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXImage.h"

@interface WXShowViewController : UIViewController

/** image模型 */
@property (nonatomic, strong) NSArray *images;

/** 下标值 */
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
