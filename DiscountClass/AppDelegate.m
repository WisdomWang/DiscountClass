//
//  AppDelegate.m
//  DiscountClass
//
//  Created by Cary on 2019/4/30.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "AppDelegate.h"
#import "MainVC.h"
#import "FindVC.h"
#import "MyCartVC.h"
#import "PersonalVC.h"
#import "Chameleon.h"
#import "IQKeyboardManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupTabbar];
    [self setKeyboard];
    return YES;
}

- (void)setupTabbar {
    
    MainVC *vc1 = [[MainVC alloc]init];
    vc1.tabBarItem = [self tabBarItemWithName:@"首页" imageName:@"tab_main_normal" imageSelectedName:@"tab_main_selected"];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:vc1];
    
    FindVC *vc2 = [[FindVC alloc]init];
    vc2.tabBarItem = [self tabBarItemWithName:@"发现" imageName:@"tab_find_normal" imageSelectedName:@"tab_find_selected"];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:vc2];
    
    MyCartVC *vc3 = [[MyCartVC alloc]init];
    vc3.tabBarItem = [self tabBarItemWithName:@"购物车" imageName:@"tab_mycart_normal" imageSelectedName:@"tab_mycart_selected"];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:vc3];
    
    PersonalVC *vc4 = [[PersonalVC alloc]init];
    vc4.tabBarItem = [self tabBarItemWithName:@"我的" imageName:@"tab_personal_normal" imageSelectedName:@"tab_personal_selected"];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:vc4];
    
    UITabBarController *tbcMain = [[UITabBarController alloc]init];
    tbcMain.viewControllers = @[nav1,nav2,nav3,nav4];
    tbcMain.tabBar.tintColor = [UIColor colorWithHexString:@"#f44640"];
    [[UITabBar appearance] setTranslucent:NO];
    [self.window setRootViewController:tbcMain];
    
    // 修改导航按钮颜色
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    // 隐藏返回按钮的文字,只保留箭头
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]}forState:UIControlStateNormal];//将title 文字的颜色改为透明
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]}forState:UIControlStateHighlighted]; //将title 文字的颜色改为透明
    
}

- (UITabBarItem *)tabBarItemWithName:(NSString *)name imageName:(NSString *)imageName imageSelectedName:(NSString *)imageSelectedName {
    
    UITabBarItem *tabItem = [[UITabBarItem alloc]initWithTitle:name image:[UIImage imageNamed:imageName] selectedImage:[UIImage imageNamed:imageSelectedName]];
    return tabItem;
}

- (void)setKeyboard {
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = NO; // 控制键盘上的工具条文字颜色是否用户自定义
   // keyboardManager.toolbarTintColor = [UIColor colorWithHexString:@"#f44640"];
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.toolbarDoneBarButtonItemText = @"完成";
    //keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    //keyboardManager.shouldShowToolbarPlaceholder = NO; // 是否显示占位文字
    // keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    //keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
