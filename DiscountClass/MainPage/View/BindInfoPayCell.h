//
//  BindInfoPayCell.h
//  DiscountClass
//
//  Created by Cary on 2019/5/17.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BindInfoPayCell : UITableViewCell

@property (nonatomic,strong)UILabel *label;
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UIButton *sendCodeButton;
@property (nonatomic,copy) void(^sendCodeBlock)(UIButton *button);

@end

NS_ASSUME_NONNULL_END
