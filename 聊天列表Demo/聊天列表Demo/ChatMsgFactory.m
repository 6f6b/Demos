//
//  ChatMsgFactory.m
//  聊天列表Demo
//
//  Created by postop.dev.ios.nophone on 2018/11/9.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import "ChatMsgFactory.h"

@implementation ChatMsgFactory

//注册
+ (void)registerChatMsgCellWith:(UITableView *)tableView{
    [tableView registerNib:[UINib nibWithNibName:@"LeftChatMsgCell" bundle:nil] forCellReuseIdentifier:@"LeftChatMsgCell"];
    [tableView registerNib:[UINib nibWithNibName:@"RightChatMsgCell" bundle:nil] forCellReuseIdentifier:@"RightChatMsgCell"];
}

//返回
+ (ChatMsgCell *)cellWith:(UITableView *)tableView messageModel:(MessageModel *)messageModel{
    ChatMsgCell *cell;
    if (messageModel.isrReceived) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"LeftChatMsgCell"];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"RightChatMsgCell"];
    }
    return cell;
}
@end
