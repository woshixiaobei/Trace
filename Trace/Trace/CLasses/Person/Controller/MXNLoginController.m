//
//  MXNLoginController.m
//  ddddd
//
//  Created by Clark on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "MXNLoginController.h"
#import "MXNRegisterController.h"
#import "MXNModifyVerifyController.h"
#import "AFNetworking.h"
#import "MXNTextField.h"
#import "MBProgressHUD.h"
#import "MXNWebManager.h"
#import "AFURLRequestSerialization.h"
#import "MXUserRulesController.h"


#define MXNUserName @"MXNUserName"
#define MXNPassword @"MXNPassword"
#define MXNRememberBool @"MXNRememberBool"
#define MXNAlreadyLogined @"MXNAlreadyLogined"
#define MXNUserMobile @"MXNUserMobile"
#define MXNUserHeadPortrait @"MXNUserHeadPortrait"
#define MXNUserFullName @"MXNUserFullName"
#define MXNUserGender @"MXNUserGender"
@interface MXNLoginController ()

@property (weak, nonatomic) IBOutlet UIView *userNameView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;

@property (nonatomic, strong) MXNTextField *userName;
@property (nonatomic, strong) MXNTextField *password;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic, assign) BOOL rememberBool;

@property (weak, nonatomic) IBOutlet UIButton *rememberBtn;

// 设置一个bool值，记录是否已登录
@property (nonatomic, assign) BOOL alreadyLogined;
@end

@implementation MXNLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    // 隐藏右边的item
    [self.navigationItem setRightBarButtonItem:nil];
    
    // 读取沙盒
    // 1.获取偏好设置对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 2.读取数据
    self.userName.text = [defaults objectForKey:MXNUserName];
    self.password.text = [defaults objectForKey:MXNPassword];
    self.rememberBool = [defaults boolForKey:MXNRememberBool];
    
    // 3.0 如果记住密码是关着的,就不要显示密码
    if (!self.rememberBool) {
        // 清除密码
        self.password.text = nil;
    }
    self.userName = [MXNTextField addTextFieldWithPlaceHolder:@"用户名" addImage:[UIImage imageNamed:@"title_个人中心"] addColor:[UIColor colorWithRed:11/255.0 green:181/255.0 blue:252/255.0 alpha:1]];
    
    [self.userNameView addSubview:self.userName];

    self.password = [MXNTextField addTextFieldWithPlaceHolder:@"6-12位 仅限于数字和字母" addImage:[UIImage imageNamed:@"个人中心_修改密码按钮icon"] addColor:[UIColor colorWithRed:11/255.0 green:181/255.0 blue:252/255.0 alpha:1]];
    self.password.secureTextEntry = YES;
    [self.passwordView addSubview:self.password];
    
    //监听文本框内容的改变
    [self.userName addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.password addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    
    // 手动调用一下下面的方法
    [self textChange:nil];
    self.rememberBool = NO;
}

#pragma mark - 适配屏幕
- (void)viewDidLayoutSubviews {
    
    self.userName.frame = self.userNameView.bounds;
    self.password.frame = self.passwordView.bounds;
}

#pragma mark - 实现监听文本框变化的方法
- (void)textChange:(MXNTextField *)sender {
    
    // 如果用户名和密码都有内容,才能够点击登录按钮,否则不能点
    // 1.获取用户名和密码的内容
    if ([self.userName.text isEqualToString:@"123"]) {
        self.userName.text = @"13800111100";
    }
    NSString *userName = self.userName.text;
    NSString *password = self.password.text;
    
    // 2.判断,调整按钮状态
    if (userName.length > 0 && password.length > 0) {
        
        self.loginBtn.enabled = YES;
    } else {
        
        self.loginBtn.enabled = NO;
    }
}

#pragma mark - 登录按钮的点击
- (IBAction)loginBtn:(UIButton *)sender {
    
    [self.view endEditing:YES];
    // 1.创建hud
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    
    hud.labelText = @"正在登录...";
    
    // 3.添加到视图
    [self.navigationController.view addSubview:hud];
    
    // 4.显示 bool 决定是否要动画
    [hud show:YES];
    
    // 1.获取用户名和密码
    NSString *userName = self.userName.text;
    NSString *password = self.password.text;
    
    //1.创建一个管理者  实行网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 请求的必须是json格式的   默认的是二进制格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    //2.由管理者发起请求http://iosapi.itcast.cn/life/loginData.json.php
    NSDictionary *param = @{@"account":userName, @"pasword":password};
    
    [manager POST:@"http://iosapi.itcast.cn/life/loginData.json.php" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 取出数组/Users/MengXianNan/Desktop/111
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *str = dict[@"user_id"];
//        [dict writeToFile:@"/Users/MengXianNan/Desktop/111/111.plist" atomically:YES];
        
        if (![str isEqualToString:@"123456"]){
            
            hud.mode = MBProgressHUDModeText;
            
            hud.labelText = @"用户名或密码错误";
            
            [hud hide:YES afterDelay:3.0];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [hud removeFromSuperview];
            });
            return ;
        }
        
        // 登录成功时,隐藏别再有动画
        [hud hide:NO];
        // 需要移除
        [hud removeFromSuperview];
        // 调到原来的界面
        [self.navigationController popViewControllerAnimated:YES];
        
        self.alreadyLogined = YES;
        
        //存入沙盒
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setBool:self.alreadyLogined forKey:MXNAlreadyLogined];
        
        [defaults setObject:@"13800111100" forKey:MXNUserMobile];

        [defaults setObject:@" http://iosapi.itcast.cn/life/images/middle_14477475387400.jpg"  forKey:MXNUserHeadPortrait];

        [defaults setObject:@"Ricky" forKey:MXNUserFullName];
        [defaults setBool:1 forKey:MXNUserGender];
        // 同步
        [defaults synchronize];
        
        // 发通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"alreadlyLogin" object:self];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error.localizedDescription);
    }];
    
}

#pragma mark - 注册按钮的点击
- (IBAction)registerBtnClick:(UIButton *)sender {
    
    MXNRegisterController *registerC = [[MXNRegisterController alloc] init];
    
    [self.navigationController pushViewController:registerC animated:YES];
}

#pragma mark - 记住密码的点击
- (IBAction)remeberPasswordBtnClick:(UIButton *)sender {
    
    self.rememberBool = !self.rememberBool;
    
    sender.selected = self.rememberBool;
    
    //存入沙盒
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.userName.text forKey:MXNUserName];
    [defaults setObject:self.password.text forKey:MXNPassword];
    [defaults setBool:self.rememberBool forKey:MXNRememberBool];
    
    // 3.同步
    [defaults synchronize];
}

#pragma mark - 忘记密码的点击
- (IBAction)forgetBtnClick:(UIButton *)sender {
    
    MXNModifyVerifyController *verifyC = [[MXNModifyVerifyController alloc] init];
    [self.navigationController pushViewController:verifyC animated:YES];
}

@end
