//
//  MXNModifyVerifyController.m
//  ddddd
//
//  Created by Clark on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "MXNModifyVerifyController.h"
#import "MXNTextField.h"
#import "MXNVerifySuccessController.h"
@interface MXNModifyVerifyController ()
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *verifyView;

@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIButton *getVerification;

@property (nonatomic, strong) MXNTextField *phoneNum;
@property (nonatomic, strong) MXNTextField *verifyNum;
@end

@implementation MXNModifyVerifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改验证";
    // 隐藏右边的item
    [self.navigationItem setRightBarButtonItem:nil];
    
    //[UIColor redColor]
    self.phoneNum = [MXNTextField addTextFieldWithPlaceHolder:@"手机号" addImage:[UIImage imageNamed:@"登陆注册_手机号_icon"] addColor:[UIColor cz_colorWithRed:53 green:174 blue:243]];
    
    [self.phoneView addSubview:self.phoneNum];

    self.verifyNum = [MXNTextField addTextFieldWithPlaceHolder:@"输入验证码" addImage:[UIImage imageNamed:@"登陆注册_手机验证码_icon"] addColor:[UIColor cz_colorWithRed:53 green:174 blue:243]];
    
    [self.verifyView addSubview:self.verifyNum];
    
    [self.phoneNum addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.verifyNum addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    
    //    [self textChange:nil];
}

- (void)viewDidLayoutSubviews {
    
    self.phoneNum.frame = self.phoneView.bounds;
    self.verifyNum.frame = self.verifyView.bounds;
}


- (IBAction)getVerificationNum:(UIButton *)sender {
    
    u_int32_t num = arc4random_uniform(900000) + 100000;
    NSString *strNum = [NSString stringWithFormat:@"%d",num];
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"验证码" message:strNum preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.verifyNum.text = strNum;
        
    }];
    [alertC addAction:confirm];
    [self presentViewController:alertC animated:YES completion:nil];
}

#pragma mark - 实现监听文本框变化的方法
- (void)textChange:(MXNTextField *)sender {
    
    NSString *phoneNum = self.phoneNum.text;
//    NSString *verifyNum = self.verifyNum.text;
    
    self.btn.enabled = NO;
    self.getVerification.enabled = NO;
    // 判断,调整按钮状态
    if ([phoneNum isEqualToString:@"13800111100"]){
        
        self.btn.enabled = YES;
        self.getVerification.enabled = YES;
    } 
}


- (IBAction)btnClick:(UIButton *)sender {
    [self.view endEditing:YES];
    if (![self.phoneNum.text isEqualToString:@"13800111100"]) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        
        hud.labelText = @"请输入电话号码";
        
        // 3.添加到视图
        [self.navigationController.view addSubview:hud];
        [hud show:YES];
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.5];
        return;
    }
    if ([self.verifyNum.text isEqualToString:@""]) {

        // 1.创建hud
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        
        hud.labelText = @"请获取验证码";
        
        // 3.添加到视图
        [self.navigationController.view addSubview:hud];
        [hud show:YES];
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.5];
        return;
    }

    //把存入沙盒的手机号码换掉
#define MXNPhoneNum @"MXNPhoneNum"
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 2.存储数据
    [defaults setObject:self.phoneNum.text forKey:MXNPhoneNum];
    // 3.同步
    [defaults synchronize];
    
    MXNVerifySuccessController * verifySuccessC = [[MXNVerifySuccessController alloc] init];
    [self.navigationController pushViewController:verifySuccessC animated:YES];
}

@end
