//
//  CartModel.m
//  DiscountClass
//
//  Created by Cary on 2019/5/17.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "CartModel.h"

@implementation CartModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        NSArray *dataArr = dic[@"data"];
        NSMutableArray *dataItems  = [NSMutableArray array];
        for (NSDictionary *dataDic in dataArr) {
            CartEduModel *dataItem = [[CartEduModel alloc]initWithDic:dataDic];
            [dataItems addObject:dataItem];
        }
        self.data = dataItems;
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end

@implementation CartEduModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        NSArray *dataArr = dic[@"courseList"];
        NSMutableArray *dataItems  = [NSMutableArray array];
        for (NSDictionary *dataDic in dataArr) {
            CartLessonModel *dataItem = [[CartLessonModel alloc]initWithDic:dataDic];
            [dataItems addObject:dataItem];
        }
        self.courseList = dataItems;
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end

@implementation CartLessonModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

@end

