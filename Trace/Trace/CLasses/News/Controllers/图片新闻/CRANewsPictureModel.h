//
//  CRANewsPictureModel.h
//  News
//
//  Created by 杨应海 on 16/6/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRANewsPictureModel : NSObject

/**
 *  图片链接
 */
@property (nonatomic, copy) NSString *imgsrc;

/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  内容
 */
@property (nonatomic, copy) NSString *digest;
/**
 *  投票数量
 */
@property (nonatomic, assign) NSInteger votecount;
/**
 *  评论数量
 */
@property (nonatomic, assign) NSInteger replyCount;
/**
 *  下级控制器内容 链接
 */
@property (nonatomic, copy) NSString *url_3w;


/**
 *  定义一个接口，得到字典转模型完成之后的数组
 */

+ (void)newsWithPictureURLString:(NSString *)urlString channel:(NSString *)channel completionHandle:(void(^)(NSArray *datas))complete;

@end







