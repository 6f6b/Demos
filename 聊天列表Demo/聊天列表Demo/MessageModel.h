//
//  MessageModel.h
//  聊天列表Demo
//
//  Created by postop.dev.ios.nophone on 2018/11/9.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageModel : NSObject
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL isrReceived;
@end

NS_ASSUME_NONNULL_END
