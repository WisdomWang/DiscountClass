//
//  PayOrderVC.h
//  DiscountClass
//
//  Created by Cary on 2019/5/16.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum {
    
    FromNewBind,
    FromOldBind
    
} BindBankFromPageType;

@interface PayOrderVC : UIViewController

@property (nonatomic,copy)NSString *orderPrice;
@property (nonatomic,strong)NSMutableArray *orderIds;

@property (nonatomic,assign) BindBankFromPageType  theType;

@end

NS_ASSUME_NONNULL_END
