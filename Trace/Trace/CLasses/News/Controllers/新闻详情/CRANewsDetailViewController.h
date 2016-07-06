//
//  CRANewsDetailViewController.h
//  News
//
//  Created by 杨应海 on 16/6/22.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CRANewsTimeModel;

@interface CRANewsDetailViewController : UIViewController

/**
 *  头部视图模型数据,从上一级控制传递过来的, 直接给表格顶部视图
 */
@property (nonatomic, strong) CRANewsTimeModel *topModel;;

/**
 *  底部视图模型数据，从上一级控制传递过来的，直接给表格底部视图
 */
@property (nonatomic, strong) NSMutableArray <CRANewsTimeModel *> *bottomModels;


@end
