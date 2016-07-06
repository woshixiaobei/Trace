//
//  CRAMoreModel.h
//  Trace
//
//  Created by 张玺科 on 16/6/22.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRAMoreModel : NSObject
@property (nonatomic, copy)NSString *title;

@property (nonatomic, copy)NSString *img;

+ (NSArray *)loadMoreModel;
@end
