//
//  CRASelectedItemHotelModel.h
//  Trace
//
//  Created by 小贝 on 16/6/23.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRASelectedItemHotelModel : NSObject

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) CGFloat level;
@property (nonatomic, assign) CGFloat distance;

@end
