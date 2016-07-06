//
//  CRAHeaderView.h
//  Trace
//
//  Created by 小贝 on 16/6/20.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRAHeaderView : UIControl
/**
 *  选中标签索引  
 */
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, assign) CGFloat offsetX;
@property (nonatomic, weak) UIView *lineView;
 
@end
