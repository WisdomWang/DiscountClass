//
//  OrderListOneCell.h
//  DiscountClass
//
//  Created by Cary on 2019/5/22.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderListOneCell : UITableViewCell

@property (nonatomic,strong)UILabel *orderIdLabel;
@property (nonatomic,strong)UIButton *deleteButton;
@property (nonatomic,strong)UIImageView *statusImg;
@property (nonatomic,strong)UIButton *delButton;
@property (nonatomic,strong) UILabel *eduLabel;
@property (nonatomic,strong) UILabel *kindLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIButton *payButton;

@property (nonatomic,strong) OrderListOneModel *model;

@property (nonatomic,copy) void(^deleteOrderBlock)(void);
@property (nonatomic,copy) void(^payOrderBlock)(void);




@end

NS_ASSUME_NONNULL_END
