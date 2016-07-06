//
//  CRANewsVideoModel.h
//  News
//
//  Created by 杨应海 on 16/6/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRANewsVideoModel : NSObject

/**
 *  视频图片
 */
@property (nonatomic, copy) NSString *cover;
/**
 *  视频标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  来源头像
 */
@property (nonatomic, copy) NSString *topicImg;
/**
 *  来源昵称
 */
@property (nonatomic, copy) NSString *topicName;
/**
 *  来源时间
 */
@property (nonatomic, copy) NSString *ptime;
/**
 *  播放数量
 */
@property (nonatomic, assign) NSInteger playCount;

/**
 *  mp4 地址
 */
@property (nonatomic, copy) NSString *mp4_url;


/**
 *  类方法，回传一个数组模型
 */
+ (void)newsWithVideoURLString:(NSString *)urlString channel:(NSString *)channel completationHandle:(void(^)(NSArray *array))completion;



@end




