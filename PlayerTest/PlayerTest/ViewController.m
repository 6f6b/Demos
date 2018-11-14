//
//  ViewController.m
//  PlayerTest
//
//  Created by branon_liu on 2018/10/15.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>

#import <AliyunPlayerSDK/AliyunPlayerSDK.h>
#import <AliyunVodPlayerSDK/AliyunVodPlayerSDK.h>
#import "CustomPlayer.h"
@interface ViewController ()

@property (nonatomic,strong) AVPlayer *mediaPlayer;
@property (nonatomic,strong) UIView *contentView;

@property (strong,nonatomic)NSMutableArray *myPlayers;

@property (strong, nonatomic)AVPlayer *myPlayer;//播放器
@property (strong, nonatomic)AVPlayerItem *item;//播放单元
@property (strong, nonatomic)AVPlayerLayer *playerLayer;//播放界面（layer）
@property (nonatomic,assign) NSUInteger index;

@property (nonatomic,strong) AVPlayerLooper *looper;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.grayColor;
    self.index = 0;
    self.myPlayers = [NSMutableArray new];

    
    NSURL *mediaPath = [[NSBundle mainBundle] pathForResource:@"我的影片" ofType:@"mp3"];
    NSURL *mediaURL = [NSURL fileURLWithPath:mediaPath];

//    for (int i=0; i<2; i++) {
//        CustomPlayer *customPlayer = [[CustomPlayer alloc] init:mediaURL];
//        customPlayer.playerLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, 500);
//        [self.view.layer addSublayer:customPlayer.playerLayer];
//        [self.myPlayers addObject:customPlayer];
//
//        [customPlayer.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 50) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
//            float current = CMTimeGetSeconds(time);
//            float total = CMTimeGetSeconds(self.item.duration);
//            NSLog(@"%f---%f",current,total);
//        }];
//    }
    
    
    AVMutableComposition *composition = [[AVMutableComposition alloc] init];
    
    
    self.item = [AVPlayerItem playerItemWithURL:mediaURL];

    self.myPlayer = [AVPlayer playerWithPlayerItem:self.item];
    self.myPlayer.actionAtItemEnd = AVPlayerItemStatusReadyToPlay;
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.myPlayer];
    self.playerLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, 500);
    [self.view.layer addSublayer:self.playerLayer];
//    [self.myPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 100) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
//        float current = CMTimeGetSeconds(time);
//        float total = CMTimeGetSeconds(self.item.duration);
//        if((total-current)<0.04){
//            //执行下一次播放
//            [self.myPlayer seekToTime:CMTimeMakeWithSeconds(0.18, 1000) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
//            //[self.myPlayer play];
//        }
//        NSLog(@"%f---%f",current,total);
//    }];

    [self.myPlayer play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.item];
    
    //创建播放器
//    self.mediaPlayer = [[AliyunVodPlayer alloc] init];
//    self.mediaPlayer.displayMode = AliyunVodPlayerDisplayModeFit;
//    self.mediaPlayer.circlePlay = true;
//    self.mediaPlayer.autoPlay = true;
//
//    self.mediaPlayer.playerView.backgroundColor = UIColor.yellowColor;
//    self.mediaPlayer.playerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 500);
//    [self.view addSubview:self.mediaPlayer.playerView];
//
//    //设置播放类型，0为点播、1为直播，默认使用自动
//
//    [self.mediaPlayer prepareWithURL:mediaURL];


}

- (void)preparePlay{
    
}

- (void)play{
//    NSUInteger oldIndex = self.index;
//    self.index = oldIndex == 0 ? 1 : 0;
//
//    CustomPlayer *oldPlayer = self.myPlayers[oldIndex];
//    CustomPlayer *newPlayer = self.myPlayers[self.index];
//
//    [oldPlayer.playerLayer setHidden:true];
//    [oldPlayer.player seekToTime:CMTimeMakeWithSeconds(0.01, 1000) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
//
//    [newPlayer.playerLayer setHidden:false];
//    [newPlayer.player play];
}

- (void)playbackFinished:(NSNotification *)notification{
    [self.myPlayer seekToTime:CMTimeMakeWithSeconds(0, 1000) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    [self.myPlayer play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)enableAudioTracks:(BOOL)enable inPlayerItem:(AVPlayerItem*)playerItem
{
    for (AVPlayerItemTrack *track in playerItem.tracks)
    {
        if ([track.assetTrack.mediaType isEqual:AVMediaTypeAudio])
        {
            track.enabled = enable;
        }
    }
}

@end
