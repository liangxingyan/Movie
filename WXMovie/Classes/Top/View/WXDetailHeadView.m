//
//  WXDetailHeadView.m
//  WXMovie
//
//  Created by mac2 on 16/7/23.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXDetailHeadView.h"
#import "WXDetailHead.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>

@interface WXDetailHeadView ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *directorLabel;

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *district;

@property (weak, nonatomic) IBOutlet UIButton *video1;

@property (weak, nonatomic) IBOutlet UIButton *video2;

@property (weak, nonatomic) IBOutlet UIButton *video3;

@property (weak, nonatomic) IBOutlet UIButton *video4;

@end

@implementation WXDetailHeadView

- (void)setHead:(WXDetailHead *)head {
    _head = head;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:head.image]];
    self.nameLabel.text = head.titleCn;
    self.directorLabel.text = [head.directors firstObject];
    self.mainLabel.text = [head.actors componentsJoinedByString:@"、"];
    self.typeLabel.text = [head.type componentsJoinedByString:@"、"];
    self.district.text = head.Toprelease[@"location"];
    self.timeLabel.text = head.Toprelease[@"date"];
    [self.video1 sd_setBackgroundImageWithURL:[NSURL URLWithString:head.videos[0][@"image"]] forState:UIControlStateNormal];
    [self.video1 addTarget:self action:@selector(video1Action) forControlEvents:UIControlEventTouchUpInside];
  
    [self.video2 sd_setBackgroundImageWithURL:[NSURL URLWithString:head.videos[1][@"image"]] forState:UIControlStateNormal];
    
    [self.video3 sd_setBackgroundImageWithURL:[NSURL URLWithString:head.videos[2][@"image"]] forState:UIControlStateNormal];
    
    [self.video4 sd_setBackgroundImageWithURL:[NSURL URLWithString:head.videos[3][@"image"]] forState:UIControlStateNormal];
    
    
}

- (void)video1Action {
    
    MPMoviePlayerViewController *mp =[[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:self.head.videos[0][@"url"]]];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:mp animated:YES completion:nil];
}


@end
