//
//  LessonDetailThreeCell.h
//  DiscountClass
//
//  Created by Cary on 2019/5/15.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LessonDetailThreeCell : UITableViewCell

@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,copy) NSString *htmlStr;


@end

NS_ASSUME_NONNULL_END
