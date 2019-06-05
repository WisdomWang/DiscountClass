//
//  PayOrderOneCell.h
//  DiscountClass
//
//  Created by Cary on 2019/6/3.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PayOrderOneCell : UITableViewCell

@property (nonatomic,strong)UIImageView*bgView;
@property (nonatomic,strong)UIImageView *iconImage;
@property (nonatomic,strong)UILabel *label;
@property (nonatomic,strong)UILabel *detailLabel;
@property (nonatomic,strong)UIImageView *fastPayImg;

@property (nonatomic,strong)BankInfoModel *model;

@end

NS_ASSUME_NONNULL_END
