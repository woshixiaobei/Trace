//
//  CRABusinessHeaderView.h
//  Trace
//
//  Created by 小贝 on 16/6/20.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CRABusinessHeaderViewDelegate <NSObject>

@optional
- (void)businessHeaderViewWillDisplayAreaListTableView;

@end
@interface CRABusinessHeaderView : UIControl

@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (nonatomic, weak) id <CRABusinessHeaderViewDelegate> delegate;
+ (instancetype)loadHeaderView;

@end
