//
//  CRANewsAddImgPresentationController.m
//  News
//
//  Created by 杨应海 on 16/6/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRANewsAddImgPresentationController.h"

@implementation CRANewsAddImgPresentationController {
    
    UIView *_maskView;
}

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        
    }
    return self;
}

// 布局展现的视图
- (void)containerViewWillLayoutSubviews {
    
    [self.containerView insertSubview:_maskView atIndex:0];
    
    //1. 底部插入一个遮罩视图，提供透明效果
    _maskView.frame = self.containerView.bounds;
    
    
    CGRect rect = self.containerView.bounds;
    
    CGFloat height = 196;
    rect.origin.x = 20;
    rect.origin.y = rect.size.height - 390;
    rect.size.height = height;
    rect.size.width = rect.size.width - 40;
    // 2. 设置被展现控制器的根视图的大小
    self.presentedView.frame = rect;
}

@end





