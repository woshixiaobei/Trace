//
//  CRANewsKeyModel.m
//  News
//
//  Created by 杨应海 on 16/6/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRANewsKeyModel.h"

@implementation CRANewsKeyModel


+ (void)newsWithURLString:(NSString *)urlString completionHandle:(void (^)(NSArray *))completion {
    
    CRAHTTPSessionManager *manager = [CRAHTTPSessionManager sharedManager];
    
    [manager loadDataWithURLString:urlString completionHandler:^(id datas) {
       
        NSDictionary *dictArray = (NSDictionary *)datas;
        
//        NSArray *array = dictArray[@"T1348649079062"];
        
        NSString *key = dictArray.allKeys.lastObject;
        NSArray *array = dictArray[key];
        
        // 字典转模型
        NSArray *modelArray = [NSArray yy_modelArrayWithClass:[CRANewsKeyModel class] json:array];
        
        
        // 回传模型数组
        if (completion) {
            completion(modelArray);
        }
        
    }];
}

- (NSString *)description {
    
    return [self yy_modelDescription];
}


@end






