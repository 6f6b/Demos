//
//  ViewController.m
//  KeyValueTest
//
//  Created by postop.dev.ios.nophone on 2018/10/25.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import "ViewController.h"
#import "PersonController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.brownColor;
    PersonController *viewController = [[PersonController alloc] init];
    [viewController setValue:@"liufeng" forKey:@"name"];
    [viewController setValue:UIColor.blueColor forKeyPath:@"view.backgroundColor"];
    [self.navigationController pushViewController:viewController animated:true];
//    [self presentViewController:viewController animated:true completion:nil];
}


@end
