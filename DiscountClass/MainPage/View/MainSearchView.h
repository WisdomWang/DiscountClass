//
//  MainSearchView.h
//  DiscountClass
//
//  Created by Cary on 2019/5/9.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LessonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainSearchView : UIView

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) NSMutableArray *arrLessonList;

@property (nonatomic,copy) void(^searchLessonBlock)(LessonArrModel *m);
@property (nonatomic,copy) void (^cancelBlock)(void);

@end

NS_ASSUME_NONNULL_END
