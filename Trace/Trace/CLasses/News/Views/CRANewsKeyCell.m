//
//  CRANewsKeyCell.m
//  Trace
//
//  Created by 杨应海 on 16/6/18.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRANewsKeyCell.h"
#import "CRANewsKeyModel.h"

@interface CRANewsKeyCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation CRANewsKeyCell




// 重写 setter 方法 设置内容
- (void)setNewsKeyModel:(CRANewsKeyModel *)newsKeyModel {
    
    _newsKeyModel = newsKeyModel;
    
    _timeLabel.text = newsKeyModel.ptime;
    _titleView.text = newsKeyModel.title;
    _detailLabel.text = newsKeyModel.digest;
    
    [_iconView cra_setImageWithURLString:newsKeyModel.imgsrc];
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



@end






