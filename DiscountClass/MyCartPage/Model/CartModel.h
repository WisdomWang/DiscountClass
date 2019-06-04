//
//  CartModel.h
//  DiscountClass
//
//  Created by Cary on 2019/5/17.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CartModel : NSObject

@property (nonatomic,assign) BOOL success;
@property (nonatomic,strong) NSArray *data;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

@interface CartEduModel : NSObject

@property (nonatomic,copy) NSString *eduId;
@property (nonatomic,copy) NSString *eduName;
@property (nonatomic,strong) NSMutableArray *courseList;

@property (nonatomic, assign) BOOL isSelect;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end

@interface CartLessonModel : NSObject

@property (nonatomic,copy) NSString *courseName;
@property (nonatomic,copy) NSString *openTime;
@property (nonatomic,copy) NSString *courseId;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *courseType;

@property (nonatomic, assign) BOOL isSelect;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
