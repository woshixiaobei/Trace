//
//  CRAmyOrdersCell.m
//  Trace
//
//  Created by 小贝 on 16/6/22.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAmyOrdersCell.h"
#import "CRAMyOrderListViewModel.h"

@interface CRAmyOrdersCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleAccount;
@property (weak, nonatomic) IBOutlet UIButton *amountSum;

@end
@implementation CRAmyOrdersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (IBAction)clickButton:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未支付成功，亲~" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}
- (IBAction)orderedList:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您已经支付成功哟~" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];

}

- (void)setModel:(CRAMyOrderListViewModel *)model {
    _model = model;
    
    //更新UI
    _titleLabel.text = model.title;
    _iconView.image = [UIImage imageNamed:model.icon];
    _saleAccount.text = @(model.price).description;
   
}
@end
