//
//  ChatMsgFactory.h
//  聊天列表Demo
//
//  Created by postop.dev.ios.nophone on 2018/11/9.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ChatMsgCell.h"
#import "MessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatMsgFactory : NSObject
//注册
+ (void)registerChatMsgCellWith:(UITableView *)tableView;

//返回
+ (ChatMsgCell *)cellWith:(UITableView *)tableView messageModel:(MessageModel *)messageModel;
@end

NS_ASSUME_NONNULL_END
