//
//  Listener.h
//  通知延迟实验
//
//  Created by postop.dev.ios.nophone on 2018/10/30.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Listener : NSObject
typedef void(^Block)();

@property (nonatomic,copy) Block block;
@end

NS_ASSUME_NONNULL_END
