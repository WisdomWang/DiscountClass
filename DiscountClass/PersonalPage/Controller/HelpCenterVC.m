
//
//  HelpCenterVC.m
//  DiscountClass
//
//  Created by Cary on 2019/5/20.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "HelpCenterVC.h"
#import <WebKit/WebKit.h>
#import "ThirdLibsHeader.h"

@interface HelpCenterVC ()

@property (nonatomic,strong) WKWebView *webView;

@end

@implementation HelpCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"帮助中心";
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, xTopHeight, xScreenWidth, xScreenHeight-xTopHeight)];
    [_webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://weixin.huifintech.com/account.html#FAQ"]]];
    
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
