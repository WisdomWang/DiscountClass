//
//  Header.h
//  DiscountClass
//
//  Created by Cary on 2019/4/30.
//  Copyright © 2019 Cary. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define xScreenWidth        ([UIScreen mainScreen].bounds.size.width)
#define xScreenHeight       ([UIScreen mainScreen].bounds.size.height)

#define xStatusBarHeight    ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define xNavBarHeight       44.0f
#define xTopHeight          (xStatusBarHeight + xNavBarHeight)
#define xTabBarHeight       ([[UIApplication sharedApplication] statusBarFrame].size.height > 20.0f ? 83.0f : 49.0f)


#define  xTabbarSafeBottomMargin        (xiPhoneXAll ? 34.f : 0.f)

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXS_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define xiPhoneXAll (iPhoneX || iPhoneXR || iPhoneXS_Max)


#define xNullString(string) ((![string isKindOfClass:[NSString class]]) || [string isEqualToString:@""] || (string == nil) || [string isEqualToString:@""] || [string isKindOfClass:[NSNull class]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)

#define PhoneNum  @"phoneNum"
#define UserId    @"userId"


#define TestUserId  @"62d0b1b3d9ef4112868d2cd4e7406517"
#define HotCourseId  @"1cba4507fwg5506e211ac079ed"


#endif /* Header_h */
