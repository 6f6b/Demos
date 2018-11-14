//
//  Listener.m
//  通知延迟实验
//
//  Created by postop.dev.ios.nophone on 2018/10/30.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import "Listener.h"

@interface Listener ()
@end
@implementation Listener
- (instancetype)init{
    if(self = [super init]){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification) name:@"NOTIFI" object:nil];
    }
    return self;
}

- (void)receivedNotification{
    if(self.block){
        self.block();
    }
}
@end
