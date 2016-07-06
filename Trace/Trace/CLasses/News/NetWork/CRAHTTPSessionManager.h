//
//  CRAHTTPSessionManager.h
//  News
//
//  Created by 杨应海 on 16/6/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface CRAHTTPSessionManager : AFHTTPSessionManager
/**
 *  创建单例
 */
+ (instancetype)sharedManager;


/**
 *  提供一个外界的 urlString，用力加载数据，通过回调传值
 */
- (void)loadDataWithURLString:(NSString *)urlString completionHandler:(void(^)(id datas)) completion;

@end
