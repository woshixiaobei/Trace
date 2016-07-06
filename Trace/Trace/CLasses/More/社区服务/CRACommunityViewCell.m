//
//  CRACommunityViewCell.m
//  Trace
//
//  Created by 张玺科 on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRACommunityViewCell.h"
#import "CRAMoreModel.h"

@interface CRACommunityViewCell()

@property (nonatomic, weak) UIButton *button;

@end

@implementation CRACommunityViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark-搭建界面
- (void)setupUI {
    
    UIButton *button = [[UIButton alloc]initWithFrame:self.bounds];
    UIImage *image = [UIImage imageNamed:@"茶艺圈"];
    NSAttributedString *attr = [NSAttributedString cz_imageTextWithImage:image imageWH:60 title:@"茶艺圈" fontSize:14 titleColor:[UIColor cz_colorWithHex:0x282828] spacing:8];
    [button setAttributedTitle:attr forState:UIControlStateNormal];
    
    [button sizeToFit];
    button.frame = self.bounds;
    
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.numberOfLines = 0;
    [self addSubview:button];
    
    _button = button;
}

- (void)setModel:(CRAMoreModel *)model {
    UIImage *image = [UIImage imageNamed:model.img];
    NSAttributedString *attr = [NSAttributedString cz_imageTextWithImage:image imageWH:60 title:model.title fontSize:14 titleColor:[UIColor cz_colorWithHex:0x282828] spacing:8];
    [_button setAttributedTitle:attr forState:UIControlStateNormal];
    
    [_button sizeToFit];
    _button.frame = self.bounds;
    
    _button.titleLabel.textAlignment = NSTextAlignmentCenter;
    _button.titleLabel.numberOfLines = 0;
    
}
@end
