//
//  EduModel.h
//  DiscountClass
//
//  Created by Cary on 2019/5/13.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EduModel : NSObject

@property (nonatomic,assign) BOOL success;
@property (nonatomic,strong) NSArray *data;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

@interface EduArrModel : NSObject

@property (nonatomic,copy) NSString *eduId;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *eduName;
@property (nonatomic,strong) NSMutableArray *labelList;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
