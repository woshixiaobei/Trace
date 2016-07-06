//
//  TRAMainTabBarController.m
//  TRACE
//
//  Created by Arvin on 16/6/18.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAMainTabBarController.h"
#import "CRAMainNavViewController.h"
#import "UIImage+DXImage.h"
#import "CRATabBar.h"
#import "CRAMoreViewController.h"
#import "CRACircleViewController.h"

#import "CRADetailViewController.h"


#import "MXNPersonalController.h"
#import "MXNLoginController.h"


#import "RZPopupMenuView.h"
#import "UIView+AdjustFrame.h"
#import "CRACommunityViewController.h"
#import "CHLifeToolsViewController.h"

#define RZWindow [UIApplication sharedApplication].keyWindow


@interface CRAMainTabBarController ()<RZPopupMenuViewDelegate>

@end

@implementation CRAMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 创建4个子控制器
    [self addChildViewControllers];
    
    // 自定义tabBar
    CRATabBar *tabBar = [[CRATabBar alloc] initWithFrame:self.tabBar.frame];
    
    // 利用KVC把readonly权限改过来
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
   // self.selectedIndex = 0;
    self.selectedViewController = [self.viewControllers objectAtIndex:0];
    
    tabBar.tabBarBlock = ^(){
        
        
        [RZPopupMenuView showWithDelegate:self];
        
        
    };
    // 接受通知  修改右侧的按钮  为未登录状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOut) name:@"exitLogin" object:nil];
    
    // 接受通知修改右侧按钮为登录状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rightLogin) name:@"alreadlyLogin" object:nil];

}

#pragma mark - 登录后修改右侧按钮为已登录状态
- (void)rightLogin {
    
    [self.viewControllers enumerateObjectsUsingBlock:^(CRAMainNavViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"title_个人中心"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  style:UIBarButtonItemStylePlain target:self action:@selector(btnClick)];
        
        [obj.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.navigationItem.rightBarButtonItem = rightItem;
        }];
        
    }];
}

- (void)btnClick {
    
    MXNPersonalController *personalC = [[MXNPersonalController alloc] init];
    [self.selectedViewController pushViewController:personalC animated:YES];
}

#pragma mark -  退出修改右侧按钮
- (void)loginOut {
    
    
    // 回到登录界面 ???
    //    [self rightBtnClick:nil];
    // 进入主程序   ???
    //    [UIApplication sharedApplication].keyWindow.rootViewController = [[MXNTabBarC alloc] init];
    
    [self.viewControllers enumerateObjectsUsingBlock:^(CRAMainNavViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick:)];
        [rightItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18.0], NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
        
        [obj.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.navigationItem.rightBarButtonItem = rightItem;
        }];
        
    }];
    
}

- (void)rightBtnClick:(UIButton *)sender {
    
    MXNLoginController *loginC = [[MXNLoginController alloc] init];
    [self.selectedViewController pushViewController:loginC animated:YES];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)popupMenuView:(RZPopupMenuView *)view selectedIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            CHLifeToolsViewController *lifVC = [[CHLifeToolsViewController alloc]init];
            
            
            UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:lifVC];
            
            
            [self presentViewController:nav1 animated:YES completion:nil];
            break;
        }
            
        case 1:
        {
            CRACommunityViewController *comVC = [[CRACommunityViewController alloc]init];
            
            
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:comVC];
            
            
            [self presentViewController:nav animated:YES completion:nil];
            
            
            break;
        }
            
        case 2:
            
            NSLog(@"第三个");
         
            break;
            
        case 3:
            
            NSLog(@"第四个");
            
            break;
            
        default:
            break;
    }
}
/**
 * 添加所有的子控制器
 */
- (void)addChildViewControllers {
    
    // 001 设置 tabBar 的字体颜色
    self.tabBar.tintColor = [UIColor cz_colorWithHex:0x00CF69];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bg-addbutton"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    
    //    self.tabBar
    NSArray *array = @[
                       @{@"clsName": @"CRAHomeViewController", @"title": @"首页", @"imageName": @"tabbar1"},
                       @{@"clsName": @"CRANewsViewController", @"title": @"新闻", @"imageName": @"新闻"},
                       @{@"clsName": @"CRACircleViewController", @"title": @"圈子", @"imageName": @"圈子"},
                       @{@"clsName": @"CRAWeViewController", @"title": @"我们", @"imageName": @"我们"},
                       ];
    
    NSMutableArray <UIViewController *> *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        
        [arrayM addObject:[self childControllerWithDict:dict]];
    }
    
    self.viewControllers = arrayM.copy;
    
    self.selectedViewController = [self.viewControllers objectAtIndex:0];
//    Class cls = NSClassFromString(@"CRAHomeViewController");
//    
//    
//    UIViewController *vc = [[cls alloc] init];
//    self.selectedViewController = vc;
    
}
- (void)pop {
    [self.navigationController popViewControllerAnimated:YES];

}

/**
 * 创建一个子控制器
 */
- (UIViewController *)childControllerWithDict:(NSDictionary *)dict {
    
    // 1. 创建控制器
    NSString *clsName = dict[@"clsName"];
    Class cls = NSClassFromString(clsName);
    
    NSAssert(cls != nil, @"传入了类名错误");
    UIViewController *vc = [cls new];
    
    // 2. 设置标题
    vc.title = dict[@"title"];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"title_返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
//    vc.navigationItem.leftBarButtonItem = leftItem;
    
    // 3. 图片
    NSString *imageName = [NSString stringWithFormat:@"%@默认", dict[@"imageName"]];
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    //     高亮图片
    NSString *imageNameHL = [NSString stringWithFormat:@"%@", dict[@"imageName"]];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageNameHL] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 4. 添加导航控制器
    CRAMainNavViewController *nav = [[CRAMainNavViewController alloc] initWithRootViewController:vc];
    
    // 5. 返回导航控制器
    return nav;
}



@end
