//
//  CRABusinessHeaderView.m
//  Trace
//
//  Created by 小贝 on 16/6/20.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRABusinessHeaderView.h"

//选中的按钮通知
NSString *const CRABusinessAreaListSelectedNotification = @"CRABusinessAreaListSelectedNotification";
//取消的按钮通知
NSString *const CRABusinessAreaListDeselectedNotification = @"CRABusinessAreaListDeselectedNotification";

@interface CRABusinessHeaderView()

@property (weak, nonatomic) IBOutlet UIButton *listCity;

@property (weak, nonatomic) IBOutlet UITextField *contentFiled;

@end
@implementation CRABusinessHeaderView

#pragma mark-加载XIB的View视图
+ (instancetype)loadHeaderView {
    UINib *nib = [UINib nibWithNibName:@"CRABusinessHeaderView" bundle:nil];
    return [nib instantiateWithOwner:nil options:nil].lastObject;

}

#pragma mark-点击下拉表格
- (IBAction)changeCity:(UIButton *)sender {
   
    if ([_delegate respondsToSelector:@selector(businessHeaderViewWillDisplayAreaListTableView)]) {
        [_delegate businessHeaderViewWillDisplayAreaListTableView];
    }
        
}

#pragma mark-点击搜索
- (IBAction)search:(id)sender {
    if ([_contentFiled.text isEqualToString:@"奶油小方"]) {
        
       // NSLog(@"点击了搜索按钮");
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
        
    }else {
        NSLog(@"没有这个酒店哟~");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"亲，没有该食品，请选择别的食品哦！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    
}

@end
