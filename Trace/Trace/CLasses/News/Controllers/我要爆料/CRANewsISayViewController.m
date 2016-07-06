//
//  CRANewsISayViewController.m
//  News
//
//  Created by 杨应海 on 16/6/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRANewsISayViewController.h"
#import "CRANewsAddImgViewController.h"
#import "CRANewsCommitView.h"

@interface CRANewsISayViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation CRANewsISayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _contentTextView.layer.borderWidth = 1.0;
    _contentTextView.layer.borderColor = [UIColor cz_colorWithRed:232 green:234 blue:235].CGColor;
    _contentTextView.layer.cornerRadius = 5;
    _contentTextView.layer.masksToBounds = YES;
    
    [_contentTextView resignFirstResponder];
    
}

// 点击添加表情
- (IBAction)loadFace:(UIButton *)sender {
    
    // 1.
//    UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有表情" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//    [v show];

//    2.
//    UIAlertController *av = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有相册" preferredStyle:UIAlertControllerStyleAlert];
//    [av addAction:[UIAlertAction actionWithTitle:@"卧槽" style:UIAlertActionStyleCancel handler:nil]];
//    
//    [self.navigationController presentViewController:av animated:YES completion:nil];
//    
//    
    //3.
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    HUD.labelText = @"😊😊😊😢...";
    [HUD show:YES];
    
    [self.navigationController.view addSubview:HUD];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HUD hide:NO];
        [HUD removeFromSuperview];
    });
    
}

// 点击添加图片
- (IBAction)loadImage:(UIButton *)sender {
    
    [self presentViewController:[CRANewsAddImgViewController new] animated:YES completion:nil];
    
}

// 点击提交,展现控制器
- (IBAction)loadCommit:(UIButton *)sender {
    
    CRANewsCommitView *alertView = [[CRANewsCommitView alloc] init];
    
    [alertView showInView:self.view];

    // ******* 这里不能加判断，因为判断的时候本身  这个block 属性为 nil 这里只是准备代码块，调用的时候判断
//    if (alertView.selectedButtonClick) {
//        alertView.selectedButtonClick = ^() {
//            [self.navigationController popViewControllerAnimated:YES];
//        };
//    }
    
    alertView.selectedButtonClick = ^(){
        [self.navigationController popToRootViewControllerAnimated:YES];
    };

    
}

@end






