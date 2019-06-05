//
//  AllLessonListCell.h
//  DiscountClass
//
//  Created by Cary on 2019/5/14.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EduModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AllEduListCell : UITableViewCell

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)UIImageView *img;
@property (nonatomic,strong)EduArrModel *model;

@end

NS_ASSUME_NONNULL_END
