//
//  CRAHomeFamousTableViewCell.h
//  Home完整版
//
//  Created by Arvin on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CRAHomeTotalModel;

@interface CRAHomeFamousTableViewCell : UITableViewCell

/**
 *  名家推荐数组
 */
@property (nonatomic, strong) NSArray <CRAHomeTotalModel *> *famousModelList;

@end
