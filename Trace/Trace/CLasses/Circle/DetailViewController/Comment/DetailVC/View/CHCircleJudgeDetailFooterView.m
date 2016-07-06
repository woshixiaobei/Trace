//
//  CHCircleJudgeDetailFooterView.m
//  CircleLifeApp
//
//  Created by CrazyHacker on 16/6/23.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CHCircleJudgeDetailFooterView.h"

@implementation CHCircleJudgeDetailFooterView

+ (instancetype)footerView {
    UINib *nib = [UINib nibWithNibName:@"CHCircleJudgeDetailFooterView" bundle:nil];
    
    CHCircleJudgeDetailFooterView *view = [nib instantiateWithOwner:nil options:nil].lastObject;
    
    view.layer.borderWidth = 0.3;
    view.layer.borderColor = [UIColor darkGrayColor].CGColor;
    view.backgroundColor = [UIColor cyanColor];
    
    return view;
    
}

- (IBAction)ShowMoreJudgement:(UIButton *)sender {
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
