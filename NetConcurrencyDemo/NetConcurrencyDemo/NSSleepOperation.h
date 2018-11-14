//
//  NSSleepOperation.h
//  NetConcurrencyDemo
//
//  Created by postop.dev.ios.nophone on 2018/10/25.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSSleepOperation : NSOperation
@property (nonatomic,strong) void(^completionBlock)();
- (instancetype)initWith:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
