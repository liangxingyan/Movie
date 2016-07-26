//
//  WXNewsCell.m
//  WXMovie
//
//  Created by mac2 on 16/7/21.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXNewsCell.h"
#import "UIImageView+WebCache.h"
#import "WXNews.h"

@interface WXNewsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *newsImage;

@property (weak, nonatomic) IBOutlet UIImageView *typeImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;

@end

@implementation WXNewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setNews:(WXNews *)news {
    _news = news;
    
    [self.newsImage sd_setImageWithURL:[NSURL URLWithString:news.image]];
    self.titleLabel.text = news.title;
    self.summaryLabel.text = news.summary;
    if (news.type) {
        self.typeImage.image = [UIImage imageNamed:@"sctpxw"];
    } 
}

@end
