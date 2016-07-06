//
//  CRACommunityNavigationController.m
//  Trace
//
//  Created by 张玺科 on 16/6/22.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRACommunityNavigationController.h"
//#import "MXNLoginC.h"
#import "MXNLoginController.h"
//#import "MXNPersonalC.h"
#import "MXNPersonalController.h"
#define MXNAlreadyLogined @"MXNAlreadyLogined"

@interface CRACommunityNavigationController ()<UINavigationControllerDelegate>

@end

@implementation CRACommunityNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

+ (void)initialize {
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    [UINavigationBar appearance].translucent = NO;
    
    //    [navBar setBarTintColor: [UIColor colorWithRed: 0 green: 1 blue: 0 alpha: 1]];
    [navBar setBarTintColor:[UIColor cz_colorWithHex:0X00CF69]];
    
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
        
        
    } else {
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick:)];
        [rightItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18.0], NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
        
        viewController.navigationItem.rightBarButtonItem = rightItem;
    }
    
    [super pushViewController:viewController animated:animated];
    
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
- (void)setupUI {
    
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationBar.barTintColor = [UIColor cz_colorWithHex:0x00CF69];
    
    
}
@end
