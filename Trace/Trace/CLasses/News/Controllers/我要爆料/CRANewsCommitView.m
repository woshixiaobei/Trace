//
//  CRANewsCommitView.m
//  News
//
//  Created by 杨应海 on 16/6/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRANewsCommitView.h"

#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define  SizeAuto(number)  kScreen_Width/320*(number)

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

@interface CRANewsCommitView()

@property (nonatomic) UIView       *contentView;
@property (nonatomic) UILabel      *contentLabel;
@property (nonatomic) UILabel      *TopLabel;
@property (nonatomic) UILabel      *BottomLabel;
@property (nonatomic) UIView       *lineView;
@property (nonatomic) UITextField  *contentTF;
@property (nonatomic) UIButton     *selectBtn;
@property (nonatomic) UIButton     *leftBtn;
@property (nonatomic) UIButton     *rightBtn;
@property (nonatomic, assign) UIViewController *viewController;

@end

@implementation CRANewsCommitView

- (instancetype)init {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self createView];
    }
    
    return self;
}

- (void)createView
{
    //背景
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 5;
    contentView.layer.masksToBounds = YES;
    [self addSubview:contentView];
    self.contentView = contentView;
    
    //标题
    
    UILabel *contentLabel = [UILabel cz_labelWithText:@"爆料成功喽" fontSize:14 color:[UIColor blackColor]];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    //线
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor blackColor];
    [contentView addSubview:lineView];
    self.lineView = lineView;
    
    UILabel *TopLabel = [UILabel cz_labelWithText:@"爆料成功了!" fontSize:8 color:[UIColor blackColor]];
    TopLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:TopLabel];
    self.TopLabel = TopLabel;
    
    UILabel *BottomLabel = [UILabel cz_labelWithText:@"我们会以最快的速度处理您的爆料" fontSize:14 color:[UIColor blackColor]];
    BottomLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:BottomLabel];
    self.BottomLabel = BottomLabel;
    
    //左按钮
    UIButton *leftButton = [UIButton cz_textButton:@"继续爆料" fontSize:14 normalColor:[UIColor blackColor] selectedColor:nil];
    leftButton.tag = 1001;
    leftButton.layer.cornerRadius = 3;
    leftButton.layer.masksToBounds = YES;
    leftButton.layer.borderWidth = 1;
    leftButton.layer.borderColor = [UIColor blackColor].CGColor;
    //    leftButton.backgroundColor = RGB(13, 96, 191);
    [leftButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:leftButton];
    self.leftBtn = leftButton;
    
    //右按钮
    UIButton *rightButton = [UIButton cz_textButton:@"返回新闻中心" fontSize:14 normalColor:[UIColor blackColor] selectedColor:nil];
    rightButton.tag = 1002;
    rightButton.layer.cornerRadius = 3;
    rightButton.layer.masksToBounds = YES;
    rightButton.layer.borderWidth = 1;
    rightButton.layer.borderColor = [UIColor blackColor].CGColor;
    //    rightButton.backgroundColor = RGB(13, 96, 191);
    [rightButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:rightButton];
    self.rightBtn = rightButton;
    
}

- (void)buttonAction:(UIButton *)sender
{
    [self dismiss];
    if (sender.tag == 1002) {
        if (self.selectedButtonClick) {
            self.selectedButtonClick();
        }
        
    }
}

- (void)layout
{
    CGFloat width = (self.frame.size.width-60);
    
    self.contentLabel.frame = CGRectMake(15, 10, width-30, SizeAuto(25));
    
    self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.contentLabel.frame)+5, width, 1);
    
    self.TopLabel.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame)+5, width, SizeAuto(25));
    
    self.BottomLabel.frame = CGRectMake(0, CGRectGetMaxY(self.TopLabel.frame)+5, width, SizeAuto(25));
    
    self.leftBtn.frame = CGRectMake(25, CGRectGetMaxY(self.BottomLabel.frame)+15, width*0.5-35, SizeAuto(25));
    self.rightBtn.frame = CGRectMake(width*0.5+10, CGRectGetMaxY(self.BottomLabel.frame)+15, width*0.5-35, SizeAuto(25));
    
    CGFloat height = CGRectGetMaxY(self.leftBtn.frame)+15;
    self.contentView.frame = CGRectMake(30, (self.frame.size.height-height)*0.5, width, height);
    
}

- (void)showInView:(UIView *)view
{
    self.frame = view.bounds;
    [self layout];
    [view addSubview:self];
    self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0];
    self.contentView.transform = CGAffineTransformMakeScale(.001, .001);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:.4];
        self.contentView.transform = CGAffineTransformMakeScale(1, 1);
        
    }];
    
}

- (void)dismiss
{
    [UIView animateWithDuration:.25 animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(.001, .001);
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}





@end






