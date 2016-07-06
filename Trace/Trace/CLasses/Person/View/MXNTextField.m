//
//  MXNTextField.m
//  ddddd
//
//  Created by Clark on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "MXNTextField.h"

@interface MXNTextField ()
@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation MXNTextField

+ (instancetype)addTextFieldWithPlaceHolder:(NSString *)str addImage:(UIImage *)image addColor:(UIColor *)color{
    
    MXNTextField *textField = [[self alloc] init];
    
    textField.placeholder = str;
    
    textField.textAlignment = NSTextAlignmentLeft;
    
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    textField.borderStyle = UITextBorderStyleRoundedRect;
    
    UIImageView *iconView = [[UIImageView alloc] initWithImage:image];
    
    textField.leftView = iconView;
    iconView.backgroundColor = color;
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    

    textField.backgroundColor = [UIColor cz_colorWithRed:11 green:181 blue:252];
    //colorWithRed:11/255.0 green:181/255.0 blue:252/255.0 alpha:1]
    
    
    [textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    
    return textField;
    
}

@end
