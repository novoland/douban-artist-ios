//
//  DAPlayerC.m
//  DoubanArtist
//
//  Created by liujing on 14-11-20.
//
//

#import "DAPlayerC.h"
#import "UIView+Borders.h"
#import "JDStatusBarNotification.h"

@interface DAPlayerC ()

@property(strong,nonatomic) NSMutableArray *list;
@property(assign,nonatomic) NSInteger curIndex;
@property(strong,nonatomic) STKAudioPlayer *audioPlayer;
@property(strong,nonatomic) NSTimer *progressUpdateTimer;

@end

@implementation DAPlayerC

// name,artist,id,picture,length,src
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        
        _audioPlayer = [STKAudioPlayer new];
        _audioPlayer.delegate = self;
        
        // 监听播放事件
        [nc addObserver:self
               selector:@selector(playListWithIndex:) name:@"player.playList" object:nil];
        [nc addObserver:self
               selector:@selector(playTrack:) name:@"player.playTrack" object:nil];
    }
    return self;
}

// 播放单曲列表，并指定从哪首开始
- (void) playListWithIndex:(NSNotification *) note{
    NSDictionary *param = [note userInfo];
    _list = [param objectForKey:@"playlist"];
    NSInteger index = [(NSNumber *) [param objectForKey:@"index"] integerValue];
    
    [self playTrackAtIndex:index];
}

// 播放单曲。如果单曲在当前列表中，播放之；如果不在，则加入到最末并播放
- (void) playTrack:(NSNotification *)note{
    NSDictionary *track = [note userInfo];
    [_list addObject:track];
    [self playTrackAtIndex:_list.count - 1];
}

// 所有播放单曲的方法，最后都会调用这个方法
- (void) playTrackAtIndex:(NSInteger) index{
    if(index >= [_list count])
        return;
    
    _curIndex = index;
    NSDictionary *track = [_list objectAtIndex:index];
    [_trackImg sd_setImageWithURL:[NSURL URLWithString:[track objectForKey:@"picture"]] placeholderImage:[UIImage imageNamed:@"IconTrackDefault"]];
    _trackTitleLabel.text = [track objectForKey:@"name"];
    _artistLabel.text = [track objectForKey:@"artist"];
    
    [_audioPlayer playURL:[NSURL URLWithString:[track objectForKey:@"src"]]];
    [JDStatusBarNotification showWithStatus:[NSString stringWithFormat:@"开始播放: %@",_trackTitleLabel.text]
                               dismissAfter:2
                                  styleName:JDStatusBarStyleSuccess];
    [self startTimer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // progress bar
    _progressBar = [[UIProgressView alloc] init];
    [self.view addSubview:_progressBar];
    _progressBar.backgroundColor = [UIColor whiteColor];
    
    // btns
    [_playBtn setBackgroundImage:[UIImage imageWithColor:kColorEEE] forState:UIControlStateHighlighted];
    [_nextBtn setBackgroundImage:[UIImage imageWithColor:kColorEEE] forState:UIControlStateHighlighted];
}

- (void) viewDidLayoutSubviews{
    CGFloat w = CGRectGetWidth(self.view.frame),
    h = 2,
    y = CGRectGetHeight(self.view.frame) - h,
    viewHeight = CGRectGetHeight(self.view.frame),
    textWidth = w - viewHeight - 8 * 2 - CGRectGetWidth(_playBtn.frame) * 2;
    _progressBar.frame = CGRectMake(0, y, w, h);
    
    [_trackImg setWidth:viewHeight];
    [_trackImg setHeight:viewHeight];
    
    [_trackTitleLabel setWidth:textWidth];
    [_artistLabel setWidth:textWidth];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickListBtn:(id)sender {
}

- (IBAction)clickPlayBtn:(id)sender {
    if (_audioPlayer.state == STKAudioPlayerStatePaused){
        [_audioPlayer resume];
        [self startTimer];
    }
    else{
        [_audioPlayer pause];
        [_progressUpdateTimer invalidate];
    }
}

-(void)startTimer
{
    _progressUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                            target:self
                                                          selector:@selector(updatePlaybackProgress)
                                                          userInfo:nil
                                                           repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_progressUpdateTimer forMode:NSRunLoopCommonModes];
}

-(void) updatePlaybackProgress
{
    if (!_audioPlayer || _audioPlayer.duration == 0){
        _progressBar.progress = 0;
        return;
    }
    
    _progressBar.progress = _audioPlayer.progress / _audioPlayer.duration;
}

- (IBAction)clickNextBtn:(id)sender {
    [self playTrackAtIndex:_curIndex + 1];
}


-(void) updateControls
{
    BOOL stopped = _audioPlayer.state == STKAudioPlayerStateStopped || _audioPlayer.state == STKAudioPlayerStateError || _audioPlayer.state == STKAudioPlayerStatePaused;
    
    [_playBtn setImage:!stopped? [UIImage imageNamed:@"pause"]:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
}

-(void) audioPlayer:(STKAudioPlayer*)audioPlayer stateChanged:(STKAudioPlayerState)state previousState:(STKAudioPlayerState)previousState
{
    [self updateControls];
}

-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didEncounterError:(STKAudioPlayerErrorCode)errorCode
{
    [self updateControls];
}

-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didStartPlayingQueueItemId:(NSObject*)queueItemId
{
    [self updateControls];
}

-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject*)queueItemId
{
    [self updateControls];
}

-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didFinishPlayingQueueItemId:(NSObject*)queueItemId withReason:(STKAudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration
{
    [self updateControls];
}

/// Raised when an unexpected and possibly unrecoverable error has occured (usually best to recreate the STKAudioPlauyer)
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer unexpectedError:(STKAudioPlayerErrorCode)errorCode{
    
}
@end
