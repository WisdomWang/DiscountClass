//
//  OrderListModel.m
//  DiscountClass
//
//  Created by Cary on 2019/5/22.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "OrderListModel.h"

@implementation OrderListModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        NSArray *dataArr = dic[@"data"];
        NSMutableArray *dataItems  = [NSMutableArray array];
        for (NSDictionary *dataDic in dataArr) {
            OrderListOneModel *dataItem = [[OrderListOneModel alloc]initWithDic:dataDic];
            [dataItems addObject:dataItem];
        }
        self.data = dataItems;
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


@end

@implementation OrderListOneModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        NSArray *dataArr = dic[@"eduList"];
        NSMutableArray *dataItems  = [NSMutableArray array];
        for (NSDictionary *dataDic in dataArr) {
            OrderListTwoModel *dataItem = [[OrderListTwoModel alloc]initWithDic:dataDic];
            [dataItems addObject:dataItem];
        }
        self.eduList = dataItems;
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end

@implementation OrderListTwoModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        NSArray *dataArr = dic[@"courseList"];
        NSMutableArray *dataItems  = [NSMutableArray array];
        for (NSDictionary *dataDic in dataArr) {
            OrderListThreeModel *dataItem = [[OrderListThreeModel alloc]initWithDic:dataDic];
            [dataItems addObject:dataItem];
        }
        self.courseList = dataItems;
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end


@implementation OrderListThreeModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

@end
