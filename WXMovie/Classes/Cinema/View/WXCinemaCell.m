//
//  WXCinemaCell.m
//  WXMovie
//
//  Created by mac2 on 16/7/21.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXCinemaCell.h"
#import "WXCinema.h"

@interface WXCinemaCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UILabel *gredeLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation WXCinemaCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCinema:(WXCinema *)cinema {
    _cinema = cinema;
    
    self.nameLabel.text = cinema.name;
    self.address.text = cinema.address;
    if (cinema.lowPrice == NULL) {
        self.priceLabel.text = @"暂停服务";
    } else {
        self.priceLabel.text = [NSString stringWithFormat:@"¥%@", cinema.lowPrice];
    }
    self.gredeLabel.text = cinema.grade;
}

@end
