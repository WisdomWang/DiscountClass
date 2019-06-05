//
//  AddressListModel.m
//  DiscountClass
//
//  Created by Cary on 2019/5/16.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "AddressListModel.h"

@implementation AddressListModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        NSArray *dataArr = dic[@"data"];
        NSMutableArray *dataItems  = [NSMutableArray array];
        for (NSDictionary *dataDic in dataArr) {
            AddressListDetailModel *dataItem = [[AddressListDetailModel alloc]initWithDic:dataDic];
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

@implementation AddressListDetailModel

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
//
//    if ([key isEqualToString:@"address"]) {
//
//        self.address = value;
//    }
//    if ([key isEqualToString:@"eduId"]) {
//
//        self.eduId = value;
//    }
}

@end


