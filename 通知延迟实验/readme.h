//
//  readme.h
//  通知延迟实验
//
//  Created by postop.dev.ios.nophone on 2018/10/30.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#ifndef readme_h
#define readme_h

#endif /* readme_h */
/*
 实验名称：通知延迟
 实验目的：用于检测通过NSOperation来发送的通知，在有多个接收通知者的前提下，接收者处理事件速度会不会影响到彼此接收通知的速度
 实验结果：当有多个接收者的时候，接受者处理事件的速度会影响到彼此接收通知的速度。比如：接收者1首先收到了通知，那么要等接受者1的事情处理完了，接受者2才能去处理任务。而他们的先后顺序由在运行时添加通知的顺序正相关。
 */

