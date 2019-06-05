//
//  ConfirmPayVC.h
//  DiscountClass
//
//  Created by Cary on 2019/6/3.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConfirmPayVC : UIViewController

@property (nonatomic,copy)NSString *orderPrice;
@property (nonatomic,strong)NSMutableArray *orderIds;

@end

NS_ASSUME_NONNULL_END
