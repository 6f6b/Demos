//
//  CustomPlayer.m
//  PlayerTest
//
//  Created by branon_liu on 2018/10/16.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import "CustomPlayer.h"
#import <AVKit/AVKit.h>
@interface CustomPlayer()

@end
@implementation CustomPlayer
- (instancetype)init:(NSURL *)url{
    if (self=[super init]) {
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
        
        AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
        self.player = player;
        player.actionAtItemEnd = AVPlayerStatusReadyToPlay;
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
        self.playerLayer = playerLayer;
    }
    return self;
}
@end
