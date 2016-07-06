//
//  CRANewsDetailFooterView.m
//  News
//
//  Created by 杨应海 on 16/6/22.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRANewsDetailFooterView.h"
#import "CRANewsTimeModel.h"

/**
 *  点击按钮显示更多评论的通知
 */
NSString *const kDidClickButtonShowMoreRemarkNotification = @"kDidClickButtonShowMoreRemarkNotification";

@interface CRANewsDetailFooterView()

@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UILabel *firstTitle;

@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UILabel *secondTitle;


@property (weak, nonatomic) IBOutlet UIImageView *thridImageView;
@property (weak, nonatomic) IBOutlet UILabel *thridTitle;

@property (weak, nonatomic) IBOutlet UIImageView *forthImageView;
@property (weak, nonatomic) IBOutlet UILabel *forthTitle;


@end

@implementation CRANewsDetailFooterView


- (void)setFooterModels:(NSArray<CRANewsTimeModel *> *)footerModels {
    _footerModels = footerModels;
    
    _firstTitle.text = _footerModels[0].title;
    [_firstImageView cra_setImageWithURLString:_footerModels[0].imgsrc];
    
    _secondTitle.text = _footerModels[1].title;
    [_secondImageView cra_setImageWithURLString:_footerModels[1].imgsrc];
    
    _thridTitle.text = _footerModels[2].title;
    [_thridImageView cra_setImageWithURLString:_footerModels[2].imgsrc];
    
    _forthTitle.text = _footerModels[3].title;
    [_forthImageView cra_setImageWithURLString:_footerModels[3].imgsrc];
    
}




/**
 *  点击按钮 添加更多评论
 */
- (IBAction)addMoreRemark:(UIButton *)sender {
    
    // 给控制器 发送一个通知，控制器注册通知时可以添加监听方法，在监听方法里面就可以实现想要的功能
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidClickButtonShowMoreRemarkNotification object:nil userInfo:nil];
    
}


@end







