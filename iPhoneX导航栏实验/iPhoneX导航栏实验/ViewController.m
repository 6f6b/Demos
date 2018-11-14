//
//  ViewController.m
//  iPhoneX导航栏实验
//
//  Created by postop.dev.ios.nophone on 2018/11/2.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:73/255.0 green:95/255.0 blue:171/255.0 alpha:1]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setHidden:NO];
//    self.navigationController.navigationBar.barTintColor = SYColor(@"DC143C");
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
}


@end
