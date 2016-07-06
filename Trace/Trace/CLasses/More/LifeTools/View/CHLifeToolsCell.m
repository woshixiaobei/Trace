//
//  CHLifeToolsCell.m
//  CircleLifeApp
//
//  Created by CrazyHacker on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CHLifeToolsCell.h"
#import "CHLifeToolsMdoel.h"

@interface CHLifeToolsCell()
@property (weak, nonatomic) UIImageView *btn;
@property (weak, nonatomic) UILabel *title;

@end

@implementation CHLifeToolsCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self setupUI];
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 监听方法
- (void)showDetailService:(UIButton *)sender {
    NSLog(@"点击了--> %@",sender);
}

#pragma mark - 设置数据
- (void)setModel:(CHLifeToolsMdoel *)model {
    _model = model;
    [_btn sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    
    _title.text = model.title;
}

- (void)setupUI {
    // 图像
    UIImageView *btn = [[UIImageView alloc] init];
    [self.contentView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(20);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];

    
    // title
    UILabel *title = [UILabel cz_labelWithText:@"生活服务" fontSize:14 color:[UIColor cz_colorWithHex:0x282828]];
    [title sizeToFit];
    [self.contentView addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_bottom).offset(4);
        make.centerX.equalTo(self.contentView);
        
    }];
    _btn = btn;
    _title = title;
}


@end
