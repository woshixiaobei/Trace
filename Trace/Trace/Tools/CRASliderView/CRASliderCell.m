//
//  CRASliderCell.m
//  Home完整版
//
//  Created by Arvin on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRASliderCell.h"
#import "UIImageView+WebCache.h"


@interface CRASliderCell ()
/**
 *  新闻图片视图
 */
@property (nonatomic ,weak) UIImageView *imageView;

@end

@implementation CRASliderCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 设置数据

- (void)setUrlString:(NSString *)urlString {
    _urlString = urlString;
    
    NSURL *url =[NSURL URLWithString:urlString];
    [_imageView sd_setImageWithURL:url];
}

#pragma mark - 设置界面

- (void)setupUI {
    
    UIImage *image = [UIImage imageNamed:@"HomeSupport图片新闻"];
    
    UIImageView *iv = [[UIImageView alloc]initWithImage:image];
    
    [self.contentView addSubview:iv];
    
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    // 记录控件
    _imageView = iv;
}

@end
