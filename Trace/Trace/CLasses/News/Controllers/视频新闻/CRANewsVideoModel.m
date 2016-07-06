//
//  CRANewsVideoModel.m
//  News
//
//  Created by 杨应海 on 16/6/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRANewsVideoModel.h"
#import "CRAHTTPSessionManager.h"

@implementation CRANewsVideoModel


+ (void)newsWithVideoURLString:(NSString *)urlString channel:(NSString *)channel completationHandle:(void (^)(NSArray *))completion {
    
    
    CRAHTTPSessionManager *manager =[CRAHTTPSessionManager sharedManager];
    
    [manager loadDataWithURLString:urlString completionHandler:^(id datas) {
       
        NSDictionary *dict = (NSDictionary *)datas;
        
        NSArray *dictArray = dict[channel];
        
        // 字典转模型
        NSArray *array = [NSArray yy_modelArrayWithClass:[CRANewsVideoModel class] json:dictArray];
        
        // 完成回调模型数组
        completion(array);
    }];
    
}

@end
