//
//  xCommonFunction.h
//  DiscountStudy
//
//  Created by Cary on 2018/3/29.
//  Copyright © 2018年 Cary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface xCommonFunction : NSObject

//json转字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;

//md5字符串加密
+ (NSString *)md5SignWithString:(NSString *)string;

//判断是否含有非法字符 yes 有  no没有
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content;

//判断输入的字符串是否全为数字
+ (BOOL) deptNumInputShouldNumber:(NSString *)str;

//去除字符串空格
+ (NSString *)removeBlankSpace:(NSString *)string;

//去除emoji表情
+ (NSString *)disable_emoji:(NSString *)text;

//版本
+ (NSString *)getAppVersion;

//将某个时间转化成 时间戳
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

//获取当前时间戳
+(NSInteger)getNowTimeTimestamp;

//获取当前的时间
+(NSString *)getNowTime;

//手机号密文
+(NSString *)getSecretPhoneNum:(NSString *)phone;

@end
