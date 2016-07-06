//
//  CHPresentationController.m
//  CircleLifeApp
//
//  Created by CrazyHacker on 16/6/22.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CHPresentationController.h"

@interface CHPresentationController()
@property (nonatomic, strong) UIView *darkView;

@end
@implementation CHPresentationController
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    
    // 创建遮罩视图 -- 在展现视图控制器创建之前 容器视图还没有创建好
    _darkView = [[UIView alloc] init];
    _darkView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPresentViewController:)];
    // 讲手势添加到视图
    [_darkView addGestureRecognizer:tap];
    
    return [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
}

- (void)dismissPresentViewController:(UITapGestureRecognizer *)tap {
    // 要让展现的控制器接触转场
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  容器视图要布局子视图
 */
- (void)containerViewWillLayoutSubviews {
    _darkView.frame = self.containerView.bounds;
    [self.containerView insertSubview:_darkView atIndex:0];
    
    // 设置目标视图的大小
    CGRect rect = self.containerView.bounds;
    
    CGFloat height = rect.size.height * 0.25 - 50;
    CGFloat width = rect.size.width * 2 / 3 + 20;
    self.presentedView.frame = CGRectMake(0, 0, width, height);
    self.presentedView.center = self.containerView.center;

}
@end
