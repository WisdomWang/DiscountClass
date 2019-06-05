//
//  LessonModel.h
//  DiscountClass
//
//  Created by Cary on 2019/5/13.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LessonModel : NSObject

@property (nonatomic,assign) BOOL success;
@property (nonatomic,strong) NSArray *data;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

@interface LessonArrModel : NSObject

@property (nonatomic,copy) NSString *courseName;
@property (nonatomic,copy) NSString *courseAttribute;
@property (nonatomic,copy) NSString *openTime;
@property (nonatomic,copy) NSString *topPrice;
@property (nonatomic,copy) NSString *popularityNum;
@property (nonatomic,copy) NSString *courseId;
@property (nonatomic,copy) NSString *eduId;
@property (nonatomic,copy) NSString *totalClass;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *floorPrice;
@property (nonatomic,copy) NSString *courseType;
@property (nonatomic,copy) NSString *eduName;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
