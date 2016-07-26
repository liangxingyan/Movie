//
//  WXWebViewController.m
//  WXMovie
//
//  Created by mac2 on 16/7/23.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "WXWebViewController.h"
//#import "WXWeb.h"

@interface WXWebViewController ()

/** web */
//@property (nonatomic, strong) WXWeb *web;

@end

@implementation WXWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 创建webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = CGRectMake(0, 0, WScreen, HScreen);
    
    // 加载数据
    // 路径
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"news_detail" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path1];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSString *title = dict[@"title"];
    NSString *content = dict[@"content"];
    NSString *time = dict[@"time"];
    NSString *source = dict[@"source"];
    
    // 加载到webView上
    // 1.路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"news" ofType:@"html"];
    
    // 根据路径取得文件内容
    NSString *content1 = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    // 拼接字符串
    NSString *htmlStr = [NSString stringWithFormat:content1, title, content, time, source];
    
    // 加载网页
    [webView loadHTMLString:htmlStr baseURL:nil];
    
    // 自适应屏幕
    [webView scalesPageToFit];
    
    [self.view addSubview:webView];
}

#pragma mark - web请求
- (void)webRequest {
    
    // 创建webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = CGRectMake(0, 0, WScreen, HScreen);
    
    // 创建请求
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    
    // 加载请求
    [webView loadRequest:request];
    
    // 自适应屏幕
    [webView scalesPageToFit];
    
    [self.view addSubview:webView];
}

@end
