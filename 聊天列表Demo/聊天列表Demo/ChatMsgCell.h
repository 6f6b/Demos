//
//  ChatMsgCell.h
//  聊天列表Demo
//
//  Created by postop.dev.ios.nophone on 2018/11/9.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatMsgCell : UITableViewCell
- (void)configWithMessageModel:(MessageModel *)messageModel;
@end

NS_ASSUME_NONNULL_END
