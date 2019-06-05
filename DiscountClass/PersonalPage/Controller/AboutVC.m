

//
//  AboutVC.m
//  DiscountClass
//
//  Created by Cary on 2019/5/20.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "AboutVC.h"
#import <WebKit/WebKit.h>
#import "ThirdLibsHeader.h"


@interface AboutVC ()

@property (nonatomic,strong) WKWebView *webView;

@end

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"关于惠学习";
    
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, xTopHeight, xScreenWidth, xScreenHeight-xTopHeight)];
    [_webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.huifintech.com/aboutus.html"]]];
    
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
