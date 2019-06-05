//
//  BankModel.h
//  DiscountClass
//
//  Created by Cary on 2019/6/5.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BankModel : NSObject

@property (nonatomic,assign) BOOL success;
@property (nonatomic,strong) NSDictionary *data;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

@interface BankInfoModel : NSObject

@property (nonatomic,strong) NSString *accountNo;
@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) NSString *agrmno;
@property (nonatomic,strong) NSString *tel;
@property (nonatomic,strong) NSString *accountName;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
