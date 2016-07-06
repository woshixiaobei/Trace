//
//  CHCircleJudgeDetailHeaderView.h
//  CircleLifeApp
//
//  Created by CrazyHacker on 16/6/22.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHCircleJudgeDetailHeaderView : UIControl
/**
 *  是否展现分享视图
 */
@property (nonatomic, assign) BOOL isShowSharedView;
/**
 *  是否发表评论
 */
@property (nonatomic, assign) BOOL isUpLoadJudgement;
/**
 *  评论文本视图
 */
@property (weak, nonatomic) IBOutlet UITextView *judgeContentTextView;
+ (instancetype)headerView;
@end
