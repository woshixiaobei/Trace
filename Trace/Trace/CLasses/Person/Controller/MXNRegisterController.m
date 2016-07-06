//
//  MXNRegisterController.m
//  ddddd
//
//  Created by Clark on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "MXNRegisterController.h"
#import "MXNTextField.h"
#import "MXNRegisterSuccessController.h"
#import "MXUserRulesController.h"
@interface MXNRegisterController ()
// 五个view
@property (weak, nonatomic) IBOutlet UIView *userNameView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UIView *confirmPasswordView;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *verifyView;
@property (weak, nonatomic) IBOutlet UIButton *getVerifition;
// 五个textfield
@property (nonatomic, strong) MXNTextField *userName;
@property (nonatomic, strong) MXNTextField *password;
@property (nonatomic, strong) MXNTextField *confirmPassword;
@property (nonatomic, strong) MXNTextField *phoneNum;
@property (nonatomic, strong) MXNTextField *verifyNum;

@property (nonatomic, assign) BOOL agreeBtnBool;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@end

@implementation MXNRegisterController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    // 隐藏右边的item
    [self.navigationItem setRightBarButtonItem:nil];

    self.userName = [MXNTextField addTextFieldWithPlaceHolder:@"用户名" addImage:[UIImage imageNamed:@"title_个人中心"] addColor:[UIColor cz_colorWithRed:53 green:174 blue:243]];
    [self.userNameView addSubview:self.userName];
    
    self.password = [MXNTextField addTextFieldWithPlaceHolder:@"输入密码" addImage:[UIImage imageNamed:@"个人中心_修改密码按钮icon"] addColor:[UIColor cz_colorWithRed:53 green:174 blue:243]];//
    self.password.secureTextEntry = YES;
    [self.passwordView addSubview:self.password];
    
    self.confirmPassword = [MXNTextField addTextFieldWithPlaceHolder:@"确认密码" addImage:[UIImage imageNamed:@"个人中心_修改密码按钮icon"] addColor:[UIColor cz_colorWithRed:53 green:174 blue:243]];//
    self.confirmPassword.secureTextEntry = YES;
    [self.confirmPasswordView addSubview:self.confirmPassword];
    
    self.phoneNum = [MXNTextField addTextFieldWithPlaceHolder:@"手机号" addImage:[UIImage imageNamed:@"登陆注册_手机号_icon"] addColor:[UIColor cz_colorWithRed:53 green:174 blue:243]];//
    
    [self.phoneView addSubview:self.phoneNum];
    
    self.verifyNum = [MXNTextField addTextFieldWithPlaceHolder:@"输入验证码" addImage:[UIImage imageNamed:@"登陆注册_手机验证码_icon"] addColor:[UIColor cz_colorWithRed:53 green:174 blue:243]];//
    
    [self.verifyView addSubview:self.verifyNum];
    
    // 监听文本文本框
    [self.userName addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.password addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.confirmPassword addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.phoneNum addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.verifyNum addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.agreeBtnBool = NO;
    
    
    [self textChange:nil];
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}
- (IBAction)getVerifitionNum:(UIButton *)sender {
    
    u_int32_t num = arc4random_uniform(900000) + 100000;
    NSString *strNum = [NSString stringWithFormat:@"%d",num];
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"验证码" message:strNum preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.verifyNum.text = strNum;
        
    }];
    [alertC addAction:confirm];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)viewDidLayoutSubviews {
    
    self.userName.frame = self.userNameView.bounds;
    self.password.frame = self.passwordView.bounds;
    self.confirmPassword.frame = self.confirmPasswordView.bounds;
    self.phoneNum.frame = self.phoneView.bounds;
    self.verifyNum.frame = self.verifyView.bounds;
}
#pragma mark - 实现监听文本框变化的方法
- (void)textChange:(MXNTextField *)sender {
    
    // 如果用户名和密码都有内容,才能够点击登录按钮,否则不能点
    // 1.获取用户名和密码的内容
    NSString *userName = self.userName.text;
    NSString *password = self.password.text;
    NSString *confirmPassword = self.confirmPassword.text;
    NSString *phoneNum = self.phoneNum.text;
    NSString *verifyNum = self.verifyNum.text;
    if (phoneNum.length == 11) {
        self.getVerifition.enabled = YES;
    } else {
        self.getVerifition.enabled = NO;
    }
    // 2.判断,调整按钮状态
    if (userName.length > 0 && password.length > 5 && password.length < 13 && confirmPassword.length > 5 && confirmPassword.length < 13  && phoneNum.length == 11 && verifyNum.length > 0 && self.agreeBtnBool == YES && [password isEqualToString:confirmPassword]){
        
        self.registerBtn.enabled = YES;
    } else {
        
        self.registerBtn.enabled = NO;
    }
}

#pragma mark - 注册按钮的点击   把信息存入沙盒
- (IBAction)registerBtnClick:(UIButton *)sender {
    [self.view endEditing:YES];
#define MXNUserName @"MXNUserName"
#define MXNPassword @"MXNPassword"
#define MXNPhoneNum @"MXNPhoneNum"
    //存入沙盒
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 2.存储数据
    [defaults setObject:self.userName.text forKey:MXNUserName];
    [defaults setObject:self.password.text forKey:MXNPassword];
    [defaults setObject:self.phoneNum.text forKey:MXNPhoneNum];
    // 3.同步
    [defaults synchronize];
    
    MXNRegisterSuccessController *registerSuccessC = [[MXNRegisterSuccessController alloc] init];
    [self.navigationController pushViewController:registerSuccessC animated:YES];
    
}

#pragma mark - 同意按钮的点击
- (IBAction)argeeBtnClick:(UIButton *)sender {
    
    self.agreeBtnBool = !self.agreeBtnBool;
    
    sender.selected = self.agreeBtnBool;
}
- (IBAction)agreeRules:(id)sender {
    
    [self.navigationController pushViewController:[MXUserRulesController new] animated:YES];
}



@end
