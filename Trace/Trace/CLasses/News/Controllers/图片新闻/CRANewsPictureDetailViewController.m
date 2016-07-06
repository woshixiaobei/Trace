//
//  CRANewsPictureDetailViewController.m
//  News
//
//  Created by 杨应海 on 16/6/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRANewsPictureDetailViewController.h"
#import "CRANewsPictureModel.h"

@interface CRANewsPictureDetailViewController ()

@end

@implementation CRANewsPictureDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.model.title;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:self.model.url_3w];
    
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
