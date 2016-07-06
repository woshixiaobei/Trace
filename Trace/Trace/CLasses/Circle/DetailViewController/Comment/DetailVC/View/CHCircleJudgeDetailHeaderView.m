//
//  CHCircleJudgeDetailHeaderView.m
//  CircleLifeApp
//
//  Created by CrazyHacker on 16/6/22.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CHCircleJudgeDetailHeaderView.h"

@interface CHCircleJudgeDetailHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *titile;
@property (weak, nonatomic) IBOutlet UILabel *checkLabel;
@property (weak, nonatomic) IBOutlet UILabel *judgeLabel;


@property (weak, nonatomic) IBOutlet UILabel *answerContent;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation CHCircleJudgeDetailHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    [_judgeContentTextView becomeFirstResponder];
    _checkLabel.text = [NSString stringWithFormat:@"查看:%zd",arc4random_uniform(1000) + 100];
    _judgeLabel.text = [NSString stringWithFormat:@"评价:%zd",arc4random_uniform(1000) + 100];
    NSArray *arr = @[@"夏天不下雨吓我,嗯哼!",@"还有什么比原始森林更让人心情舒畅？",@"全球开发者大会,会有哪些看点？"];
    _titile.text = [NSString stringWithFormat:@"%@",arr[arc4random_uniform(2)]];
    NSArray *arr1 = @[@"白昼已快尽了，最后的大海只剩下一枚落日。 虽然它的光明将让你永远辉煌明亮，永远存在心间让我度过即将到来的黑夜的漫长，但它的沉落，那低沉的胡茄的悲鸣声，让我承受不了血浸的黄昏。 大海的哭诉，肝肠寸断，你听见了吗？ 而太阳正言厉色，抛下我们，拂袖而去。!",@"天气似乎在你的上空转晴，你的目光从海面上升，穿透薄雾，接近每一颗星。 星星的闪烁能说明些什么，正如海的脉搏此时的激荡，让你欣喜，却又让你空茫。  你在渐渐走近，向着一颗星。当你放下桅杆，在平静的海面自由飘摇而歌唱时，你寻找到的正是你的停泊之处。",@"你体验一种召唤的力量，就像你的船在体验一种方向和流动。在你清婉明丽的歌声中，不停荡漾在海面的可不是无比的赞美和歌颂，无比的幸福和喜悦？"];
    _answerContent.text = [NSString stringWithFormat:@"%@",arr1[arc4random_uniform(2)]];
    _isUpLoadJudgement = NO;
    _isShowSharedView = NO;
}

/**
 *  分享按钮操作
 */
- (IBAction)sharedAction:(UIButton *)sender {
 
    if (sender.tag == 10) {
        _isShowSharedView = YES;
    } else {
        _isUpLoadJudgement = YES;
        [_judgeContentTextView endEditing:YES];
    }

    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

+ (instancetype)headerView {
    UINib *nib = [UINib nibWithNibName:@"CHCircleJudgeDetailHeaderView" bundle:nil];
    return [nib instantiateWithOwner:nil options:nil].lastObject;
}
@end
