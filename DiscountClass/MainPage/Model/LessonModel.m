//
//  LessonModel.m
//  DiscountClass
//
//  Created by Cary on 2019/5/13.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "LessonModel.h"

@implementation LessonModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        NSArray *dataArr = dic[@"data"];
        NSMutableArray *dataItems  = [NSMutableArray array];
        for (NSDictionary *dataDic in dataArr) {
            LessonArrModel *dataItem = [[LessonArrModel alloc]initWithDic:dataDic];
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

@implementation LessonArrModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
//    if ([key isEqualToString:@"courseName"]) {
//
//        self.courseName = value;
//    }
//    if ([key isEqualToString:@"courseAttribute"]) {
//
//        self.courseAttribute = value;
//    }
//    if ([key isEqualToString:@"openTime"]) {
//
//        self.openTime = value;
//    }
//    if ([key isEqualToString:@"topPrice"]) {
//
//        self.topPrice = value;
//    }
//    if ([key isEqualToString:@"courseId"]) {
//
//        self.courseId = value;
//    }
//    if ([key isEqualToString:@"eduId"]) {
//
//        self.eduId = value;
//    }
//    if ([key isEqualToString:@"totalClass"]) {
//
//        self.totalClass = value;
//    }
//    if ([key isEqualToString:@"price"]) {
//
//        self.price = value;
//    }
//    if ([key isEqualToString:@"address"]) {
//
//        self.address = value;
//    }
//    if ([key isEqualToString:@"floorPrice"]) {
//
//        self.floorPrice = value;
//    }
//    if ([key isEqualToString:@"courseType"]) {
//
//        self.courseType = value;
//    }
//    if ([key isEqualToString:@"eduName"]) {
//
//        self.eduName = value;
//    }
    
}

@end
