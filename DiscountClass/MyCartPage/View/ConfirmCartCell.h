//
//  ConfirmCartCell.h
//  DiscountClass
//
//  Created by Cary on 2019/5/20.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConfirmCartCell : UITableViewCell

@property (nonatomic,strong) UILabel *kindLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *addressLabel;

@property (nonatomic,strong) CartLessonModel *model;

@end

NS_ASSUME_NONNULL_END
