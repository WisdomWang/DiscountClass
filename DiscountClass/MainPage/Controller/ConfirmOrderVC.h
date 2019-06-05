//
//  ConfirmOrderVC.h
//  DiscountClass
//
//  Created by Cary on 2019/5/16.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LessonModel.h"
#import "AddressListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConfirmOrderVC : UIViewController

@property (nonatomic,strong) LessonArrModel *m;
@property (nonatomic,strong) AddressListDetailModel *addressModel;
@property (nonatomic,copy)NSString *orderPrice;

@end

NS_ASSUME_NONNULL_END
