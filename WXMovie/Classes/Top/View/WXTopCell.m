//
//  WXTopCell.m
//  WXMovie
//
//  Created by mac2 on 16/7/21.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXTopCell.h"
#import "UIImageView+WebCache.h"
#import "WXTop520.h"
#import "WXStar.h"

@interface WXTopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *topImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;

@property (weak, nonatomic) IBOutlet WXStar *starView;
@end

@implementation WXTopCell

- (void)awakeFromNib {
    

}

- (void)setTops:(WXTop520 *)tops {
    _tops = tops;
    
    [self.topImage sd_setImageWithURL:[NSURL URLWithString:tops.images[@"medium"]]];
    self.titleLabel.text = tops.title;
    self.gradeLabel.text = [NSString stringWithFormat:@"%.1f", [tops.rating[@"average"] floatValue]];
    self.starView.rating = [tops.rating[@"average"] floatValue];
    
}

@end
