//
//  ViewController.m
//  AFNetworking实验
//
//  Created by 刘丰 on 2018/11/6.
//  Copyright © 2018 dev.liufeng@gmail.com. All rights reserved.
//

#import "ViewController.h"
//#import "Reac"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:nil];
    [manager POST:@"https://www.baidu.com" parameters:@{@"hello":@"liufeng"} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

}


@end
