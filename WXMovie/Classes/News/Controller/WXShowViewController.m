//
//  WXShowViewController.m
//  WXMovie
//
//  Created by mac2 on 16/7/23.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXShowViewController.h"
#import "UIImageView+WebCache.h"
#import "WXImage.h"
#import "SVProgressHUD.h"

@interface WXShowViewController () <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

/** 左边视图 */
@property(nonatomic, strong)UIImageView *leftImageView;
/** 中间视图 */
@property(nonatomic, strong)UIImageView *middleImageView;
/** 右边视图 */
@property(nonatomic, strong)UIImageView *rightImageView;

/** 当前页 */
@property(nonatomic, assign)NSInteger currentNumber;

@end

@implementation WXShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(WScreen * 3, HScreen);
    _scrollView.contentOffset = CGPointMake(WScreen, 0);
    
    
    _middleImageView = [[UIImageView alloc] init];
    
    // 图片尺寸
    CGFloat pictureW = WScreen;
    
    
    /** 
     图片宽度1280  图片高度720
     显示宽度 显示高度
     */
    
    // 图片的高度
    CGFloat pictureH = pictureW * 720 / 1280;
    
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pictureW, pictureH)];
    _middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(pictureW, 0, pictureW, pictureH)];
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(pictureW * 2 , 0, pictureW, pictureH)];
    
    _middleImageView.userInteractionEnabled = YES;
    
    _middleImageView.centerY = HScreen * 0.5;
    _leftImageView.centerY = HScreen * 0.5;
    _rightImageView.centerY = HScreen * 0.5;
    
    // 一次点按手势
    [self setUpTap];
    
    // 长按手势
    [self setUpLongPress];
    
    // 捏合手势
    [self setUpPinch];
    
    
    
    _currentNumber = self.indexPath.row;
    
    [_scrollView addSubview:_leftImageView];
    [_scrollView addSubview:_middleImageView];
    [_scrollView addSubview:_rightImageView];
    
    [self loadImage];
}


-(void)loadImage {
    
    // 还原
    self.scrollView.transform = CGAffineTransformIdentity;
    
    WXImage *image = self.images[_currentNumber];
    [_middleImageView sd_setImageWithURL:[NSURL URLWithString:image.image]];
    
    NSInteger leftIndex = (_currentNumber - 1 + self.images.count) % self.images.count;
    WXImage *image1 = self.images[leftIndex];
    
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:image1.image]];
    
    NSInteger rightIndex = (_currentNumber + 1) % self.images.count;
    WXImage *image2 = self.images[rightIndex];
    
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:image2.image]];
    
}

#pragma mark - 捏合手势
- (void)setUpPinch {
    UIPinchGestureRecognizer *pingch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pingch:)];
    pingch.delegate = self;
    [self.scrollView addGestureRecognizer:pingch];
}

- (void)pingch:(UIPinchGestureRecognizer *)pingch {
    
    self.scrollView.transform = CGAffineTransformScale(self.scrollView.transform, pingch.scale, pingch.scale);
    
    // 复位
    pingch.scale = 1;
    
}

#pragma mark - 长按手势
- (void)setUpLongPress {
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longPress.delegate = self;
    [_middleImageView addGestureRecognizer:longPress];
    
}


- (void)longPress:(UILongPressGestureRecognizer *)longPress {
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        // 弹出alert ，保存到手机
        UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"保存图片"
                                                                        message:@"是否保存"
                                                                 preferredStyle:UIAlertControllerStyleActionSheet];
                                    
        
        // 取消
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        // 保存到手机
        UIAlertAction *phone = [UIAlertAction actionWithTitle:@"保存到手机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            UIImageWriteToSavedPhotosAlbum(self.middleImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }];
        
        
        [sheet addAction:phone];
        [sheet addAction:cancel];
        
        // 显示到界面
        [self presentViewController:sheet animated:YES completion:nil];
    }
    
}

// 存储图片
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
    
}

#pragma mark - 一次点按手势
- (void)setUpTap {
    
    // 创建点按手势
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1:)];
    tap1.numberOfTapsRequired = 2;
    tap1.delegate = self;
    [_middleImageView addGestureRecognizer:tap1];

}

- (void)tap1:(UITapGestureRecognizer *)tap1 {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)cancel {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //1.判断滑动方向
    if (scrollView.contentOffset.x > scrollView.bounds.size.width) {//向左滑动
        
        _currentNumber = (_currentNumber + 1) % self.images.count;
        
    }else if(scrollView.contentOffset.x < scrollView.bounds.size.width){ //向右滑动
        _currentNumber = (_currentNumber - 1 + self.images.count) % self.images.count;
        
    }
    
    [self loadImage];
    
    scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
    
}

#pragma mark - UIGestureRecognizerDelegate代理
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return YES;
//}


@end
