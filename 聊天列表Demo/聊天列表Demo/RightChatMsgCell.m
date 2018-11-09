//
//  RightChatMsgCell.m
//  聊天列表Demo
//
//  Created by postop.dev.ios.nophone on 2018/11/9.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import "RightChatMsgCell.h"

@interface RightChatMsgCell ()
@property (strong, nonatomic) IBOutlet UIImageView *headImg;
@property (strong, nonatomic) IBOutlet UILabel *text;

@end

@implementation RightChatMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configWithMessageModel:(MessageModel *)messageModel{
    self.text.text = messageModel.text;
}
@end
