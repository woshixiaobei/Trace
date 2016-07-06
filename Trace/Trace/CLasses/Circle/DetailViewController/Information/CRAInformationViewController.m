//
//  CRAInformationViewController.m
//  Trace
//
//  Created by 小贝 on 16/6/20.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAInformationViewController.h"

@interface CRAInformationViewController ()

@end

@implementation CRAInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView *tbweb = [[UIWebView alloc] init];
    
    tbweb.frame = self.view.bounds;
    
    [self.view addSubview:tbweb];
    
    NSURL *url = [NSURL URLWithString:@"http://www.iqiyi.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [tbweb loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
