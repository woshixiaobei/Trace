//
//  MXNPhoneBindingController.m
//  ddddd
//
//  Created by Clark on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "MXNPhoneBindingController.h"
#import "MXNTextField.h"
#import "MXNLoginController.h"
#import "MXNDataModifyController.h"
@interface MXNPhoneBindingController ()
@property (weak, nonatomic) IBOutlet UIView *phoneNumView;

@property (weak, nonatomic) IBOutlet UIView *verifyView;
@property (weak, nonatomic) IBOutlet UIButton *bindingBtn;
@property (weak, nonatomic) IBOutlet UIButton *getVerfition;

@property (nonatomic, strong) MXNTextField *phoneNum;
@property (nonatomic, strong) MXNTextField *verifyField;
@end

@implementation MXNPhoneBindingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"手机绑定";
    // 隐藏右边的item
    [self.navigationItem setRightBarButtonItem:nil];
    
    self.phoneNum = [MXNTextField addTextFieldWithPlaceHolder:@"手机号" addImage:[UIImage imageNamed:@"登陆注册_手机号_icon"] addColor:[UIColor cz_colorWithRed:53 green:174 blue:243]];//
    
    [self.phoneNumView addSubview:self.phoneNum];
    
    self.verifyField = [MXNTextField addTextFieldWithPlaceHolder:@"输入验证码" addImage:[UIImage imageNamed:@"登陆注册_手机验证码_icon"] addColor:[UIColor cz_colorWithRed:53 green:174 blue:243]];//
    
    [self.verifyView addSubview:self.verifyField];
    
    [self.phoneNum addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.verifyField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    [self textChange:nil];
    
}
- (IBAction)getVerfitionNum:(UIButton *)sender {
    
    u_int32_t num = arc4random_uniform(900000) + 100000;
    NSString *strNum = [NSString stringWithFormat:@"%d",num];
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"验证码" message:strNum preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.verifyField.text = strNum;
        
    }];
    [alertC addAction:confirm];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)viewDidLayoutSubviews {
    
    self.phoneNum.frame = self.phoneNumView.bounds;
    self.verifyField.frame = self.verifyView.bounds;
}
#pragma mark - 实现监听文本框变化的方法
- (void)textChange:(MXNTextField *)sender {
    
    NSString *phoneNum = self.phoneNum.text;
    
    self.getVerfition.enabled = NO;
    self.bindingBtn.enabled = NO;
    // 2.判断,调整按钮状态
    if (phoneNum.length == 11 ){
        self.getVerfition.enabled = YES;
        self.bindingBtn.enabled = YES;
        
    }
}
#pragma mark - 点击屏幕收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (IBAction)bindingBtnClick:(UIButton *)sender {
    
    if ([self.verifyField.text isEqualToString:@""]) {
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

#define MXNUserMobile @"MXNUserMobile"

    // pop修改资料 界面
    NSArray *vcs = self.navigationController.viewControllers;
    MXNDataModifyController *dataModifyC = vcs[2];
  ;
    
    [self.navigationController popToViewController:dataModifyC animated:YES];
    
    
    // 发通知修改电话号码
    [[NSNotificationCenter defaultCenter] postNotificationName:@"bingingPhoneNum" object:self.phoneNum.text];
    
}

@end
