//
//  CRACircleModel.h
//  Trace
//
//  Created by 小贝 on 16/6/19.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRACircleModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
+ (NSArray *)loadCircleModel;
@end
