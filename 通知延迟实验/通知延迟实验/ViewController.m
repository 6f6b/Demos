//
//  ViewController.m
//  通知延迟实验
//
//  Created by postop.dev.ios.nophone on 2018/10/30.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import "ViewController.h"
#import "Listener.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    Listener *listener2 = [[Listener alloc] init];
    listener2.block = ^{
        NSLog(@"开始执行2");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"结束执行2");
    };
    
    Listener *listener1 = [[Listener alloc] init];
    listener1.block = ^{
        NSLog(@"开始执行1");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"结束执行1");
    };
    
    
    Listener *listener3 = [[Listener alloc] init];
    listener3.block = ^{
        NSLog(@"开始执行3");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"结束执行3");
    };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFI" object:nil];
}

@end
