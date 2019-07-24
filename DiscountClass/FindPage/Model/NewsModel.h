//
//  NewsModel.h
//  DiscountClass
//
//  Created by Cary on 2019/7/23.
//  Copyright © 2019 Cary. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsModel : NSObject

@property (nonatomic,assign) BOOL success;
@property (nonatomic,strong) NSArray *data;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end


@interface NewsListModel : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *releaseTime;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
