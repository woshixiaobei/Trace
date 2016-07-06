//
//  MXNPhoneVerificationController.m
//  ddddd
//
//  Created by Clark on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "MXNPhoneVerificationController.h"
#import "MXNTextField.h"
#import "MXNPhoneBindingController.h"
@interface MXNPhoneVerificationController ()
@property (weak, nonatomic) IBOutlet UIView *oldPhoneNumView;
@property (weak, nonatomic) IBOutlet UIView *verifyNumView;

@property (nonatomic, strong) MXNTextField *oldPhoneNum;
@property (nonatomic, strong) MXNTextField *verifyField;
@property (weak, nonatomic) IBOutlet UIButton *getVerfition;

@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
@end

@implementation MXNPhoneVerificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"手机验证";
    // 隐藏右边的item
    [self.navigationItem setRightBarButtonItem:nil];
    
    
    //MXNRGBColor(53, 174, 243)
    self.oldPhoneNum = [MXNTextField addTextFieldWithPlaceHolder:@"手机号" addImage:[UIImage imageNamed:@"登陆注册_手机号_icon"] addColor:[UIColor cz_colorWithRed:53 green:174 blue:243]];
    
    [self.oldPhoneNumView addSubview:self.oldPhoneNum];
    
    //MXNRGBColor(53, 174, 243)
    self.verifyField = [MXNTextField addTextFieldWithPlaceHolder:@"输入验证码" addImage:[UIImage imageNamed:@"登陆注册_手机验证码_icon"] addColor:[UIColor cz_colorWithRed:53 green:174 blue:243]];
    
    [self.verifyNumView addSubview:self.verifyField];
    
    [self.oldPhoneNum addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.verifyField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventValueChanged];
    
    
    [self textChange:nil];
    
}

- (void)viewDidLayoutSubviews {
    self.oldPhoneNum.frame = self.oldPhoneNumView.bounds;
    self.verifyField.frame = self.verifyNumView.bounds;
    
}
#pragma mark - 实现监听文本框变化的方法
- (void)textChange:(MXNTextField *)sender {
    
    NSString *phoneNum = self.oldPhoneNum.text;

    self.verifyBtn.enabled = NO;
    self.getVerfition.enabled = NO;

    // 2.判断,调整按钮状态
    if (phoneNum.length == 11  && [phoneNum isEqualToString:@"13800111100"]){
        self.verifyBtn.enabled = YES;
        self.getVerfition.enabled = YES;
        
        }
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

#pragma mark - 验证按钮的点击
- (IBAction)verifyBtnClick:(UIButton *)sender {
    
       if ([self.verifyField.text isEqualToString:@""]) {

        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        
        hud.labelText = @"请获取验证码";
        
        // 3.添加到视图
        [self.navigationController.view addSubview:hud];
        [hud show:YES];
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.5];
        return;
    }
    _oldPhoneNum.text = @"";
    _verifyField.text = @"";
    MXNPhoneBindingController *phonebindingC = [[MXNPhoneBindingController alloc] init];
    [self.navigationController pushViewController:phonebindingC animated:YES];
}
#pragma mark - 点击屏幕收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    self.verifyBtn.enabled = NO;

}

@end
