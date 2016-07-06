//
//  CRANewsCommitView.h
//  News
//
//  Created by 杨应海 on 16/6/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRANewsCommitView : UIView

- (void)showInView:(UIView *)view;

@property (nonatomic, copy) void(^selectedButtonClick)()
;

@end
