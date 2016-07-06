//
//  CRAHomeViewController.h
//  Home完整版
//
//  Created by Arvin on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CRAHomeTotalModel;

@interface CRAHomeViewController : UIViewController

/**
 *  记录 tableView
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 *  Circle 模型数组
 */
@property (nonatomic, strong) NSArray <CRAHomeTotalModel *> *circleList;

/**
 *  Guess 模型数组
 */
@property (nonatomic, strong) NSArray <CRAHomeTotalModel *> *guessList;

/**
 *  Famous 模型数组
 */
@property (nonatomic, strong) NSArray <CRAHomeTotalModel *> *famousList;

/**
 *  图片轮播器模型数组
 */
@property (nonatomic, strong) NSArray <CRAHomeTotalModel *> *focusList;

@end
