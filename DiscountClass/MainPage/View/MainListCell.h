//
//  MainListCell.h
//  DiscountClass
//
//  Created by Cary on 2019/5/5.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LessonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainListCell : UITableViewCell

@property (nonatomic,strong) UILabel *kindLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) LessonArrModel *model;

@end

NS_ASSUME_NONNULL_END
