//
//  CRANewsPictureCell.m
//  News
//
//  Created by 杨应海 on 16/6/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRANewsPictureCell.h"
#import "CRANewsPictureModel.h"

@interface CRANewsPictureCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgsrc;
@property (weak, nonatomic) IBOutlet UILabel *replyCount;
@property (weak, nonatomic) IBOutlet UILabel *votecount;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *digest;


@end


@implementation CRANewsPictureCell


- (void)setModel:(CRANewsPictureModel *)model {
    _model = model;
    
    [_imgsrc cra_setImageWithURLString:model.imgsrc];
    _replyCount.text = [NSString stringWithFormat:@"评论:%zd",model.replyCount];
    _votecount.text = [NSString stringWithFormat:@"点赞:%zd",model.votecount];
    _title.text = model.title;
    _digest.text = model.digest;
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
