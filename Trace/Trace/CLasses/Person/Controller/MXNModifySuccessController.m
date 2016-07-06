//
//  MXNModifySuccessController.m
//  ddddd
//
//  Created by Clark on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "MXNModifySuccessController.h"
#import "MXNLoginController.h"
#import "MBProgressHUD.h"
@interface MXNModifySuccessController ()

@end

@implementation MXNModifySuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改成功";
    // 隐藏右边的item
    [self.navigationItem setRightBarButtonItem:nil];
    
    // 1.创建hud
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    // 2.设置信息
    hud.labelText = @"恭喜您的密码已经修改成功！";
    
    // 3.添加到视图
    [self.navigationController.view addSubview:hud];
    
    [hud show:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud removeFromSuperview];
    });
}
- (IBAction)goToLoginBtnClick:(UIButton *)sender {
    // 这里用pop回按指定界面  不能用push
    NSArray *vcs = self.navigationController.viewControllers;
    MXNLoginController *loginC = vcs[1];

    [self.navigationController popToViewController:loginC animated:YES];
    
}

@end
