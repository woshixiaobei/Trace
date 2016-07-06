//
//  CHPresentViewController.h
//  CircleLifeApp
//
//  Created by CrazyHacker on 16/6/22.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CHPresentViewController;

@protocol CHPresentViewControllerDelegate <NSObject>

/** 展现视图控制器的代理方法 
 *
 * 参数 可以根据参数的tag 确定相应的操作
 */
- (void)presentViewController:(CHPresentViewController *)vc withButton:(UIButton *)btn;

@end
@interface CHPresentViewController : UIViewController

@property (nonatomic, weak) id<CHPresentViewControllerDelegate > delegate;

@end
