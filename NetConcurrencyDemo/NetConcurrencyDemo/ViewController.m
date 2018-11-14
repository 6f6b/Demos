//
//  ViewController.m
//  NetConcurrencyDemo
//
//  Created by postop.dev.ios.liufeng on 2018/10/23.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import "ViewController.h"
#import "NSSleepOperation.h"

@interface ViewController ()
@property (nonatomic,strong) NSOperationQueue *operationQueue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.operationQueue = [[NSOperationQueue alloc] init];
    self.operationQueue.maxConcurrentOperationCount = 5;
    
    for (int i = 0; i<10; i++) {
//        NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
//            [NSThread sleepForTimeInterval:3];
//            NSLog(@"睡完了");
//        }];
//        [self.operationQueue addOperation:blockOperation];
        NSSleepOperation *operation = [[NSSleepOperation alloc] initWith:[NSString stringWithFormat:@"操作ID:%d",i]];
        operation.completionBlock = ^(){
            NSLog(@"队列数目：%d",[self.operationQueue operations].count);
        };
        [self.operationQueue addOperation:operation];
        NSLog(@"%d",i);
    }

}

- (void)delayOperationWithDelayTime:(float)time completion:(void(^)())completion{
    NSLog(@"睡一会儿");
    [NSThread sleepForTimeInterval:time];
    completion();
}


@end
