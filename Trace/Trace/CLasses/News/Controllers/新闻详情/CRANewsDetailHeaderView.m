//
//  CRANewsDetailHeaderView.m
//  News
//
//  Created by 杨应海 on 16/6/22.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRANewsDetailHeaderView.h"
#import "CRANewsTimeModel.h"

/**
 *  通知名称
 */
NSString *const  kDidClickButtonSaveRemarkAndShowRemarkNotification = @"kDidClickButtonSaveRemarkAndShowRemarkNotification";

@interface CRANewsDetailHeaderView()

/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/**
 *  内容详情
 */
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
/**
 *  自己写入的 评论内容
 */
@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;

@property (weak, nonatomic) IBOutlet UILabel *remarkButtom;
@property (weak, nonatomic) IBOutlet UIButton *shareButtom;
@property (weak, nonatomic) IBOutlet UIButton *publicButtom;

@end

@implementation CRANewsDetailHeaderView

#pragma mark - 设置数据
- (void)setModel:(CRANewsTimeModel *)model {
    _model = model;
    
    _titleLabel.text = model.title;
    _timeLabel.text = model.ptime;
    _detailLabel.text = model.digest;
}


#pragma mark - 布局
- (void)layoutSubviews {
    // 设置 评论 Label， 分享buttom, 发表bottom 颜色
    _remarkButtom.backgroundColor = [UIColor cz_colorWithRed:46 green:161 blue:247];
    _shareButtom.backgroundColor = [UIColor cz_colorWithRed:46 green:161 blue:247];
    _publicButtom.backgroundColor = [UIColor cz_colorWithRed:46 green:161 blue:247];
    
    // 设置评论内容 textView 的属性
    _remarkTextView.layer.borderColor = [UIColor cz_colorWithRed:232 green:234 blue:235].CGColor;
    _remarkTextView.layer.borderWidth = 1.0;
    _remarkTextView.layer.cornerRadius = 5;
    _remarkTextView.layer.masksToBounds = YES;
    
}

/**
 *  分享按钮
 */
- (IBAction)shareButton:(UIButton *)sender {
    
    
    
    
}

/**
 *  发表评论按钮
 */
- (IBAction)publishButton:(UIButton *)sender {
    
    NSString *content = _remarkTextView.text;
    
    
    if (content.length) {
        
        _remarkDcit = @{
                        @"userName" : @"X*****O",
                        @"userIcon" : @"newsImage01",
                        @"userRemark" : content
                        };
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kDidClickButtonSaveRemarkAndShowRemarkNotification object:self userInfo:_remarkDcit];
        
        // 结束编辑
        [self endEditing:YES];
    }
    
    // 清空输入的内容
    _remarkTextView.text = nil;
}

@end









