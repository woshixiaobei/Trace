//
//  CRANewsCategoryView.m
//  News
//
//  Created by 杨应海 on 16/6/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRANewsCategoryView.h"

#define offset 100

@implementation CRANewsCategoryView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    CGFloat width = size.width / self.subviews.count;
    CGFloat height = size.height;
    
    CGRect rect = CGRectMake(0, 0, width, height);
    
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        
        UIButton *button = self.subviews[i];
        
        button.frame = CGRectOffset(rect, width * i, 0);
    }
}

#pragma mark - 设置界面
- (void)setupUI {
  
    self.backgroundColor = [UIColor whiteColor];
    
    NSInteger count = 4;
    
    NSArray *categoryTitles = @[@"实时新闻",@"图片新闻",@"视频新闻",@"我要爆料"];
    
    for (NSInteger i = 0; i < count; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"newsImage0%zd", i + 1]];
        
        CGFloat imageWH = 60;
        CGFloat fontSize = 15;
        CGFloat space = 7;
        
        
        NSAttributedString *attrStr = [NSAttributedString cz_imageTextWithImage:image imageWH:imageWH title:categoryTitles[i] fontSize:fontSize titleColor:[UIColor cz_colorWithRed:86 green:87 blue:89] spacing:space];
        [button setAttributedTitle:attrStr forState:UIControlStateNormal];
        
        [button sizeToFit];
        button.titleLabel.numberOfLines = 0;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:button];
        
        // 这里设置监听方法，然后在实现监听方法里面，把选中的按钮的索引返回给主控制器
        
        button.tag = offset + i;
        
        NSLog(@"%zd",button.tag);

        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)clickButton:(UIButton *)button {
    
    // 设置选中的索引
    _selectedIndex = button.tag - offset;
    
    button.highlighted = YES;
    
    
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end







