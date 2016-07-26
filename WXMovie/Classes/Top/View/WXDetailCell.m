//
//  WXDetailCell.m
//  WXMovie
//
//  Created by mac2 on 16/7/23.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXDetailCell.h"
#import "WXDetail.h"
#import "UIImageView+WebCache.h"

@interface WXDetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *detailImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *ratinLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@end

@implementation WXDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setDetails:(WXDetail *)details {
    _details = details;
    
    [self.detailImage sd_setImageWithURL:[NSURL URLWithString:details.userImage] placeholderImage:[UIImage imageNamed:@"msg_new"]];
    self.detailImage.layer.cornerRadius = self.detailImage.width * 0.5;
    self.detailImage.layer.masksToBounds = YES;
    self.nameLabel.text = details.nickname;
    self.ratinLabel.text = [NSString stringWithFormat:@"%.1f", details.rating];
    self.contentLabel.text = details.content;
    
}

@end
