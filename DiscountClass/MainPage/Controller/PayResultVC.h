//
//  PayResultVC.h
//  DiscountClass
//
//  Created by Cary on 2019/5/20.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PayResultVC : UIViewController

@property (nonatomic,copy)NSString *msg;
@property (nonatomic,assign) BOOL payResult;
@property (nonatomic,copy)NSString *bankNo;

@end

NS_ASSUME_NONNULL_END
