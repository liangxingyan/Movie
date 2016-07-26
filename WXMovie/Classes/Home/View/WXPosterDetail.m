//
//  WXPosterDetail.m
//  WXMovie
//
//  Created by mac2 on 16/7/25.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXPosterDetail.h"
#import "WXStar.h"
#import "UIImageView+WebCache.h"
#import "WXMovie.h"
#import "WXPosterCell.h"

@interface WXPosterDetail ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *enlishTitle;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *grade;

@property (weak, nonatomic) IBOutlet WXStar *star;


@end

@implementation WXPosterDetail

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}

- (void)setMovies:(WXMovie *)movies {
    
    _movies = movies;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:movies.images[@"medium"]]];
    self.enlishTitle.text = movies.original_title;
    self.title.text = movies.title;
    self.grade.text = [NSString stringWithFormat:@"%@", movies.rating[@"average"]];
    self.time.text = [NSString stringWithFormat:@"%ld", movies.year];
    self.star.rating = [movies.rating[@"average"] floatValue];
    
}

@end
