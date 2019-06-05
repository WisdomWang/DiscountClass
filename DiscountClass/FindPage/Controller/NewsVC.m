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
    
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, xTopHeight, xScreenWidth, xScreenHeight-xTopHeight)];
  //  [_webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://mp.weixin.qq.com/mp/homepage?__biz=MzU5NjEwNzYwOA==&hid=2&sn=8aa7f59c4ba2c0fb4e74bbedba996506&scene=18#wechat_redirect"]]];
    
   // [_webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://mp.sohu.com/profile?xpt=cHBhZzIxMjk3NjA1Y2ZiMkBzb2h1LmNvbQ==&_f=index_pagemp_1&spm=smpc.content.author.1.1559116747497NyUp1ml"]]];
    
    [_webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.jianshu.com/u/61a385078fba"]]];
    
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
