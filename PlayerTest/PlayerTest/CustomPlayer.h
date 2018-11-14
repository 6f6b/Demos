//
//  CustomPlayer.h
//  PlayerTest
//
//  Created by branon_liu on 2018/10/16.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>

@interface CustomPlayer : NSObject

@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,strong) AVPlayerLayer *playerLayer;

- (instancetype)init:(NSURL *)url;
@end
