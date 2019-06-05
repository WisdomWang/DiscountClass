//
//  LessonDetailBottomView.h
//  DiscountClass
//
//  Created by Cary on 2019/5/15.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LessonDetailBottomView : UIView

@property (nonatomic,copy) void (^confirmBlock)(void);
@property (nonatomic,copy) void (^linkEduBlock)(void);
@property (nonatomic,copy) void (^linkCartBlock)(void);
@property (nonatomic,copy) void (^addCartBlock)(void);

@end

NS_ASSUME_NONNULL_END
