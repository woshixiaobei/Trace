//
//  TRAMainNavViewController.m
//  TRACE
//
//  Created by Arvin on 16/6/18.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAMainNavViewController.h"
#import "MXNLoginController.h"
#import "MXNPersonalController.h"
#define MXNAlreadyLogined @"MXNAlreadyLogined"

@interface CRAMainNavViewController () <UINavigationControllerDelegate>

@end

@implementation CRAMainNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/**
 * 设置外观 
 */
+ (void)initialize {
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    [UINavigationBar appearance].translucent = NO;
    
//    [navBar setBarTintColor: [UIColor colorWithRed: 243/255.0 green: 142/255.0 blue: 49/255.0 alpha: 1]];
//    [navBar setBarTintColor:[UIColor colorWithRed:11/255.0 green:181/255.0 blue:252/255.0 alpha:1]];
    [navBar setBarTintColor:[UIColor cz_colorWithHex:0x000000]];
    navBar.alpha = 1;
    [navBar setBackgroundImage:[UIImage imageNamed:@"圆角矩形-2-拷贝-2"] forBarMetrics:UIBarMetricsDefault];
    
    //cz_colorWithRed:11/255.0 green:181/255.0 blue:252/255.0
//    [navBar setBarTintColor:[UIColor cz_colorWithHex:0X00CF69]];
    
    [navBar setTitleTextAttributes:@{
                                     NSForegroundColorAttributeName : [UIColor whiteColor],
                                     NSFontAttributeName : [UIFont systemFontOfSize:22.0]
                                     }];
    
}



#pragma mark - 只要push就会调用的方法

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //MARK: 读取沙盒
    // 1.获取偏好设置对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 2.读取数据
    BOOL Logined = [defaults boolForKey:MXNAlreadyLogined];
    
    if (Logined ) {
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"title_个人中心"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  style:UIBarButtonItemStylePlain target:self action:@selector(btnClick)];
        viewController.navigationItem.rightBarButtonItem = rightItem;
//        self.navigationBar = [[UINavigationBar alloc] backIndicatorImage];
//        
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"title_返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  style:UIBarButtonItemStylePlain target:self action:@selector(popControlor)];
////        self.navigationItem.leftBarButtonItem = leftItem;
//        
//        viewController.navigationItem.leftBarButtonItem = leftItem;
        
    } else {
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick:)];
        [rightItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18.0], NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
        
        viewController.navigationItem.rightBarButtonItem = rightItem;
        
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"title_返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  style:UIBarButtonItemStylePlain target:self action:@selector(popControlor)];
////        self.navigationItem.leftBarButtonItem = leftItem;
//        viewController.navigationItem.leftBarButtonItem = leftItem;
    }
    
    [super pushViewController:viewController animated:animated];
    
}

//- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
//    return [super popViewControllerAnimated:animated];
//}
- (void)popControlor {
    [self popViewControllerAnimated:YES];

}
- (void)btnClick {
    MXNPersonalController *personalC = [[MXNPersonalController alloc] init];
    [self pushViewController:personalC animated:YES];
}

- (void)leftBtnClick {
    [self popViewControllerAnimated:YES];
}

- (void)rightBtnClick:(UIButton *)sender {
    
    MXNLoginController *loginC = [[MXNLoginController alloc] init];
    [self pushViewController:loginC animated:YES];
}

#pragma mark - 设置界面
//- (void)setupUI {
//    
//    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
//    self.navigationBar.barTintColor = [UIColor cz_colorWithHex:0xFF0000];
//    
//    
//}

@end
