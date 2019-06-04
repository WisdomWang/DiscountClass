//
//  HttpRequestManager.h
//  DiscountStudy
//
//  Created by Cary on 2018/7/6.
//  Copyright © 2018年 Cary. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HttpSuccess) (NSURLSessionDataTask * _Nonnull task,id _Nullable responseObject);
typedef void(^HttpFailure) (NSURLSessionDataTask * _Nullable task,NSError *_Nonnull error);

@interface HttpRequestManager : NSObject

//get请求
+(void)getWithUrlString:(NSString *_Nullable)urlString success:(HttpSuccess _Nullable )success failure:(HttpFailure _Nullable )failure;

//post请求
+(void)postWithUrlString:(NSString *_Nullable)urlString parameters:(NSDictionary *_Nullable)parameters success:(HttpSuccess _Nullable )success failure:(HttpFailure _Nullable )failure;

@end
