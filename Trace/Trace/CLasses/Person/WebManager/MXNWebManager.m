 //
//  MXNWebManager.m
//  ddddd
//
//  Created by Clark on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "MXNWebManager.h"
static MXNWebManager *_instance;
@implementation MXNWebManager

+ (instancetype) defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@"http://iosapi.itcast.cn/life/"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _instance = [[self alloc] initWithBaseURL: url sessionConfiguration: config];
        _instance.requestSerializer = [[AFJSONRequestSerializer alloc]init];
        _instance.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return _instance;
}
- (void) webDataWithURLString: (NSString *) url andParameters: (NSDictionary *) dictionary  completionHandler: (CompletionHandler) handler {
    
    [self POST: url parameters: dictionary progress: nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (handler) {
            handler(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"MKWebManager Failed: %@ \n", [error localizedDescription]);
    }];
}

@end
