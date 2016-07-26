//
//  WXImagecCell.m
//  WXMovie
//
//  Created by mac2 on 16/7/23.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXImagecCell.h"
#import "UIImageView+WebCache.h"
#import "WXImage.h"

@interface WXImagecCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation WXImagecCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setImages:(WXImage *)images {
    _images = images;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:images.image]];
}

@end
