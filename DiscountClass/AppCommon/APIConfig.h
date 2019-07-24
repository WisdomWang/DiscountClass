//
//  APIConfig.h
//  DiscountClass
//
//  Created by Cary on 2019/5/13.
//  Copyright © 2019 Cary. All rights reserved.
//

#ifndef APIConfig_h
#define APIConfig_h

//#define BASIC_URL @"http://192.168.1.133:8087/hxxentry_shop/"
#define BASIC_URL @"http://dev.huifintech.com/hxxentry_shop/"

#define GetAllCourse  [BASIC_URL stringByAppendingString:@"shop/course/getAllCourse"]
#define GetAllEduIcon  [BASIC_URL stringByAppendingString:@"shop/edu/getAllEduIcon"]
#define GetAllAdv  [BASIC_URL stringByAppendingString:@"shop/adv/getAllAdv"]
#define GetAllEduAddress  [BASIC_URL stringByAppendingString:@"shop/edu/getAllEduAddress"]
#define GetEduInfo  [BASIC_URL stringByAppendingString:@"shop/edu/getEduInfo"]
#define GetCourseInfo  [BASIC_URL stringByAppendingString:@"shop/course/getCourseDetail"]

#define AddCourseCart  [BASIC_URL stringByAppendingString:@"shop/cart/addCourseCart"]
#define GetCourseCart    [BASIC_URL stringByAppendingString:@"shop/cart/getCourseCart"]
#define UpdateCourseCart    [BASIC_URL stringByAppendingString:@"shop/cart/updateCourseCart"]
#define CreateCourseOrder    [BASIC_URL stringByAppendingString:@"shop/order/createCourseOrder"]
#define DelCourseOrder       [BASIC_URL stringByAppendingString:@"shop/order/delCourseOrder"]
#define GetAllCourseOrder    [BASIC_URL stringByAppendingString:@"shop/order/getAllCourseOrder"]

#define GetAllinSignInfo    [BASIC_URL stringByAppendingString:@"shop/allin/getAllinSignInfo"]
#define SignApply    [BASIC_URL stringByAppendingString:@"shop/allin/signApply"]
#define SignRequest    [BASIC_URL stringByAppendingString:@"shop/allin/sign"]
#define UnSignRequest    [BASIC_URL stringByAppendingString:@"shop/allin/unSign"]
#define PayOrder    [BASIC_URL stringByAppendingString:@"shop/order/payOrder"]

#define GetAllInformation    [BASIC_URL stringByAppendingString:@"shop/adv/getAllInformation"]
#define GetCourseDetailHtml    [BASIC_URL stringByAppendingString:@"shop/course/getCourseDetailHtml"]

#define GetWeekHotAdv    [BASIC_URL stringByAppendingString:@"shop/adv/getWeekHotAdv"]



#define GetLoginCode  @"http://testweixin.huifintech.com/hxx/user/sendCode"
#define Login         @"http://testweixin.huifintech.com/hxx/user/validateLoginCode"

//#define GetLoginCode  @"http://weixin.huifintech.com/hxx/user/sendCode"
//#define Login         @"http://weixin.huifintech.com/hxx/user/validateLoginCode"


#endif /* APIConfig_h */
