//
//  NewsVC.m
//  DiscountClass
//
//  Created by Cary on 2019/5/8.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "NewsVC.h"
#import <WebKit/WebKit.h>
#import "ThirdLibsHeader.h"

@interface NewsVC ()

@property (nonatomic,strong) WKWebView *webView;

@end

@implementation NewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"资讯文章";
    
    CGRect webViewFrame = CGRectMake(0, xTopHeight, xScreenWidth, xScreenHeight-xTopHeight);
    
    if ([UIDevice currentDevice].systemVersion.doubleValue <11.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    } 
    _webView = [[WKWebView alloc]initWithFrame:webViewFrame];
    [_webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    [self.view addSubview:_webView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
