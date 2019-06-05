//
//  CartBottomView.h
//  DiscountClass
//
//  Created by Cary on 2019/5/6.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CartBottomView : UIView

@property (nonatomic,strong) UIButton  *selectedButton;
@property (nonatomic,strong) UILabel *allPriceLabel;

@property (nonatomic,copy) void (^AllClickRowBlock)(BOOL isClick);
@property (nonatomic,copy) void (^PayBlock)(void);

@property (nonatomic, assign) BOOL isClick;

@end

NS_ASSUME_NONNULL_END
