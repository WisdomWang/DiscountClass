//
//  HttpRequestManager.m
//  DiscountStudy
//
//  Created by Cary on 2018/7/6.
//  Copyright © 2018年 Cary. All rights reserved.
//

#import "HttpRequestManager.h"
#import "AFNetworking.h"
#import "TipsView.h"

@implementation HttpRequestManager

+(AFHTTPSessionManager *)shareMananger {
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil];
    });
    return manager;
}

//GET请求
+(void)getWithUrlString:(NSString *)urlString success:(HttpSuccess)success failure:(HttpFailure)failure{
    
    [[HttpRequestManager shareMananger] GET:urlString parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

//POST请求
+(void)postWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(HttpSuccess)success failure:(HttpFailure)failure{

    [[HttpRequestManager shareMananger] POST:urlString parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

@end
