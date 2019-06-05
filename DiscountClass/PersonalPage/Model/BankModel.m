//
//  BankModel.m
//  DiscountClass
//
//  Created by Cary on 2019/6/5.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "BankModel.h"

@implementation BankModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        NSDictionary *dataItems = dic[@"data"];
        self.data = dataItems;
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end

@implementation BankInfoModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
