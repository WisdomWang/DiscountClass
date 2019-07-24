//
//  findListCell.h
//  DiscountClass
//
//  Created by Cary on 2019/5/7.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface findListCell : UITableViewCell

@property (nonatomic,strong) UIImageView *picImg;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) NewsListModel *model;

@end

NS_ASSUME_NONNULL_END
