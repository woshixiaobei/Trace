//
//  CRANewFeatureViewController.m
//  Trace
//
//  Created by 张玺科 on 16/6/18.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRANewFeatureViewController.h"
#import "CRANewFeatureView.h"
#import "CRAMainTabBarController.h"
@interface CRANewFeatureViewController () 

@end

@implementation CRANewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 判断是否有新版本 - 等会了，改这里！
//    BOOL isNewVersion = NO;
    
//    if (isNewVersion) {
        [self showNewFeatureView];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 重写父类的方法，设置状态栏的隐藏状态
 */
- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - 添加新特性视图
- (void)showNewFeatureView {
    
    // 1. 添加新特性的视图 － 就是全屏的，不需要自动布局
    // 提示：只有小控件，需要参照上下左右的才需要自动布局
    CRANewFeatureView *v = [[CRANewFeatureView alloc] initWithFrame:self.view.bounds];
    
//    v.backgroundColor = [UIColor orangeColor];
    
//    v.delegate = self;
    
    [self.view addSubview:v];
    
    // 2. 获取并且设置新特性视图的图像名称数组
    v.imageNames = [self newFeatureNames];
    
    
}
#pragma mark - 代理方法
- (void)modal{
    CRAMainTabBarController *vc = [[CRAMainTabBarController alloc]init];
    
    
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (NSArray *)newFeatureNames{
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 4; i++) {
        NSString *imageName = [@"new_feature_" stringByAppendingFormat:@"%zd", (i + 1)];
        
        [arrayM addObject:imageName];
    }
    return arrayM.copy;
}

- (void)setupUI{
    UIImage *image = [UIImage imageNamed:@"cozy-control-car"];
    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
    
    // 设置图像视图的内容模式
    iv.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:iv];
    
    // 自动布局
    CGFloat margin = 20;
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.view);
        
        make.left.equalTo(self.view).offset(margin);
        make.right.equalTo(self.view).offset(-margin);
    }];
}

@end
