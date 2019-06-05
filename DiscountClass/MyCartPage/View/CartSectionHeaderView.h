//
//  CartSectionHeaderView.h
//  DiscountClass
//
//  Created by Cary on 2019/5/17.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CartSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic,strong) UIButton  *selectedButton;
@property (nonatomic,strong) UILabel * headerLabel;

@property (nonatomic,strong)CartEduModel *eduModel;

@property (nonatomic,copy) void (^AllClickRowBlock)(BOOL isClick);

@property (nonatomic,assign) BOOL isClick;

@end

NS_ASSUME_NONNULL_END
