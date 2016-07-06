//
//  CRACircleItemCell.m
//  Trace
//
//  Created by 小贝 on 16/6/19.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRACircleItemCell.h"
#import "CRACircleModel.h"

#define KSelectedTagOffset 100

@interface CRACircleItemCell()

@property (nonatomic, weak) UILabel *bottomLabel;
@property (nonatomic, weak) UIImageView *imageView;

@end
@implementation CRACircleItemCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
       
    }
    return self;
}

#pragma mark- 重写setter方法
- (void)setModel:(CRACircleModel *)model {
    _model = model;
    
    _bottomLabel.text = model.name;
    _imageView.image = [UIImage imageNamed:model.icon];

}

#pragma mark-搭建界面
- (void)setupUI {
    UIImageView *iv = [[UIImageView alloc]initWithFrame:self.bounds];
    iv.image = [UIImage imageNamed:@"茶艺圈"];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:iv];
    
    UILabel *bLabel = [UILabel cz_labelWithText:@"茶艺圈" fontSize:14 color:[UIColor cz_colorWithHex:0x282828]];
    bLabel.textAlignment = NSTextAlignmentCenter;
    bLabel.numberOfLines = 0;
    [self.contentView addSubview:bLabel];
    
    //自动布局
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(60);
    }];
    
    [bLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iv.mas_bottom).offset(20);
        make.left.right.equalTo(self.contentView);
    }];

    //记录成员变量
    _bottomLabel = bLabel;
    _imageView = iv;
}
@end
