//
//  FindHotCell.h
//  DiscountClass
//
//  Created by Cary on 2019/5/7.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThirdLibsHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface FindHotCell : UITableViewCell

@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic,copy) void (^gotoDetailBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
