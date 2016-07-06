//
//  CRAHTTPSessionManager.m
//  News
//
//  Created by 杨应海 on 16/6/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRAHTTPSessionManager.h"

@implementation CRAHTTPSessionManager

/**
 *  创建单例
 */
+ (instancetype)sharedManager {
    
    static CRAHTTPSessionManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //1. 通过baseURL 创建单例
        //instance = [[CRAHTTPSessionManager alloc] initWithBaseURL:baseURL];
        
        //2. 直接创建,外面使用 完整的 url
        instance = [[CRAHTTPSessionManager alloc] init];
        
        // 设置请求数据接收的类型  注意 区别 AFHTTPRequestSerializer
        instance.requestSerializer = [[AFJSONRequestSerializer alloc] init];
      
        instance.responseSerializer.acceptableContentTypes = [instance.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html" ];
        
    });
    return instance;
}
/**
 *  提供给外界，使用 url加载数据，通过回调传值
 */

- (void)loadDataWithURLString:(NSString *)urlString completionHandler:(void (^)(id))completion {
    
    // 调用加载的时候的弹窗
    [self pushHUDWhenLoad];
    
    [self GET:urlString
   parameters:nil
     progress:nil
      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
          //数据请求完毕，回调block
          if (completion) {
              completion(responseObject);
          }
          
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@"%@", [error localizedDescription]);
          
          // 调用失败弹窗
          [self pushHUDWhenFailure];
          
      }];
}

/**
 *  重写 AFN 的post 方法，在请求时弹出 HUD 提醒
 */

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
    return [super POST:URLString parameters:parameters progress:uploadProgress success:success failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self pushHUDWhenFailure];
    }];


}
/**
 *  网络请求错误 HUD 窗口
 */
- (void)pushHUDWhenFailure {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:keyWindow.rootViewController.view];
    // 加入视图
    [keyWindow.rootViewController.view addSubview:HUD];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //样式
        HUD.mode = MBProgressHUDModeText;
        //设置文字
        HUD.labelText = @"网络出错啦 %>_<%";
        // 动态展示
        [HUD show:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 变成 hidden时 移除
            [HUD removeFromSuperview];
        });
    });
}

/**
 *  网络正在请求的时候 HUD 弹窗
 */
- (void)pushHUDWhenLoad {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:keyWindow.rootViewController.view];
    
    // 加入视图
    [keyWindow.rootViewController.view addSubview:HUD];
    // 设置样式
    HUD.mode = MBProgressHUDModeText;
    // 设置文字
    HUD.labelText = @"努力加载中... 🐶🐶";
    // 动态展示
    [HUD show:YES];
    // 影藏不带动画
    [HUD hide:NO afterDelay:0.8];
    // 在变成 hidden时移除
    [HUD removeFromSuperview];
}

@end


















