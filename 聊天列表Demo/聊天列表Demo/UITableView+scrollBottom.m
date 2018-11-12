//
//  UITableView+scrollBottom.m
//  聊天列表Demo
//
//  Created by postop.dev.ios.nophone on 2018/11/12.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import "UITableView+scrollBottom.h"

@implementation UITableView (scrollBottom)
- (void)nim_scrollToBottom:(BOOL)animation
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSInteger row = [self numberOfRowsInSection:0] - 1;
        if (row > 0)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
            [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animation];
        }
    });
}
@end
