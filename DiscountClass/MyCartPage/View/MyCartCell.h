//
//  MyCartCell.h
//  DiscountClass
//
//  Created by Cary on 2019/5/6.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyCartCell : UITableViewCell

@property (nonatomic,strong) UILabel *kindLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIButton *selectedButton;
@property (nonatomic,strong) UIButton *addButton;
@property (nonatomic,strong) UIButton *reduceButton;
@property (nonatomic,strong) UILabel *numLabel;

@property (nonatomic,copy) void (^ClickRowBlock)(BOOL isClick);
@property (nonatomic,copy) void (^AddBlock)(UILabel *numLabel);
@property (nonatomic,copy) void (^CutBlock)(UILabel *numLabel);

@property (nonatomic,strong) CartLessonModel *lessonModel;

@end

NS_ASSUME_NONNULL_END
