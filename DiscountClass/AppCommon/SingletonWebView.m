//
//  SingletonWebView.m
//  DiscountClass
//
//  Created by Cary on 2019/7/25.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "SingletonWebView.h"


@implementation SingletonWebView

+ (UIWebView *)shareManager {
    
    static UIWebView *webView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        webView = [[UIWebView alloc]init];
    });
    return webView;
}

@end
