//
//  MXNPersonalController.m
//  ddddd
//
//  Created by Clark on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "MXNPersonalController.h"
#import "MXNModifyPasswordController.h"
#import "MXNDataModifyController.h"
#import "CRAHomeViewController.h"
#import "CRAMyOrdersViewController.h"
#define MXNAlreadyLogined @"MXNAlreadyLogined"
#define MXNUserMobile @"MXNUserMobile"
#define MXNUserHeadPortrait @"MXNUserHeadPortrait"
#define MXNUserFullName @"MXNUserFullName"
#define MXNUserGender @"MXNUserGender"
@interface MXNPersonalController ()
@property (weak, nonatomic) IBOutlet UILabel *fullNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *headerPortraitView;

@property (weak, nonatomic) IBOutlet UILabel *gender;

@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;

@property (nonatomic, strong) UIView *coverView;

@end

@implementation MXNPersonalController

- (void)viewDidLoad {
    [super viewDidLoad];
    _phoneBtn.enabled = NO;
    self.navigationItem.title = @"个人中心";
    // 隐藏右边的item
    [self.navigationItem setRightBarButtonItem:nil];
    

    // 接受通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyImage:) name:@"NSNotificationImage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyFullName:) name:@"NSNotificationFullName" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifygender:) name:@"NSNotificationGenderBoy" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyPhoneNum:) name:@"bingingPhoneNum" object:nil];
    
    //读取沙盒
    // 1.获取偏好设置对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 2.读取数据
    self.fullNameLbl.text = [defaults objectForKey:MXNUserFullName];
    self.phoneBtn.titleLabel.text = [defaults objectForKey:MXNUserMobile];
    BOOL gender = [defaults boolForKey:MXNUserGender];
    if (gender == 1) {
        self.gender.text = @"男";
    } else {
        self.gender.text = @"女";
    }
    
    [self.headerPortraitView sd_setImageWithURL:[NSURL URLWithString:@"http://iosapi.itcast.cn/life/images/middle_14477475387400.jpg"]];
    
    
    
}

- (void)modifyImage:(NSNotification *)info {
    
    UIImage *image = info.object;
    self.headerPortraitView.image = image;
}

- (void)modifyFullName:(NSNotification *)info {
    
    NSString *str = info.object;
    self.fullNameLbl.text = str;
    
}

- (void)modifyPhoneNum:(NSNotification *)info {
    
    NSString *str = info.object;
    [self.phoneBtn setTitle:str forState:UIControlStateNormal];
}

- (void)modifygender:(NSNotification *)info {
    
    NSString *str = info.object;
    if ([str isEqualToString:@"1"]) {
        
        self.gender.text = @"男";
    } else {
        self.gender.text = @"女";
    }
    
}

- (void)dealloc {
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotificationImage" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotificationFullName" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotificationGenderBoy" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"bingingPhoneNum" object:nil];
    
}
#pragma mark - 修改密码按钮的点击
- (IBAction)modifyPasswordBtn:(UIButton *)sender {
    
    MXNModifyPasswordController *modifyC = [[MXNModifyPasswordController alloc] init];
    [self.navigationController pushViewController:modifyC animated:YES];
}

#pragma mark - 修改资料按钮的点击
- (IBAction)modifyDataBtn:(UIButton *)sender {
    
    MXNDataModifyController *dataModifyC = [[MXNDataModifyController alloc] init];
    [self.navigationController pushViewController:dataModifyC animated:YES];
}

#pragma mark - 我的订单按钮的点击
- (IBAction)myOrderBtnClick:(UIButton *)sender {
    //    我的订单列表,已支付,未支付

    CRAMyOrdersViewController *order = [[CRAMyOrdersViewController alloc]init];
    [self.navigationController pushViewController:order animated:YES];
    
}

#pragma mark - 退出登录
- (IBAction)exitBtnClick:(UIButton *)sender {
    
    UIView *coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //MXNRGBAColor(0, 0, 0, 0.75)
    coverView.backgroundColor = [UIColor cz_colorWithRed:0 green:0 blue:0];
    coverView.alpha = 0.75;
    
    UIView *topView = [[UIView alloc] init];
    topView.bounds = CGRectMake(0, 0, 300, 150);
    topView.center = CGPointMake(coverView.center.x, coverView.center.y - 64);
    topView.layer.cornerRadius = 10;

    topView.backgroundColor = [UIColor cz_colorWithRed:0 green:0 blue:0];

    UILabel *lbl = [[UILabel alloc] init];
    lbl.text = @"您真的要残忍的退出吗？";
    lbl.textColor = [UIColor whiteColor];
    [lbl sizeToFit];
    [topView addSubview:lbl];
    
    UIButton *leftBtn = [[UIButton alloc] init];
  
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形-2-拷贝-2"] forState:UIControlStateNormal];
    [leftBtn setTitle:@"残忍退出" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc] init];
    
    
    rightBtn.backgroundColor = [UIColor cz_colorWithRed:80 green:190 blue:254];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形-2-拷贝-2"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:rightBtn];
    
    [coverView addSubview:topView];
    [self.view addSubview:coverView];
    
    self.coverView = coverView;
    
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView);
        make.top.equalTo(topView).with.offset(30);
    }];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).with.offset(30);
        make.bottom.equalTo(topView).with.offset(-30);
        make.height.mas_equalTo(40);
    }];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView).with.offset(-30);
        make.left.equalTo(leftBtn.mas_right).with.offset(30);
        make.width.height.top.equalTo(leftBtn);
        
    }];
}

- (void)leftBtnClick {
    
    [self.coverView removeFromSuperview];
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"exitLogin" object:self];
    
    BOOL noLogin = NO;
    // 存入沙盒
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //
    [defaults setBool:noLogin forKey:MXNAlreadyLogined];
    //把登录后的个人信息也存储在沙盒中
}

- (void)rightBtnClick {
    
    [self.coverView removeFromSuperview];
    
}

@end
