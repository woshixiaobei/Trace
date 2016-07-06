//
//  CRAHomeTotalModel.h
//  Home完整版
//
//  Created by Arvin on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRAHomeTotalModel : NSObject

/**
 *  商铺名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  序号
 */
@property (nonatomic, assign) NSInteger id;

/**
 *  星级
 */
@property (nonatomic, assign) NSInteger score;

/**
 *  描述信息
 */
@property (nonatomic, copy) NSString *intro;

/**
 *  食品id
 */
@property (nonatomic, assign) NSInteger good_id;

/**
 *  商铺id
 */
@property (nonatomic, assign) NSInteger shop_id;

/**
 *  图片urlString
 */
@property (nonatomic, copy) NSString *cover;

@end
