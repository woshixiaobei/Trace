//
//  AppDelegate.m
//  Trace
//
//  Created by Clark on 16/6/19.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "AppDelegate.h"
#import "CRANewFeatureViewController.h"
#import "CRAMainTabBarController.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)chooseRootViewController{
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
//    NSLog(@"当前版本号%@",currentVersion);
    
    //获取存储的版本号
    //获取偏好设置
    NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
    //获取存储版本号
    NSString *saveVersion = [defaults objectForKey:@"appVersion"];
//    NSLog(@"存储版本号%@",saveVersion);
    
    if ([currentVersion isEqualToString:saveVersion]) {
        
        
        //创建控制器
        CRAMainTabBarController *mainTabBarVC = [[CRAMainTabBarController alloc]init];
        
        //设置根控制器
        self.window.rootViewController = mainTabBarVC;
        
    }else{
        CRANewFeatureViewController *featureVC = [[CRANewFeatureViewController alloc]init];
        
        self.window.rootViewController = featureVC;
        
        
        //存储当前的版本号
        [defaults setObject:currentVersion forKey:@"appVersion"];
        
        //立即存储
        [defaults synchronize];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [NSThread sleepForTimeInterval:1];
    
    // 设置网络指示器 - 非常重要的一个用户体验！
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    
    // 判断是否版本更新
    [self chooseRootViewController];
    
    [_window makeKeyAndVisible];

    
    
    return YES;
}

@end
