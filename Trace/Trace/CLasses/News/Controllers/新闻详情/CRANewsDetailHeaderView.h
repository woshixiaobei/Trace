//
//  CRANewsDetailHeaderView.h
//  News
//
//  Created by 杨应海 on 16/6/22.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CRANewsTimeModel;

@interface CRANewsDetailHeaderView : UIView

@property (nonatomic, strong) CRANewsTimeModel *model;

// 定义一个字典属性，用于保存用户输入的评论信息，然后发送给详情控制器，保存到数组中，再刷新评论表格
@property (nonatomic, strong) NSDictionary *remarkDcit;


@end
