//
//  OrderListModel.h
//  DiscountClass
//
//  Created by Cary on 2019/5/22.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderListModel : NSObject

@property (nonatomic,assign) BOOL success;
@property (nonatomic,strong) NSArray *data;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

@interface OrderListOneModel : NSObject

@property (nonatomic,assign) NSInteger orderStatus;
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *courseNum;
@property (nonatomic,strong) NSArray *eduList;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

@interface OrderListTwoModel : NSObject

@property (nonatomic,strong) NSString *eduId;
@property (nonatomic,strong) NSString *eduName;
@property (nonatomic,strong) NSArray *courseList;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

@interface OrderListThreeModel : NSObject

@property (nonatomic,strong) NSString *courseName;
@property (nonatomic,strong) NSString *courseType;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *courseId;
@property (nonatomic,strong) NSString *openTime;
@property (nonatomic,strong) NSString *address;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end


NS_ASSUME_NONNULL_END
