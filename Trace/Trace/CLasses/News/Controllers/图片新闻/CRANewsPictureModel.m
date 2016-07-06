//
//  CRANewsPictureModel.m
//  News
//
//  Created by 杨应海 on 16/6/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRANewsPictureModel.h"

@implementation CRANewsPictureModel



+ (void)newsWithPictureURLString:(NSString *)urlString channel:(NSString *)channel completionHandle:(void (^)(NSArray *))complete {
    
    CRAHTTPSessionManager *manager = [CRAHTTPSessionManager sharedManager];
    
    [manager loadDataWithURLString:urlString completionHandler:^(id datas) {
       
        NSDictionary *dictArray = (NSDictionary *)datas;
        
        NSArray *array = dictArray[channel];
        
        // 字典转模型
        NSArray *arrayModel = [NSArray yy_modelArrayWithClass:[CRANewsPictureModel class] json:array];
        
        // 完成回调
        if (complete) {
            complete(arrayModel);
        }
    }];
}



- (NSString *)description {
    return [self yy_modelDescription];
}

@end
