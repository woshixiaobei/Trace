//
//  CRANewsKeyModel.h
//  News
//
//  Created by 杨应海 on 16/6/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  新闻首页下面tableView的模型
 */

@interface CRANewsKeyModel : NSObject

/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  图片
 */
@property (nonatomic, copy) NSString *imgsrc;
/**
 *  内容
 */
@property (nonatomic, copy) NSString *digest;
/**
 *  时间
 */
@property (nonatomic, copy) NSString *ptime;


+ (void)newsWithURLString:(NSString *)urlString completionHandle:(void(^)(NSArray *))completion;

@end







