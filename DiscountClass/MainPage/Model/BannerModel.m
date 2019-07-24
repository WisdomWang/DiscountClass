//
//  BannerModel.m
//  DiscountClass
//
//  Created by Cary on 2019/7/24.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel


- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        NSArray *dataArr = dic[@"data"];
        NSMutableArray *dataItems  = [NSMutableArray array];
        for (NSDictionary *dataDic in dataArr) {
            BannerDetailModel *dataItem = [[BannerDetailModel alloc]initWithDic:dataDic];
            [dataItems addObject:dataItem];
        }
        self.data = dataItems;
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end

@implementation BannerDetailModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
