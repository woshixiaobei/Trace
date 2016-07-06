//
//  CRANewsTimeModel.m
//  News
//
//  Created by 杨应海 on 16/6/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRANewsTimeModel.h"

@implementation CRANewsTimeModel

+ (void)newsWithTimeURLString:(NSString *)urlString channel:(NSString *)channel completionHandle:(completion)complete {
    
    CRAHTTPSessionManager *manager = [CRAHTTPSessionManager sharedManager];
    
    [manager loadDataWithURLString:urlString completionHandler:^(id datas) {
       
        NSDictionary *dict = (NSDictionary *)datas;
        
        NSString *key = dict.allKeys.lastObject;
        NSArray *array = dict[key];
        // 字典转模型
        
        NSArray *modelArray = [NSArray yy_modelArrayWithClass:[CRANewsTimeModel class] json:array];
        
        // 回传给主控制器
        
        if (complete) {
            
            complete(modelArray);
        }
        
    }];
}

- (NSString *)description {
    return [self yy_modelDescription];
}

@end
