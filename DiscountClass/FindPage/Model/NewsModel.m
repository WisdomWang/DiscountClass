//
//  NewsModel.m
//  DiscountClass
//
//  Created by Cary on 2019/7/23.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        NSArray *dataArr = dic[@"data"];
        NSMutableArray *dataItems  = [NSMutableArray array];
        for (NSDictionary *dataDic in dataArr) {
            NewsListModel *dataItem = [[NewsListModel alloc]initWithDic:dataDic];
            [dataItems addObject:dataItem];
        }
        self.data = dataItems;
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end

@implementation NewsListModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end


