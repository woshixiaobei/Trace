//
//  CRANewsTimeModel.h
//  News
//
//  Created by 杨应海 on 16/6/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^completion)(NSArray *);
//typedef void(^completion)(NSArray *array);

@interface CRANewsTimeModel : NSObject
/**
 *  新闻发布时间
 */
@property(nonatomic,copy) NSString *ptime;
/**
 *   新闻标题
 */
@property(nonatomic,copy) NSString *title;
/**
 *  新闻描述
 */
@property(nonatomic,copy) NSString *digest;
/**
 *  新闻图片连接
 */
@property(nonatomic,copy) NSString *imgsrc;

/**
 *  回传模型数组给控制器
 */

+ (void)newsWithTimeURLString:(NSString *)urlString channel:(NSString *)channel completionHandle:(completion)complete;

@end
