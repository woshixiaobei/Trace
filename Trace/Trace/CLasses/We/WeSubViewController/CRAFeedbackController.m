//
//  CRAFeedbackController.m
//  Trace
//
//  Created by Clark on 16/6/18.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAFeedbackController.h"
#import "CRAHomeViewController.h"

@interface CRAFeedbackController ()
@property (nonatomic ,strong)UITextView *contentView;

@end

@implementation CRAFeedbackController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupUI];
}

- (UITextView *)contentView {

    if (_contentView == nil) {
     _contentView = [[UITextView alloc] init];
        [self.view addSubview:_contentView];
    }
    return _contentView;
}

- (void)setupUI{
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 20, self.view.bounds.size.width-30, 180)];
    [self.view addSubview:textView];
    textView.layer.borderWidth = 0.5;
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _contentView = textView;
    
    UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(textView.frame)+15, textView.frame.size.width, 44)];
    bt.layer.cornerRadius = 10;
    [bt setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:bt];
    bt.backgroundColor = [UIColor blueColor];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lLabel = [UILabel cz_labelWithText:@"大家的意见以为软件的升级，优化起到了重要的作用，在此深表感谢，对于大家普遍关心的问题，会及时给与解答欢迎审阅。希望大家继续提出宝贵意见！" fontSize:20 color:[UIColor cz_colorWithRed:40 green:40 blue:40]];
    lLabel.numberOfLines = 0;
    [self.view addSubview:lLabel];
    [lLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bt.mas_bottom).offset(15);
        make.centerX.equalTo(self.view.mas_centerX);
        make.right.equalTo(self.view.mas_right).offset(-10);
    }];
}

- (void)buttonClick{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"我们会珍惜您的意见反馈" delegate:self cancelButtonTitle:@"继续反馈" otherButtonTitles:@"返回首页", nil];
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
   
    if (buttonIndex == 1) {
        [self.navigationController popViewControllerAnimated:NO];
        UITabBarController *tabBarController = (UITabBarController *)[[UIApplication sharedApplication].delegate window].rootViewController;
        tabBarController.selectedIndex = 0;
    } else {
     _contentView.text = @"";
        return;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
