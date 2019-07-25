//
//  SingletonWebView.h
//  DiscountClass
//
//  Created by Cary on 2019/7/25.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingletonWebView : NSObject

+ (UIWebView *)shareManager;

@end

NS_ASSUME_NONNULL_END
