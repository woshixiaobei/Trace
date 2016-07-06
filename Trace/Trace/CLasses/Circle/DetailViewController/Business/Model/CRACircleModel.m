//
//  CRACircleModel.m
//  Trace
//
//  Created by 小贝 on 16/6/19.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRACircleModel.h"

@implementation CRACircleModel

+ (NSArray *)loadCircleModel {

    NSURL *url = [[NSBundle mainBundle]URLForResource:@"CRACircleItem.plist" withExtension:nil];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        CRACircleModel *model = [CRACircleModel new];
        [model setValuesForKeysWithDictionary:dict];
        [arrayM addObject:model];
    }
    return arrayM.copy;
}
@end
