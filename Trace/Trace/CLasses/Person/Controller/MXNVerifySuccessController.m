//
//  MXNVerifySuccessController.m
//  ddddd
//
//  Created by Clark on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "MXNVerifySuccessController.h"
#import "MXNTextField.h"
#import "MXNModifySuccessController.h"
@interface MXNVerifySuccessController ()
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet UIView *confirmPasswordView;

@property (nonatomic, strong) MXNTextField *password;
@property (nonatomic, strong) MXNTextField *confirmPassword;
@end

@implementation MXNVerifySuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"验证成功";
    // 隐藏右边的item
    [self.navigationItem setRightBarButtonItem:nil];

    self.password = [MXNTextField addTextFieldWithPlaceHolder:@"输入密码" addImage:[UIImage imageNamed:@"组-4"] addColor:[UIColor cz_colorWithRed:53 green:175 blue:243]];
    
    [self.passwordView addSubview:self.password];
    
    self.confirmPassword = [MXNTextField addTextFieldWithPlaceHolder:@"确认密码" addImage:[UIImage imageNamed:@"确认密码"] addColor:[UIColor redColor]];
    
    [self.confirmPasswordView addSubview:self.confirmPassword];
    
    [self.password addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.confirmPassword addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    [self textChange:nil];
    
    
}

- (void)viewDidLayoutSubviews {
    
    self.password.frame = self.passwordView.bounds;
    self.confirmPassword.frame = self.confirmPasswordView.bounds;
}

#pragma mark - 实现监听文本框变化的方法
- (void)textChange:(MXNTextField *)sender {
    
    NSString *password = self.password.text;
    NSString *confirmPassword = self.confirmPassword.text;
    
    // 2.判断,调整按钮状态
    if ( password.length > 6 && password.length < 12 && confirmPassword.length > 6 &&  confirmPassword.length < 12&& [password isEqualToString:confirmPassword]){
        
        self.btn.enabled = YES;
    } else {
        
        self.btn.enabled = NO;
        
    }
}

- (IBAction)btnClick:(UIButton *)sender {
    [self.view endEditing:YES];
#define MXNPassword @"MXNPassword"
    //存入沙盒
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //把沙盒的密码替换掉
    // 2.存储数据
    [defaults setObject:self.password.text forKey:MXNPassword];
    // 3.同步
    [defaults synchronize];
    
    MXNModifySuccessController *modifysuccessC = [[MXNModifySuccessController alloc] init];
    [self.navigationController pushViewController:modifysuccessC animated:YES];
}


@end
