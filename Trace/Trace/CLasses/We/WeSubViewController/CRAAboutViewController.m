//
//  CRAAboutViewController.m
//  Trace
//
//  Created by Clark on 16/6/18.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//
#define TABLEHEADERHEIGHT 260
#import "CRAAboutViewController.h"
#import "CRAboutView.h"
@interface CRAAboutViewController ()

@property (nonatomic, weak)UIView *headerView;
@property (nonatomic, weak)UIImageView *imageView;
@property (nonatomic, weak)UIView *footerView;

@end

@implementation CRAAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;

    // Do any additional setup after loading the view.
}
- (void)setupUI {
    UITableView *tv = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:tv];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width, TABLEHEADERHEIGHT)];
    
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-49);
    }];
    tv.showsVerticalScrollIndicator = NO;
    tv.showsHorizontalScrollIndicator = NO;
//    tv.scrollEnabled = NO;
    v.backgroundColor = [UIColor whiteColor];
    tv.tableHeaderView = v;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, TABLEHEADERHEIGHT, self.view.bounds.size.width, (self.view.bounds.size.height-TABLEHEADERHEIGHT))];
    footerView.backgroundColor = [UIColor whiteColor];

    tv.tableFooterView = footerView;
    
    UIImage *image = [UIImage imageNamed:@"健康圈"];
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    iv.image = image;
    [v addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(v).offset(30);
        make.centerX.equalTo(v);
    }];

    [v drawRect:CGRectMake(0, 149, self.view.bounds.size.width, 1)];
    CRAboutView *lineView = [[CRAboutView alloc] init];
    lineView.backgroundColor = [UIColor whiteColor];
    [v addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(v.mas_bottom);
        make.width.mas_equalTo(self.view.bounds.size.width);
        make.height.mas_equalTo(2);
    }];
    
    _headerView = v;
    _imageView = iv;
    _footerView = footerView;
    [self addHeaderLabel];
    [self addFooterLabel];
}
- (void)addFooterLabel {
    UILabel *lLeft = [UILabel cz_labelWithText:@"新浪微博：@青岛信报" fontSize:13 color:[UIColor cz_colorWithRed:40 green:40 blue:40]];
    [_footerView addSubview:lLeft];
    [lLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_footerView).offset(35);
        make.left.equalTo(_footerView).offset(15);
    }];
    UILabel *lBottomLeft = [UILabel cz_labelWithText:@"QQ交流群：@青岛信报" fontSize:13 color:[UIColor cz_colorWithRed:40 green:40 blue:40]];
    [_footerView addSubview:lBottomLeft];
    [lBottomLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lLeft.mas_bottom).offset(35);
        make.left.equalTo(_footerView).offset(15);
    }];
    
    UILabel *lRight = [UILabel cz_labelWithText:@"腾讯微博：***********" fontSize:13 color:[UIColor cz_colorWithRed:40 green:40 blue:40]];
    [_footerView addSubview:lRight];
    [lRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_footerView).offset(35);
        make.left.equalTo(_footerView.mas_centerX).offset(15);
    }];
    UILabel *lBottomRight = [UILabel cz_labelWithText:@"合作QQ号：*********" fontSize:13 color:[UIColor cz_colorWithRed:40 green:40 blue:40]];
    [_footerView addSubview:lBottomRight];
    [lBottomRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lRight.mas_bottom).offset(35);
        make.left.equalTo(_footerView.mas_centerX).offset(15);
    }];
    UILabel *lBottom = [UILabel cz_labelWithText:@"2016CrazyHackers出品" fontSize:12 color:[UIColor cz_colorWithRed:52 green:52 blue:52]];
    [_footerView addSubview:lBottom];
    [lBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_footerView);
        make.top.equalTo(lBottomRight.mas_bottom).offset(40);
    }];
//    [_footerView addSubview:lBottom];

}
- (void)addHeaderLabel {
    UILabel *l = [UILabel cz_labelWithText:@"青岛信报" fontSize:28 color:[UIColor cz_colorWithRed:40 green:40 blue:40]];
    [_headerView addSubview:l];
    [l mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView.mas_bottom).offset(12);
        make.centerX.equalTo(_headerView);
    }];
    UILabel *lLeft = [UILabel cz_labelWithText:@"青岛信报" fontSize:20 color:[UIColor cz_colorWithRed:40 green:40 blue:40]];
    [_headerView addSubview:lLeft];
    [lLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(l.mas_bottom).offset(12);
        make.right.equalTo(self.view.mas_centerX).offset(-9);
    }];
    
    UILabel *lRight = [UILabel cz_labelWithText:@"掌上生活" fontSize:20 color:[UIColor cz_colorWithRed:40 green:40 blue:40]];
    [_headerView addSubview:lRight];
    [lRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(l.mas_bottom).offset(12);
        make.left.equalTo(self.view.mas_centerX).offset(9);
    }];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
