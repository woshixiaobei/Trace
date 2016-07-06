//
//  CRAHomeStartScoreView.m
//  Trace
//
//  Created by Arvin on 16/6/23.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAHomeStartScoreView.h"

@implementation CRAHomeStartScoreView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self setupUI];
}

- (void)setStartCount:(CGFloat)startCount {
    
    _startCount = startCount;
    
    /**
     *  处理cell复用
     */
    for (UIImageView *iv in self.subviews) {
        
        iv.image = [UIImage imageNamed:@"empty_star"];
    }
    
    NSInteger fullStartCount = (NSInteger)startCount;
    
    for (NSInteger i = 0; i < fullStartCount; i++) {
        UIImageView *iv = self.subviews[i];
        
        iv.image = [UIImage imageNamed:@"full_star"];
    }
    
    if (startCount - fullStartCount > 0) {
        UIImageView *iv = self.subviews[fullStartCount];
        iv.image = [UIImage imageNamed:@"half_star"];
    }
}

#pragma mark - 设置界面

- (void)setupUI {
    
    NSInteger count = 5;
    
    CGFloat width = self.bounds.size.width / count;
    
    CGFloat height = self.bounds.size.height;
    
    CGRect rect = CGRectMake(0, 0, width, height);
    
    for (NSInteger i = 0; i < count; i++) {
        UIImageView *iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"empty_star"]];
        iv.frame = CGRectOffset(rect, width * i, 0);
        [self addSubview:iv];
    }
}



@end
