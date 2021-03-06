//
//  UIImageView+CRAWebImage.h
//  News
//
//  Created by 杨应海 on 16/6/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *   封装 UIImageView+WebCache
 */
@interface UIImageView (CRAWebImage)

- (void)cra_setImageWithURLString:(NSString *)urlString;

@end
