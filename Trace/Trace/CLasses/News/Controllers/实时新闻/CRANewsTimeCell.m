//
//  CRANewsTimeCell.m
//  News
//
//  Created by 杨应海 on 16/6/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRANewsTimeCell.h"
#import "CRANewsTimeModel.h"

@interface CRANewsTimeCell()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation CRANewsTimeCell


- (void)setModel:(CRANewsTimeModel *)model {
 
    [_pictureView cra_setImageWithURLString:model.imgsrc];
    _titleLabel.text = model.title;
}




- (void)awakeFromNib {
    [super awakeFromNib];

    
    _pictureView.contentMode = UIViewContentModeScaleAspectFill;
    _pictureView.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
