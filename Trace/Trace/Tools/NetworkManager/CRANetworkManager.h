//
//  CRANetworkManager.h
//  Trace
//
//  Created by Arvin on 16/6/23.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface CRANetworkManager : AFHTTPSessionManager

/**
 *  全局访问点
 */
+ (instancetype)sharedManager;
+ (instancetype)sharedNewsManager;

- (void)dataListWithType:(NSString *)type parameters:(NSDictionary *)parameters completion:(void(^)(NSDictionary *,NSError *))completion;

//- (void)dataListWithCompletion:(void(^)(NSDictionary *,NSError *))completion;

- (void)imageWithUrlString:(NSString *)urlstring Completion:(void(^)(UIImage *image,NSError *error))completion;

/**
 * 加载新闻列表
 *
 * @param channel    频道字符串
 * @param start      开始数字
 * @param completion 完成回调[字典数组／错误]
 */
- (void)newsListWithChannel:(NSString *)channel start:(NSInteger)start completion:(void (^)(NSArray *array, NSError *error))completion;

/**
 * 使用 docId 加载新闻明细
 *
 * @param docId      文档编号
 * @param completion 完成回调[字典/错误]
 */
- (void)newsDetailWithDocId:(NSString *)docId completion:(void (^)(NSDictionary *dict, NSError *error))completion;
@end
