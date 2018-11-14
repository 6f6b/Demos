//
//  NSSleepOperation.m
//  NetConcurrencyDemo
//
//  Created by postop.dev.ios.nophone on 2018/10/25.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import "NSSleepOperation.h"

@interface NSSleepOperation()
@property (nonatomic,copy) NSString *name;
@end

@implementation NSSleepOperation

- (instancetype)initWith:(NSString *)name{
    if (self = [super init]) {
        self.name = name;
    }
    return self;
}

- (void)main{
    NSLog(@"start:%@",self.name);
    [NSThread sleepForTimeInterval:3];
    NSLog(@"start 结束:%@",self.name);
    if (self.completionBlock) {
        self.completionBlock();
    }
}

- (void)start{
    [super start];
//    NSLog(@"start:%@",self.name);
//    [NSThread sleepForTimeInterval:3];
//    NSLog(@"start 结束:%@",self.name);
}
@end
