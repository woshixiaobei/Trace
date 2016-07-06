//
//  CRANewRemarkModel.h
//  News
//
//  Created by 杨应海 on 16/6/22.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRANewRemarkModel : NSObject

/**
 *  用户名
 */
@property (nonatomic, copy) NSString *userName;
/**
 *  用户图像
 */
@property (nonatomic, copy) NSString *userIcon;
/**
 *  用户评论
 */
@property (nonatomic, copy) NSString *userRemark;

/**
 *  字典转模型的方法
 */
+ (instancetype)remarkModelWithDict:(NSDictionary *)dict;

@end
