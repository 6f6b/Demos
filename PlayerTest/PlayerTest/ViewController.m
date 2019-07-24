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
#import <WebKit/WebKit.h>
#import "CyclePlayer.h"

@interface ViewController ()

@property (nonatomic,strong) CyclePlayer *cyclePlayer;
@property (nonatomic,strong) AVPlayer *avPlayer;
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.grayColor;
    
    NSString *mediaPath = [[NSBundle mainBundle] pathForResource:@"踏步_没音轨" ofType:@"mp4"];
    NSURL *mediaURL = [NSURL fileURLWithPath:mediaPath];

    self.avPlayer = [AVPlayer playerWithPlayerItem:[AVPlayerItem playerItemWithURL:mediaURL]];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    playerLayer.frame = CGRectMake(100, 100, 300, 150);
    [self.view.layer addSublayer:playerLayer];
    [self.avPlayer play];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidPlayToEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];

    
//    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:mediaURL error:nil];
//    self.audioPlayer.numberOfLoops = -1;
//    [self.audioPlayer play];
}

- (void)playerItemDidPlayToEnd:(NSNotification *)notification{
    [self rerunPlayVideo];
}

//视频重播

-(void)rerunPlayVideo{
        if (!self.avPlayer) {
                return;
            }
        CGFloat a=0;
        NSInteger dragedSeconds = floorf(a);
        CMTime dragedCMTime = CMTimeMake(dragedSeconds, 1);
        [self.avPlayer seekToTime:dragedCMTime];
        [self.avPlayer play];
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
