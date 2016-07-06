//
//  MXNDataModifyController.m
//  ddddd
//
//  Created by Clark on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "MXNDataModifyController.h"
#import "MXNAlertView.h"
#import "MXNPhoneVerificationController.h"
#define MXNUserMobile @"MXNUserMobile"
#define MXNUserHeadPortrait @"MXNUserHeadPortrait"
#define MXNUserFullName @"MXNUserFullName"
#define MXNUserGender @"MXNUserGender"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "MBProgressHUD.h"
#define MXNUserHeadPortraitFilePath @"MXNUserHeadPortraitFilePath"
@interface MXNDataModifyController ()<ClickedActionProtocol, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *fullNameField;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;

@property (weak, nonatomic) IBOutlet UIButton *boyButton;
@property (weak, nonatomic) IBOutlet UIButton *girlButton;
@property (nonatomic, strong) UILabel *boyLbl;

@property (weak, nonatomic) IBOutlet UIButton *headerBtn;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *hcimage;

@end

@implementation MXNDataModifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"资料修改";
// 隐藏右边的item
    [self.navigationItem setRightBarButtonItem:nil];
// 1.获取偏好设置对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (self.image) {
        [self.headerBtn setBackgroundImage:self.image forState:UIControlStateNormal];
    }else {
        
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:@"http://iosapi.itcast.cn/life/images/middle_14477475387400.jpg"] options:0
                                                       progress:^(NSInteger receivedSize, NSInteger expectedSize)
         {
//处理下载进度
         } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
             if (image) {
                 [self.headerBtn setBackgroundImage:image forState:UIControlStateNormal];
             }
         }];
    }
    
    
    
//读取数据
    self.fullNameField.text = [defaults objectForKey:MXNUserFullName];
    
// 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyPhoneNum:) name:@"bingingPhoneNum" object:nil];
    
    [self.phoneBtn setTitle:[defaults objectForKey:MXNUserMobile] forState:UIControlStateNormal];
  
}


- (IBAction)boyButtonClick:(UIButton *)sender {
    
    sender.selected = YES;
    self.girlButton.selected = NO;
    _boyLbl = [UILabel new];
    self.boyLbl.text = @"1";
}
- (IBAction)girlButtonClick:(UIButton *)sender {
    
    sender.selected = YES;
    self.boyButton.selected = NO;
    _boyLbl = [UILabel new];
    self.boyLbl.text = @"0";
}


- (void)modifyPhoneNum:(NSNotification *)info {
    NSString *str = info.object;
    
    [self.phoneBtn setTitle:str forState:UIControlStateNormal];
}

#pragma mark - 点击屏幕收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

#pragma mark - 点击头像
- (IBAction)headerportraBtnClick:(UIButton *)sender {
    
    MXNAlertView *alertView = [[MXNAlertView alloc] initWithFrame:self.view.bounds actions:@[@"拍照", @"从相册中选取", @"取消"] type:AlertViewTypeBottom];
    alertView.actionDelegate = self;
    [alertView show];
}

#pragma mark - 实现代理方法
- (void)selectedCenterActionIndex:(NSInteger)index {
    
}
- (void)selectedBottomActionIndex:(NSInteger)index
{
//创建一个UIImagePickerController对象
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
//系统的API,代理
    imagePickerController.delegate = self;
    
    if (index == 1) {
//设置我们图片的来源
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
//modal出相册
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
    } else if (index == 0) {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"您的诺基亚没有摄像头" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
//        [alertView show];
// 1.创建hud
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        
        hud.labelText = @"您的诺基亚没有摄像头";
        
// 添加到视图
        [self.navigationController.view addSubview:hud];
        [hud show:YES];
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.5];
//                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//                imagePickerController.allowsEditing = YES;//设置可编辑
    }
    
}


#pragma mark - 获取到图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
    
    [picker dismissViewControllerAnimated:YES completion:nil];

        self.image = image;
    self.hcimage = image;
    //将image转成NSData
    [self.headerBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    
}

#pragma mark - 确认修改按钮的点击事件
- (IBAction)confirmBtnClick:(UIButton *)sender {
    if (self.image == nil ) {
        
        [self.navigationController popViewControllerAnimated:YES];
// MARK: 存入沙盒
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//存储数据
        [defaults setObject:self.fullNameField.text forKey:MXNUserFullName];
        [defaults setObject:self.phoneBtn.titleLabel.text forKey:MXNUserMobile];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotificationFullName" object:self.fullNameField.text];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotificationGenderBoy" object:self.boyLbl.text];
        
        return;
  
    }
// 把照片写入沙盒
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSData *data = UIImagePNGRepresentation(self.image);
    [data writeToFile:filePath atomically:YES];
    
// 存入沙盒
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//存储数据
    [defaults setObject:self.fullNameField.text forKey:MXNUserFullName];
    [defaults setObject:self.phoneBtn.titleLabel.text forKey:MXNUserMobile];
    [defaults setObject:filePath forKey:MXNUserHeadPortraitFilePath];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    // 发通知修改
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotificationImage" object:self.image];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotificationFullName" object:self.fullNameField.text];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotificationGenderBoy" object:self.boyLbl.text];
    
}

#pragma mark - 取消按钮的点击
- (IBAction)cancelBtnClick:(UIButton *)sender {
    
    // 1.获取偏好设置对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 2.读取数据
    self.fullNameField.text = [defaults objectForKey:MXNUserFullName];
    self.phoneBtn.titleLabel.text = [defaults objectForKey:MXNUserMobile];
    
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:@"http://iosapi.itcast.cn/life/images/middle_14477475387400.jpg"] options:0
                                                   progress:^(NSInteger receivedSize, NSInteger expectedSize)
     {
         //处理下载进度
     } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
         if (image) {
             [self.headerBtn setBackgroundImage:image forState:UIControlStateNormal];
         }
     }];
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - 验证手机号
- (IBAction)phoneNumVerifyBtnClick:(UIButton *)sender {
    
    MXNPhoneVerificationController *phoneC = [[MXNPhoneVerificationController alloc] init];
    [self.navigationController pushViewController:phoneC animated:YES];
}




@end
