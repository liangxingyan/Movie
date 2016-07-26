//
//  WXPosterCell.m
//  WXMovie
//
//  Created by mac2 on 16/7/20.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXPosterCell.h"
#import "WXMovie.h"
#import "UIImageView+WebCache.h"
#import "WXPosterDetail.h"

@interface WXPosterCell ()

/** 图片 */
@property (nonatomic, strong) UIImageView *imageView;

/** 反面视图 */
@property (nonatomic, strong) WXPosterDetail *detailView;

@end

@implementation WXPosterCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // 创建正面视图
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width*0.9, self.height*0.9)];

        self.imageView.center = self.contentView.center;
        
        self.backgroundColor = [UIColor greenColor];
        
        [self.contentView addSubview:self.imageView];
        
        
        // 创建反面视图
        self.detailView = [[[NSBundle mainBundle] loadNibNamed:@"WXPosterDetail" owner:self options:nil] lastObject];
        self.detailView.frame = CGRectMake(0, 0, self.width*0.9, self.height*0.9);
        self.detailView.hidden = YES;
        self.detailView.center = self.contentView.center;
        
        [self.contentView addSubview:self.detailView];
        
    }
    
    return self;
}

- (void)setMovie:(WXMovie *)movie {
    
    _movie = movie;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:movie.images[@"large"]]];
    
    self.detailView.movies = movie;
    
    self.imageView.hidden = NO;
    
    self.detailView.hidden = YES;
    
}

- (void)hiddenDetail {
    
    UIViewAnimationOptions option;
    
    if (self.detailView.hidden) {
        option = UIViewAnimationOptionTransitionFlipFromLeft;
    } else {
        option = UIViewAnimationOptionTransitionFlipFromRight;
    }
    
    [UIView transitionWithView:self duration:0.35 options:option animations:^{
        
        self.imageView.hidden = !self.imageView.hidden;
        self.detailView.hidden = !self.detailView.hidden;
        
    } completion:nil];
    
}


@end
