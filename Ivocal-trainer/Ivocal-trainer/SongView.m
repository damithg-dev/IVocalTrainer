//
//  SongView.m
//  Ivocal-trainer
//
//  Created by Gayanath Damith Amarasinghe on 7/16/17.
//  Copyright © 2017 Gayanath Damith Amarasinghe. All rights reserved.
//

#import "SongView.h"

static vDSP_Length const FFTViewControllerFFTWindowSize = 4096;


@interface SongView (){
    NSTimer *timer;
    float val;
}

@end

@implementation SongView


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initAudioPlayer];
    [self initNavigationBar];
}

-(void)initNavigationBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.title = @"asdasdas";
    self.edgesForExtendedLayout = UIRectEdgeNone;
}


-(void)initAudioPlayer{
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"05 Happy.mp3" ofType:nil]];


    self.player = [EZAudioPlayer audioPlayerWithDelegate:self];
    self.player.shouldLoop = YES;
    
    //audio file
    self.audioFile = [EZAudioFile audioFileWithURL:url];
    [self.player setAudioFile:self.audioFile];
    
    //slider
    self.timeSlider.maximumValue = (float)self.audioFile.totalFrames;
    self.timeSlider.value = 0.0;
    
    [self.player playAudioFile:self.audioFile];
    [self.playBtn setSelected:true];
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    
    //fft initialize
    self.fft = [EZAudioFFTRolling fftWithWindowSize:FFTViewControllerFFTWindowSize
                                         sampleRate:self.audioFile.clientFormat.mSampleRate
                                           delegate:self];
    
    self.audiographView.plotType = EZPlotTypeRolling;
    //x axis drawing speed 
    self.audiographView.rollingHistoryLength = 800.0;


    __weak typeof (self) weakSelf = self;
    [self.audioFile getWaveformDataWithCompletionBlock:^(float **waveformData,
                                                         int length)
     {
         [weakSelf.audiographView updateBuffer:waveformData[0]
                           withBufferSize:length];
     }];
    
    
    
}


- (IBAction)playButtonPressed:(id)sender {
    if (self.playBtn.isSelected)
    {

        [self.player pause];
        [self.playBtn setImage:[UIImage imageNamed:@"play_"] forState:UIControlStateNormal];
        [self.playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateHighlighted];
        [self.playBtn setSelected:NO];
        
       // [self stopAudioVisualizer];
    }else
    {
        [self.player play];
        [self.playBtn setImage:[UIImage imageNamed:@"pause_"] forState:UIControlStateNormal];
        [self.playBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateHighlighted];
        [self.playBtn setSelected:YES];
        
        //[self startAudioVisualizer];
    }
}

- (void)updateTime:(NSTimer *)timer {
    self.timeSlider.value = (float)self.player.frameIndex;
    
//    CGPoint scrollPoint = self.lyricView.contentOffset; // initial and after update
//    NSLog(@"%.2f %.2f",scrollPoint.x,scrollPoint.y);
//    scrollPoint = CGPointMake(scrollPoint.x, scrollPoint.y + 25); // makes scroll
//    [self.lyricView setContentOffset:scrollPoint animated:YES];
//    NSLog(@"%f %f",self.lyricView.contentSize.width , self.lyricView.contentSize.height);
}

- (IBAction)seekToFrame:(id)sender {
    [self.player seekToFrame:(SInt64)[(UISlider *)sender value]];
}


- (IBAction)backwardButtonPressed:(id)sender {
    [self.player setCurrentTime:(self.player.currentTime - 1.0f)];
    [self.backwardBtn setImage:[UIImage imageNamed:@"playbck_"] forState:UIControlStateNormal];
    [self.backwardBtn setImage:[UIImage imageNamed:@"playbck"] forState:UIControlStateHighlighted];
}
- (IBAction)forwardButtonPressed:(id)sender {
    [self.player setCurrentTime:(self.player.currentTime + 1.0f)];
    [self.forwardBtn setImage:[UIImage imageNamed:@"playfrwd_"] forState:UIControlStateNormal];
    [self.forwardBtn setImage:[UIImage imageNamed:@"playfrwd"] forState:UIControlStateHighlighted];
}


- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)skipButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"torecord" sender:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewWillDisappear:(BOOL)animated{
    [self.player pause];
    [self.playBtn setImage:[UIImage imageNamed:@"play_"] forState:UIControlStateNormal];
    [self.playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateHighlighted];
    [self.playBtn setSelected:NO];
}

#pragma mark - EZAudioFFTDelegate
//------------------------------------------------------------------------------

- (void)fft:(EZAudioFFT *)fft
updatedWithFFTData:(float *)fftData
 bufferSize:(vDSP_Length)bufferSize
{

    
    float maxFrequency = [fft maxFrequency];
    NSString *noteName = [EZAudioUtilities noteNameStringForFrequency:maxFrequency
                                                        includeOctave:YES];
    
    //    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"%@",[NSString stringWithFormat:@"Highest Note: %@,\nFrequency: %.2f", noteName, maxFrequency]);
        // weakSelf.maxFrequencyLabel.text = [NSString stringWithFormat:@"Highest Note: %@,\nFrequency: %.2f", noteName, maxFrequency];
        // [weakSelf.audioPlotFreq updateBuffer:fftData withBufferSize:(UInt32)bufferSize];
    });
}

#pragma mark - EZAudioPlayerDelegate
//------------------------------------------------------------------------------

- (void)audioPlayer:(EZAudioPlayer *)audioPlayer
          playedAudio:(float **)buffer
       withBufferSize:(UInt32)bufferSize
 withNumberOfChannels:(UInt32)numberOfChannels
          inAudioFile:(EZAudioFile *)audioFile
{
    [self.fft computeFFTWithBuffer:buffer[0] withBufferSize:bufferSize];
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.audiographView updateBuffer:buffer[0]
                          withBufferSize:bufferSize];
    });
}

//------------------------------------------------------------------------------

- (void)audioPlayer:(EZAudioPlayer *)audioPlayer
    updatedPosition:(SInt64)framePosition
        inAudioFile:(EZAudioFile *)audioFile
{
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.timeSlider.touchInside)
        {
            weakSelf.timeSlider.value = (float)framePosition;
        }
    });
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
