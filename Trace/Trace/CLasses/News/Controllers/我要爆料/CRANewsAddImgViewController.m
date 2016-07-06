//
//  CRANewsAddImgViewController.m
//  News
//
//  Created by 杨应海 on 16/6/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRANewsAddImgViewController.h"
#import "CRANewsAddImgPresentationController.h"

@interface CRANewsAddImgViewController ()<UIViewControllerTransitioningDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation CRANewsAddImgViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // 自定义转场
        self.modalPresentationStyle = UIModalPresentationCustom;
        // 设置转场代理
        self.transitioningDelegate = self;
    }
    return self;
}


#pragma mark - UIViewControllerTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    
    return [[CRANewsAddImgPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}


- (IBAction)chooseFromPhotosORTakePicture:(UIButton *)sender {
    //1. 创建一个 UIIMagePickerController 对象
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    // 系统的 API 如果要坚听某个东西，首先要尝试代理，
    imagePickerController.delegate = self;
    if (sender.tag == 1) {
        
        
        // 2. 设置图片的来源
        //        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        //        imagePickerController.allowsEditing = YES;
        // 3. modal出我们的相册
        
//        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
//        // 设置文字
//        HUD.labelText = @"正在努力加载中...🐶🐶🐶";
//        // 加入视图
//        [self.view addSubview:HUD];
//        // 动态展示
//        [HUD show:YES];
//        
//        // 加一个延时
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//          
//                // 隐藏 不带动画
//                [HUD hide:NO];
//                // 在变成 hidden 时移除
//                [HUD removeFromSuperview];
//                
//
//        });

        
        

//        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
//        HUD.labelText = @"没有摄像头!!!";
//        HUD.mode = MBProgressHUDModeText;
//        [self.navigationController.view addSubview:HUD];
//        // 设置动态显示
//        [HUD show:YES];
//        [HUD hide:YES afterDelay:2.0];
//       
//        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
//        
//        hud.labelText = @"您的诺基亚没有摄像头";
//        
//        // 3.添加到视图
//        [self.navigationController.view addSubview:hud];
//        [hud show:YES];
//        hud.mode = MBProgressHUDModeText;
//        [hud hide:YES afterDelay:1.5];
//        // 加一个延时
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//            // 设置隐藏不带动画
//            [HUD hide:NO];
//            // 从父视图删除
//            [HUD removeFromSuperview];
//        });
        
        
    } else {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
}

/**
 * 取消
 */
- (IBAction)cancel:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end






