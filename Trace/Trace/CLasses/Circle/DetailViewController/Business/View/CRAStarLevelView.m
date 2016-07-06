//
//  CRAStarLevelView.m
//  Trace
//
//  Created by 小贝 on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAStarLevelView.h"

@implementation CRAStarLevelView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [self setupUI];
}
#pragma mark-重写level方法
- (void)setLevel:(float)level {
    
    _level = level;
    for ( UIImageView *iv in self.subviews) {
        iv.image = [UIImage imageNamed:@"HomeSupport五星2"];
    }
    //根据level设置4.5
    NSInteger fullCount = (NSInteger)level;
    for (NSInteger i = 0; i < fullCount; i++) {
        UIImageView *iv = self.subviews[i];
        iv.image = [UIImage imageNamed:@"HomeSupport五星1"];
    }
    if (_level - fullCount > 0) {
        UIImageView *iv = self.subviews[fullCount];
        iv.image = [UIImage imageNamed:@"五星半个"];
    }
    
}

#pragma mark- 搭建界面
- (void)setupUI {

    NSInteger count = 5;
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width / 5;
    CGRect rect = CGRectMake(0, 0, height, width);
    //循环添加五颗空的小星星
    for (NSInteger i = 0; i < count; i++) {
        CGFloat offsetX = i * width;
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectOffset(rect, offsetX, 0)];
        iv.image = [UIImage imageNamed:@"五星2"];
        [self addSubview:iv];
    }

}

@end
