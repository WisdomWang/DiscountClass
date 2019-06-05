//
//  BankListCell.h
//  DiscountClass
//
//  Created by Cary on 2019/5/29.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BankListCell : UITableViewCell

@property (nonatomic,strong)UIImageView *bgView;
@property (nonatomic,strong)UIImageView *iconImage;
@property (nonatomic,strong)UILabel *label;
@property (nonatomic,strong)UILabel *detailLabel;
@property (nonatomic,strong)UIButton *confirmButton;

@property (nonatomic,strong)BankInfoModel *model;

@property (nonatomic,copy) void(^changeBankCardBlock)(void);

@end

NS_ASSUME_NONNULL_END
