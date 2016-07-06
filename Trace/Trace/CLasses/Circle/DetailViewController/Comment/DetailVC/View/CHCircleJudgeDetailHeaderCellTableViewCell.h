//
//  CHCircleJudgeDetailHeaderCellTableViewCell.h
//  CircleLifeApp
//
//  Created by CrazyHacker on 16/6/22.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHCircleJudgeDetailHeaderCellTableViewCell : UITableViewCell
/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
/**
 *  发表时间
 */
@property (weak, nonatomic) IBOutlet UILabel *uploadTimeLabel;
/**
 *  评论内容
 */
@property (weak, nonatomic) IBOutlet UILabel *judgementContent;

@property (nonatomic, strong) NSArray *judgementCount;

@property (nonatomic, assign) NSInteger index;
@end
