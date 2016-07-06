//
//  CRATabBar.h
//  Trace
//
//  Created by 张玺科 on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tabBarBlock) ();

@protocol CRATabBarDelegate <NSObject>


@end

@interface CRATabBar : UITabBar

@property (nonatomic,weak)id <CRATabBarDelegate>delegat;

@property(nonatomic,copy)tabBarBlock tabBarBlock;

@end
