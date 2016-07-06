//
//  UIImageView+CRAWebImage.m
//  News
//
//  Created by 杨应海 on 16/6/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "UIImageView+CRAWebImage.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (CRAWebImage)

- (void)cra_setImageWithURLString:(NSString *)urlString {
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    if (url) {
        
        [self sd_setImageWithURL:url];
    }
}

@end
