//
//  CARCricleJudgeDetailCell.m
//  CircleLifeApp
//
//  Created by CrazyHacker on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CARCricleJudgeDetailCell.h"

/** 通知的key */
NSString *const kDidSelectedButtonToShowDetail = @"kDidSelectedButtonToShowDetail";
@interface CARCricleJudgeDetailCell()
/**
 *  问题
 */
@property (weak, nonatomic) IBOutlet UILabel *QuestionLabel;
/**
 *  问题发起时间
 */
@property (weak, nonatomic) IBOutlet UILabel *addTime;
/**
 *  用户回答
 */
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
/**
 *  查看
 */
@property (weak, nonatomic) IBOutlet UIButton *inspectButton;


@end

@implementation CARCricleJudgeDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.inspectButton addTarget:self action:@selector(clickInspectButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setIndex:(NSInteger)index {
    _index = index;
    self.inspectButton.tag = index;
}
- (void)clickInspectButton:(UIButton *)btn {
    NSLog(@"点击圈子详情查看按钮, %zd",btn.tag);
    // view -> vc
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidSelectedButtonToShowDetail object:btn];
}

@end
