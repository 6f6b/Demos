//
//  BTEquipmentCell.h
//  BlueTooth实验
//
//  Created by postop.dev.ios.nophone on 2018/11/5.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTEquipmentCell : UITableViewCell
- (void)configWith:(CBPeripheral *)peripheral;
@end

NS_ASSUME_NONNULL_END
