//
//  MXNAlertView.h
//  ddddd
//
//  Created by Clark on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AlertViewType)
{
    AlertViewTypeCenter = 0,
    AlertViewTypeBottom = 1
};

@protocol ClickedActionProtocol <NSObject>
- (void)selectedCenterActionIndex:(NSInteger)index;
- (void)selectedBottomActionIndex:(NSInteger)index;
@end

@interface MXNAlertView : UIView
- (instancetype)initWithFrame:(CGRect)frame actions:(NSArray<NSString *> *)actionTitles type:(AlertViewType)type;
- (void)show;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, weak) id<ClickedActionProtocol> actionDelegate;
@end
