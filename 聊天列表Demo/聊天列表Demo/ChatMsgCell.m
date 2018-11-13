//
//  ChatMsgCell.m
//  聊天列表Demo
//
//  Created by postop.dev.ios.nophone on 2018/11/9.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import "ChatMsgCell.h"

@implementation ChatMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configWithMessageModel:(MessageModel *)messageModel{
    
}
@end
