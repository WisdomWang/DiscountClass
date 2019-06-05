//
//  EduModel.m
//  DiscountClass
//
//  Created by Cary on 2019/5/13.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "EduModel.h"

@implementation EduModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        NSArray *dataArr = dic[@"data"];
        NSMutableArray *dataItems  = [NSMutableArray array];
        for (NSDictionary *dataDic in dataArr) {
            EduArrModel *dataItem = [[EduArrModel alloc]initWithDic:dataDic];
            [dataItems addObject:dataItem];
        }
        self.data = dataItems;
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
//    if ([key isEqualToString:@"success"]) {
//        
//        self.success = value;
//    }
    
}


@end

@implementation EduArrModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
//    if ([key isEqualToString:@"eduId"]) {
//
//        self.eduId = value;
//    }
//    if ([key isEqualToString:@"icon"]) {
//
//        self.icon = value;
//    }
//    if ([key isEqualToString:@"address"]) {
//
//        self.address = value;
//    }
//    if ([key isEqualToString:@"eduName"]) {
//
//        self.eduName = value;
//    }
//    if ([key isEqualToString:@"labelList"]) {
//
//        self.labelList = value;
//    }
}

@end
