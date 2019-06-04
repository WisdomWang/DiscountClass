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




#endif /* Header_h */
