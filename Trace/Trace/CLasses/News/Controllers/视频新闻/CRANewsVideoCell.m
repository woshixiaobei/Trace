//
//  CRANewsVideoCell.m
//  News
//
//  Created by 杨应海 on 16/6/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRANewsVideoCell.h"
#import "CRANewsVideoModel.h"

@interface CRANewsVideoCell()
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *topicImg;
@property (weak, nonatomic) IBOutlet UILabel *topicName;

@end

@implementation CRANewsVideoCell


- (void)setModel:(CRANewsVideoModel *)model {
    _model = model;
    
    [_cover cra_setImageWithURLString:model.cover];
    _title.text = model.title;
    [_topicImg cra_setImageWithURLString:model.topicImg];
    _topicName.text = model.topicName;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor whiteColor];
}

@end
