//
//  CRATabBar.m
//  Trace
//
//  Created by 张玺科 on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRATabBar.h"
#import "RZPopupMenuView.h"


@interface CRATabBar()



@property (nonatomic, weak) UIButton *plusButton;

@end

@implementation CRATabBar
#pragma mark - 懒加载设置中间按钮
- (UIButton *)plusButton {
    if (_plusButton == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:@"bg-addbutton"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"bg-addbutton-highlighted"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon-plus"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"icon-plus-highlighted"] forState:UIControlStateHighlighted];
        
        [btn sizeToFit];
        
        _plusButton = btn;
        [self addSubview:_plusButton];
        
    }
    
    return _plusButton;
}

#pragma mark - 调整子控件的位置和尺寸
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat butX = 0;  // x 是不确定的,可以初始化为0
    CGFloat butY = 0;  // y 就是0
    CGFloat butW = w / (self.items.count + 1); // 有几个UITabBarButton就有几个items模型
    CGFloat butH = h;
    
    int i = 0; // 定义角标,初始化为0
    // 调整系统自带的tabBar上面的按钮的位置
    for (UIView *tabBarButton in self.subviews) {
        // 判断是否是UITabBarButton
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            // 因为中间需要预留一个位置,所以,当i到中间的是,就跳过
            if (i == 2) {
                i = 3;
            }
            
            butX = i * butW;
            
            tabBarButton.frame = CGRectMake(butX, butY, butW, butH);
            
            i++;
        }
        
    }
    
    // 设置中间按钮的位置
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
    
    [self.plusButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickButton:(UIButton *)btn {
//    NSLog(@"你好");
    
    
    if (self.tabBarBlock) {
        
        self.tabBarBlock();
    }
}


@end
