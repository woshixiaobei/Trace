//
//  CRACommunityTabBarController.m
//  Trace
//
//  Created by 张玺科 on 16/6/22.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRACommunityTabBarController.h"
#import "CRACommunityNavigationController.h"
#import "UIImage+DXImage.h"
#import "CRATabBar.h"
#import "CRAMoreViewController.h"
#import "CRACircleViewController.h"
#import "CRADetailViewController.h"
#import "RZPopupMenuView.h"
#import "UIView+AdjustFrame.h"
#import "CRACommunityViewController.h"

#define RZWindow [UIApplication sharedApplication].keyWindow

@interface CRACommunityTabBarController ()<RZPopupMenuViewDelegate>

@end

@implementation CRACommunityTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建4个子控制器
    [self addChildViewControllers];
    
    // 自定义tabBar
    CRATabBar *tabBar = [[CRATabBar alloc] initWithFrame:self.tabBar.frame];
    
    // 利用KVC把readonly权限改过来
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    
    tabBar.tabBarBlock = ^(){
        
        
        [RZPopupMenuView showWithDelegate:self];
        
        
    };
}



- (void)popupMenuView:(RZPopupMenuView *)view selectedIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            NSLog(@"第一个");
            break;
        }
            
        case 1:
        {
            CRACommunityViewController *comVC = [[CRACommunityViewController alloc]init];
            [self presentViewController:comVC animated:YES completion:nil];

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
    
    // 3. 图片
    NSString *imageName = [NSString stringWithFormat:@"%@默认", dict[@"imageName"]];
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    //     高亮图片
    NSString *imageNameHL = [NSString stringWithFormat:@"%@", dict[@"imageName"]];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageNameHL] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 4. 添加导航控制器
    CRACommunityNavigationController *nav = [[CRACommunityNavigationController alloc] initWithRootViewController:vc];
    
    // 5. 返回导航控制器
    return nav;
}
@end
