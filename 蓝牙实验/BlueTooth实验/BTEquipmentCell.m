//
//  BTEquipmentCell.m
//  BlueTooth实验
//
//  Created by postop.dev.ios.nophone on 2018/11/5.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import "BTEquipmentCell.h"

@interface BTEquipmentCell()
@property (strong, nonatomic) IBOutlet UILabel *perName;
@property (strong, nonatomic) IBOutlet UILabel *perUID;
@property (strong, nonatomic) IBOutlet UILabel *perState;

@end

@implementation BTEquipmentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configWith:(CBPeripheral *)peripheral{
    // 将蓝牙外设对象接出，取出name，显示
    NSString *perName = [peripheral name];
    NSString *uid = [peripheral identifier].UUIDString;
    CBPeripheralState perState = [peripheral state];
    self.perName.text = [NSString stringWithFormat:@"设备名：%@",perName];
    self.perUID.text = [NSString stringWithFormat:@"设备号：%@",uid];
    NSString *perStateString = nil;
    self.perState.textColor = UIColor.blackColor;
    switch (perState) {
        case CBPeripheralStateConnected:
            self.perState.textColor = UIColor.redColor;
            perStateString = @"已连接";
            break;
        case CBPeripheralStateConnecting:
            perStateString = @"正在连接";
            break;
        case CBPeripheralStateDisconnected:
            perStateString = @"断开连接";
            break;
        case CBPeripheralStateDisconnecting:
            perStateString = @"正在断开连接";
            break;
        default:
            break;
    }
    self.perState.text = perStateString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
