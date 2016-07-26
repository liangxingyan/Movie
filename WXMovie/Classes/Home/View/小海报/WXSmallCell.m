//
//  WXSmallCell.m
//  WXMovie
//
//  Created by mac2 on 16/7/26.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXSmallCell.h"
#import "UIImageView+WebCache.h"
#import "WXMovie.h"

@interface WXSmallCell ()

/** 图片 */
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation WXSmallCell


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // 创建正面视图
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width*0.9, self.height*0.9)];
        
        self.imageView.center = self.contentView.center;
        
        self.backgroundColor = [UIColor greenColor];
        
        [self.contentView addSubview:self.imageView];        
    }
    
    return self;
}


- (void)setMovie:(WXMovie *)movie {
    
    _movie = movie;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:movie.images[@"large"]]];
    
}



@end
