//
//  CRAMoreModel.m
//  Trace
//
//  Created by 张玺科 on 16/6/22.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAMoreModel.h"

@implementation CRAMoreModel
+ (NSArray *)loadMoreModel {
    
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"service.plist" withExtension:nil];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        CRAMoreModel *model = [CRAMoreModel new];
        [model setValuesForKeysWithDictionary:dict];
        [arrayM addObject:model];
    }
    return arrayM.copy;
}

- (NSString *)description {
    return [self yy_modelDescription];
}
@end
