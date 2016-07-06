//
//  CRAHeaderView.m
//  Trace
//
//  Created by 小贝 on 16/6/20.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAHeaderView.h"

@interface CRAHeaderView()

@property (nonatomic, strong) NSArray<UIButton *> *buttons;

@end
@implementation CRAHeaderView {
    NSInteger mark;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark-重写setter方法
- (void)setOffsetX:(CGFloat)offsetX {
    _offsetX = offsetX;
    
    //根据offset设置蓝色视图的位置centerX
    [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_buttons[0]).offset(offsetX);
    }];
    
    //根据_offsetX / button[0].width
    CGFloat index = (_offsetX / _buttons[0].bounds.size.width + 0.5);
    NSInteger i = (NSInteger)index;
    
    //更换按钮的索引
    _buttons[_selectIndex].selected = NO;
    _selectIndex = i;
    _buttons[_selectIndex].selected = YES;
}

#pragma mark-搭建界面
- (void)setupUI {
    self.backgroundColor = [UIColor yellowColor];
    UIColor *normalColor = [UIColor cz_colorWithHex:0x282828];
    UIColor *selectedColor = [UIColor cz_colorWithHex:0x50B7F2];
    
    NSMutableArray<UIButton *> *arrayM = [NSMutableArray array];
    NSArray *names = @[@"资讯",@"商家",@"圈评"];
    for (NSString *title in names) {
        UIButton *btn = [UIButton cz_textButton:title fontSize:14 normalColor:normalColor selectedColor:selectedColor];
        [self addSubview:btn];
        [arrayM addObject:btn];
    }

    //2.自动布局三个按钮
    [arrayM[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
    }];
    [arrayM[1] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(arrayM[0].mas_right);
        make.size.top.equalTo(arrayM[0]);
    }];
    [arrayM[2] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(arrayM[1].mas_right);
        make.size.top.equalTo(arrayM[1]);
        make.right.equalTo(self);
    }];
    
    //3.添加线条视图
    UIView *vLine= [[UIView alloc]init];
    vLine.backgroundColor = [UIColor cz_colorWithHex:0x50B7F2];
    [self addSubview:vLine];
    
    //获取第0个按钮的
    UIButton *btn = arrayM[0];
    [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.equalTo(btn);
        make.bottom.equalTo(btn.mas_bottom).offset(1);
        make.height.mas_equalTo(4);
    }];
    
    NSInteger index = 0;
    for (UIButton *btn in arrayM) {
        [btn addTarget:self action:@selector(changeFunction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = index++;
    }

    _lineView = vLine;
    _buttons = arrayM;
    
    _buttons[0].enabled = YES;
    _selectIndex = 0;
    
}
#pragma mark-实现监听方法
- (void)changeFunction:(UIButton *)btn {
    
    if (btn.tag == _selectIndex) {
        return;
    }
    _buttons[_selectIndex].selected = NO;
    _selectIndex = btn.tag ;
    _buttons[_selectIndex].selected = YES;
    
    //根据按钮的tag修改线条视图的centerX约束
    [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_buttons[0]).offset(_selectIndex * btn.bounds.size.width);
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self layoutIfNeeded];
    }];
    //记录选中的索引
    _selectIndex = btn.tag;
    //点击跳转到相应的控制器
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
}
@end
