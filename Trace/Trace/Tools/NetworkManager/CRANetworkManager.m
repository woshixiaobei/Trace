//
//  CRANetworkManager.m
//  Trace
//
//  Created by Arvin on 16/6/23.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRANetworkManager.h"

@implementation CRANetworkManager
#pragma mark - 通用接口
+ (instancetype)sharedManager {
    
    static CRANetworkManager *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *baseUrl = [NSURL URLWithString:@"http://iosapi.itcast.cn/life/"];
        
        instance = [[self alloc]initWithBaseURL:baseUrl];
        
        instance.requestSerializer=[AFJSONRequestSerializer serializer];
        instance.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    
    return instance;
}

- (void)POSTRequest:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(void(^)(id json,NSError *error))completion {
    
    [self POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dict =[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //NSLog(@"请求成功 %@",dict);
        completion(dict,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败 %@",error);
        completion(nil,error);
    }];
}

- (void)dataListWithType:(NSString *)type parameters:(NSDictionary *)parameters completion:(void(^)(NSDictionary *,NSError *))completion {
    
    NSString *urlString = [NSString stringWithFormat:@"%@.json.php",type];
    
    [self POSTRequest:urlString parameters:parameters completion:^(NSDictionary *json, NSError *error) {
        
        //NSLog(@"====> %@",json);
        completion(json,error);
    }];
}


#pragma mark - -----------
- (void)imageWithUrlString:(NSString *)urlstring Completion:(void (^)(UIImage *, NSError *))completion{
    
    NSURL *url = [NSURL URLWithString:urlstring];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error != nil) {
            return ;
        }
        
        UIImage *image = [[UIImage alloc]initWithData:data];
        dispatch_sync(dispatch_get_main_queue(), ^{
            completion(image,nil);
        });
        
    }] resume];
}

+ (instancetype)sharedNewsManager {
    
    static CRANetworkManager *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 末尾要有反斜线
        NSURL *baseURL = [NSURL URLWithString:@"http://c.m.163.com/nc/article/"];
        
        instance = [[self alloc] initWithBaseURL:baseURL];
        
        // 设置相应的解析格式
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    
    return instance;
}
- (void)GETRequest:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(void (^)(id json, NSError *error))completion {
    
    [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"网络请求失败 %@", error);
        
        completion(nil, error);
    }];
}

#pragma mark - 网易新闻接口
- (void)newsListWithChannel:(NSString *)channel start:(NSInteger)start completion:(void (^)(NSArray *, NSError *))completion {
    
    NSString *urlString = [NSString stringWithFormat:@"list/%@/%zd-20.html", channel, start];
    
    [self GETRequest:urlString parameters:nil completion:^(id json, NSError *error) {
        
        // 使用频道作为 key 获取数组
        NSArray *array = json[channel];
        
        completion(array, error);
    }];
}

- (void)newsDetailWithDocId:(NSString *)docId completion:(void (^)(NSDictionary *, NSError *))completion {
    
    NSString *urlString = [NSString stringWithFormat:@"%@/full.html", docId];
    
    [self GETRequest:urlString parameters:nil completion:^(id json, NSError *error) {
        
        // NSLog(@"%@", json);
        // 完成回调
        completion(json[docId], error);
    }];
}

@end
