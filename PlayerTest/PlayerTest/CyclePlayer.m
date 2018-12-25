//
//  CyclePlayer.m
//  PlayerTest
//
//  Created by postop.dev.ios.nophone on 2018/12/25.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import "CyclePlayer.h"
#import <AVKit/AVKit.h>

@interface CyclePlayer ()
@property (nonatomic,strong) AVPlayer *avplayer1;
@property (nonatomic,strong) AVPlayer *avplayer2;
@property (nonatomic,strong) AVPlayerItem *avplayerItem1;
@property (nonatomic,strong) AVPlayerItem *avplayerItem2;
@property (nonatomic,strong) AVPlayerLayer *avplayerLayer1;
@property (nonatomic,strong) AVPlayerLayer *avplayerLayer2;
@end
@implementation CyclePlayer

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)playWithURL:(NSURL *)url{
    [self resetPlayers];
    float loadTime = 0.3;
    self.avplayerItem1 = [AVPlayerItem playerItemWithURL:url];
    self.avplayerItem2 = [AVPlayerItem playerItemWithURL:url];
    self.avplayer1 = [AVPlayer playerWithPlayerItem:self.avplayerItem1];
    self.avplayer2 = [AVPlayer playerWithPlayerItem:self.avplayerItem2];
    
    self.avplayerLayer2 = [AVPlayerLayer playerLayerWithPlayer:self.avplayer2];
    self.avplayerLayer2.frame = self.bounds;
    [self.layer addSublayer:self.avplayerLayer2];
    self.avplayerLayer1 = [AVPlayerLayer playerLayerWithPlayer:self.avplayer1];
    self.avplayerLayer1.frame = self.bounds;
    [self.layer addSublayer:self.avplayerLayer1];
    
    [self.avplayer1 play];
    [self.avplayer1 addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        //还剩loadTime时启动AVPlayer2
        float current = CMTimeGetSeconds(time);
        float total = CMTimeGetSeconds([self.avplayerItem1 duration]);
        NSLog(@"player1播放进度：%f",current);
        if ((total-current) <= loadTime) {
            NSLog(@"启动播放器2");
            [self.avplayer2 seekToTime:CMTimeMake(0, 1)];
            [self.avplayer2 play];
        }
        if (current > 0) {
            [self.avplayerLayer1 setHidden:FALSE];
            [self.avplayerLayer2 setHidden:TRUE];
        }
    }];
    
    [self.avplayer2 addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        //还剩loadTime时启动AVPlayer1
        float current = CMTimeGetSeconds(time);
        float total = CMTimeGetSeconds([self.avplayerItem2 duration]);
        NSLog(@"player2播放进度：%f",current);
        if ((total-current) <= loadTime) {
            NSLog(@"启动播放器1");
            [self.avplayer1 seekToTime:CMTimeMake(0, 1)];
            [self.avplayer1 play];
        }
        if (current > 0) {
            [self.avplayerLayer1 setHidden:TRUE];
            [self.avplayerLayer2 setHidden:FALSE];
        }
    }];
}

- (void)play{
    
}

- (void)pause{
    
}

- (void)stop{
}

//重置两个播放器
- (void)resetPlayers{
    
}

@end
