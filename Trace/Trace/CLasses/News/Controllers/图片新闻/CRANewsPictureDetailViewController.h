//
//  CRANewsPictureDetailViewController.h
//  News
//
//  Created by 杨应海 on 16/6/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CRANewsPictureModel;

@interface CRANewsPictureDetailViewController : UIViewController

/**
 *  详情控制器的数据模型，上一级控制器在跳转之前通过属性传递过来
 */
@property (nonatomic, strong) CRANewsPictureModel *model;

@end
