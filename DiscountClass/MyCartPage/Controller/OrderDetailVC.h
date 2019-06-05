//
//  OrderDetailVC.h
//  DiscountClass
//
//  Created by Cary on 2019/5/8.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailVC : UIViewController

@property (nonatomic,strong) NSMutableArray *selectedArr;
@property (nonatomic,copy) NSString *orderPrice;

@end

NS_ASSUME_NONNULL_END
