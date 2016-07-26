//
//  WXMovieCell.m
//  WXMovie
//
//  Created by mac2 on 16/7/19.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXMovieCell.h"
#import "WXMovie.h"
#import "UIImageView+WebCache.h"
#import "WXStar.h"

@interface WXMovieCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *year;

@property (weak, nonatomic) IBOutlet UILabel *grade;

@property (weak, nonatomic) IBOutlet WXStar *star;

@end

@implementation WXMovieCell

- (void)awakeFromNib {

}

- (void)setMovie:(WXMovie *)movie {
    _movie = movie;
    
    [self.image sd_setImageWithURL:movie.images[@"small"] placeholderImage:nil];
    
    self.title.text = movie.title;
    
    self.year.text = [NSString stringWithFormat:@"%ld", movie.year];
    
    self.grade.text = [NSString stringWithFormat:@"%@", movie.rating[@"average"]];
    
    self.star.rating = [movie.rating[@"average"] floatValue];
    
}

@end
