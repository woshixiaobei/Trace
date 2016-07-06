//
//  MXNModifyPasswordController.m
//  ddddd
//
//  Created by Clark on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "MXNModifyPasswordController.h"
#import "MXNTextField.h"
#import "MXNModifySuccessController.h"
#import "MBProgressHUD.h"
@interface MXNModifyPasswordController ()
@property (weak, nonatomic) IBOutlet UIView *oldPasswordView;
@property (weak, nonatomic) IBOutlet UIView *PasswordView;
@property (weak, nonatomic) IBOutlet UIView *confirmPasswordView;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (nonatomic, strong) MXNTextField *oldPassword;
@property (nonatomic, strong) MXNTextField *Password;
@property (nonatomic, strong) MXNTextField *confirmPassword;
@end

@implementation MXNModifyPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";

    self.oldPassword = [MXNTextField addTextFieldWithPlaceHolder:@"旧密码" addImage:[UIImage imageNamed:@"个人中心_修改密码按钮icon"] addColor:[UIColor cz_colorWithRed:53 green:174 blue:243]];
    self.oldPassword.secureTextEntry = YES;
    [self.oldPasswordView addSubview:self.oldPassword];
    self.Password = [MXNTextField addTextFieldWithPlaceHolder:@"新密码，6-12位 仅限数字和字母" addImage:[UIImage imageNamed:@"个人中心_修改密码按钮icon"] addColor:[UIColor cz_colorWithRed:53 green:174 blue:243]];
    self.Password.secureTextEntry = YES;
    [self.PasswordView addSubview:self.Password];
    
    self.confirmPassword = [MXNTextField addTextFieldWithPlaceHolder:@"确认新密码" addImage:[UIImage imageNamed:@"个人中心_修改密码按钮icon"] addColor:[UIColor cz_colorWithRed:53 green:174 blue:243]];
    self.confirmPassword.secureTextEntry = YES;
    [self.confirmPasswordView addSubview:self.confirmPassword];
    
    // 监听文本框的内容改变
    [self.oldPassword addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.Password addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.confirmPassword addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];

    [self textChange:nil];
    
    
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    self.oldPassword.frame = self.oldPasswordView.bounds;
    
    self.Password.frame = self.PasswordView.bounds;
    
    self.confirmPassword.frame = self.confirmPasswordView.bounds;
}

#pragma mark - 实现监听文本框变化的方法
- (void)textChange:(MXNTextField *)sender {
    NSString *oldpassword = self.oldPassword.text;
    NSString *password = self.Password.text;
    NSString *confirmPassword = self.confirmPassword.text;
    
    // 2.判断,调整按钮状态
    if ( password.length > 0 && confirmPassword.length > 5 && confirmPassword.length < 12 && oldpassword.length > 5 && oldpassword.length < 13 && [confirmPassword isEqualToString:password] ){
        
        self.btn.enabled = YES;
    } else {
        
        self.btn.enabled = NO;

    }
}

// 确认密码的按钮的点击
- (IBAction)confirmBtnClick:(UIButton *)sender {
    
    // 存入沙盒
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
#define MXNPassword @"MXNPassword"
    // 存储数据
    
    [defaults setObject:self.Password.text forKey:MXNPassword];
    
    MXNModifySuccessController *modifySuccessC = [[MXNModifySuccessController alloc] init];
    [self.navigationController pushViewController:modifySuccessC animated:YES];
    
}


@end
