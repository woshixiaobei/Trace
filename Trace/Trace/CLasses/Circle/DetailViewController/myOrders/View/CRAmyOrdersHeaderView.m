//
//  CRAmyOrdersHeaderView.m
//  Trace
//
//  Created by 小贝 on 16/6/22.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAmyOrdersHeaderView.h"

@interface CRAmyOrdersHeaderView()

@property (nonatomic, strong) NSArray<UIButton *> *buttons;

@end
@implementation CRAmyOrdersHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
#pragma mark-重写setter方法
- (void)setOrderedOffsetX:(CGFloat)orderedOffsetX {

    _orderedOffsetX = orderedOffsetX;
    
    NSInteger index = (orderedOffsetX / _buttons[0].bounds.size.width + 0.5);
    
    _buttons[_orderedSelectedIndex].selected = NO;
    _orderedSelectedIndex = index;
    _buttons[_orderedSelectedIndex].selected = YES;
    
}

#pragma mark-实现按钮的点击事件
- (void)changeItemOrderedAccount:(UIButton *)btn {
    
    if (btn.tag == _orderedSelectedIndex) {
        return;
    }
    _buttons[_orderedSelectedIndex].selected = NO;
    _orderedSelectedIndex = btn.tag ;
    _buttons[_orderedSelectedIndex].selected = YES;
    
    [UIView animateWithDuration:0.5 animations:^{
        [self layoutIfNeeded];
    }];

    _orderedSelectedIndex = btn.tag;

    [self sendActionsForControlEvents:UIControlEventValueChanged];

}
#pragma mrk-搭建界面
- (void)setupUI {

    NSMutableArray <UIButton *>*buttons = [NSMutableArray array];
    UIColor *normalColor = [UIColor cz_colorWithHex:0x282828];
    UIColor *selectedColor = [UIColor whiteColor];
    
    NSArray<NSString *> *names = @[@"未支付",@"已支付"];
    for (NSString *title in names) {
        UIButton *btn = [UIButton cz_textButton:title fontSize:17 normalColor:normalColor selectedColor:selectedColor];
        [self addSubview:btn];
        [buttons addObject:btn];
    }
    
    [buttons[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        make.height.equalTo(self);
    }];
    [buttons[1] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(buttons[0].mas_right);
        make.right.equalTo(self);
        make.size.equalTo(buttons[0]);
    }];

    NSInteger index = 0;
    for (UIButton *btn in buttons) {
        [btn addTarget:self action:@selector(changeItemOrderedAccount:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = index++;
    }

    //记录成员变量
    _buttons = buttons;
    _buttons[0].selected = YES;
    _orderedSelectedIndex = 0;
    
}


@end
