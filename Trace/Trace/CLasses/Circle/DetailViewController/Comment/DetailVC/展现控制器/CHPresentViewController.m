//
//  CHPresentViewController.m
//  CircleLifeApp
//
//  Created by CrazyHacker on 16/6/22.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//


#import "CHPresentViewController.h"
#import "CHPresentationController.h"

@interface CHPresentViewController ()<UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UIButton *linkXinLangBtn;

@property (weak, nonatomic) IBOutlet UIButton *linkQZoneBtn;

@property (weak, nonatomic) IBOutlet UIButton *linkDouBanBtn;

@property (weak, nonatomic) IBOutlet UIButton *linkRenRenBtn;

@property (weak, nonatomic) IBOutlet UIButton *linkWeChatBtn;

@property (weak, nonatomic) IBOutlet UIButton *cancleSharedAction;

@end

@implementation CHPresentViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.layer.cornerRadius = 10;
        self.view.layer.masksToBounds = YES;
        // 1. 设置展现方式为自定义
        self.modalPresentationStyle = UIModalPresentationCustom;
        
        // 2. 设置转场代理
        self.transitioningDelegate = self;
    }
    return self;
}

#pragma mark - 分享到其他应用操作
- (IBAction)sharedInfoToApp:(UIButton *)sender {
    // 设置代理, 在适当的时候执行 
    if ([self.delegate respondsToSelector:@selector(presentViewController:withButton:)]) {
    
        [self.delegate presentViewController:self withButton:sender];
    }
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    
    return [[CHPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}
@end
