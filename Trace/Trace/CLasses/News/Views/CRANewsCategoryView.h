//
//  CRANewsCategoryView.h
//  News
//
//  Created by 杨应海 on 16/6/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRANewsCategoryView : UIControl

// 选中新闻分类的索引，回传给主控制器，然后 push 新控制器- 根据索引传递数据
@property (nonatomic, assign) NSInteger selectedIndex;



@end
