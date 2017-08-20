//
//  PitchMeterView.m
//  Ivocal-trainer
//
//  Created by Gayanath Damith Amarasinghe on 8/20/17.
//  Copyright © 2017 Gayanath Damith Amarasinghe. All rights reserved.
//

#import "PitchMeterView.h"

static vDSP_Length const FFTViewControllerFFTWindowSize = 4096;


@interface PitchMeterView (){
    BOOL isPressed;
}


@end
#define kAudioFilePath @"test.m4a"


@implementation PitchMeterView

#pragma mark - Dealloc
//------------------------------------------------------------------------------

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{
    [self initNavigationBar];
    [self initMicrphone];

}

-(void)initNavigationBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FE4E71"]}];
    
    self.title = @"Pitch Meter";
    self.edgesForExtendedLayout = UIRectEdgeNone;
}


-(void)initMicrphone{
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    if (error)
    {
        NSLog(@"Error  setting up audio session category: %@", error.localizedDescription);
    }
    [session setActive:YES error:&error];
    if (error)
    {
        NSLog(@"Error setting up audio session active: %@", error.localizedDescription);
    }
    
    self.microphone = [EZMicrophone microphoneWithDelegate:self];
    
    [session overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&error];
    
    if (error)
    {
        NSLog(@"Error overriding output to the speaker: %@", error.localizedDescription);
    }
    
    
    NSLog(@"File written to application sandbox's documents directory: %@",[self testFilePathURL]);
    
    self.fft = [EZAudioFFTRolling fftWithWindowSize:FFTViewControllerFFTWindowSize
                                         sampleRate:self.microphone.audioStreamBasicDescription.mSampleRate
                                           delegate:self];
    
}

#pragma mark - EZMicrophoneDelegate

#warning Thread Safety
//
// Note that any callback that provides streamed audio data (like streaming
// microphone input) happens on a separate audio thread that should not be
// blocked. When we feed audio data into any of the UI components we need to
// explicity create a GCD block on the main thread to properly get the UI to
// work.
- (void)microphone:(EZMicrophone *)microphone
  hasAudioReceived:(float **)buffer
    withBufferSize:(UInt32)bufferSize
withNumberOfChannels:(UInt32)numberOfChannels
{
    [self.fft computeFFTWithBuffer:buffer[0] withBufferSize:bufferSize];
    dispatch_async(dispatch_get_main_queue(), ^{});
}


#pragma mark - EZAudioFFTDelegate
//------------------------------------------------------------------------------

- (void)fft:(EZAudioFFT *)fft
updatedWithFFTData:(float *)fftData
 bufferSize:(vDSP_Length)bufferSize
{
    float maxFrequency = [fft maxFrequency];
    float maxFrequencyMagnitude = [fft maxFrequencyMagnitude];
    float *fftdata = [fft fftData];
    float *inversedFFTData = [fft inversedFFTData];
    
    
    NSString *noteName = [EZAudioUtilities noteNameStringForFrequency:maxFrequency
                                                        includeOctave:YES];
    //    if ([[self.frqArray objectAtIndex:i]isEqualToString:[NSString stringWithFormat:@"%f",maxFrequency]]) {
    //        NSLog(@"ela ela%@",[NSString stringWithFormat:@"amthure Note: %@,\nFrequency: %.2f", noteName, maxFrequency]);
    //        NSLog(@"ela ela%@",[NSString stringWithFormat:@"original Note: %@,\nFrequency: %@", [self.noteArray objectAtIndex:i], [self.frqArray objectAtIndex:i]]);
    //    }else{
    //    NSLog(@"%@",[NSString stringWithFormat:@"amthure Note: %@,\nFrequency: %.2f", noteName, maxFrequency]);
    //    NSLog(@"%@",[NSString stringWithFormat:@"original Note: %@,\nFrequency: %@", [self.noteArray objectAtIndex:i], [self.frqArray objectAtIndex:i]]);
    //    }
    
    //    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"%@",[NSString stringWithFormat:@"\n Highest Note: %@,\n Frequency: %.2f\n maxFrequencyMagnitude %.2f\n fftdata: %.@f\n  ", noteName, maxFrequency,maxFrequencyMagnitude,[[NSNumber numberWithFloat:* fftData] stringValue]]);
        if ( 85.0 < maxFrequency < 2550.0) {
                    self.pitchLevelLbl.text =[NSString stringWithFormat:@"%.2f Hz", maxFrequency];
        }
    });
}

#pragma mark - Utility
//------------------------------------------------------------------------------

- (NSArray *)applicationDocuments
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
}

//------------------------------------------------------------------------------

- (NSString *)applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}


- (NSURL *)testFilePathURL
{
    return [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",
                                   [self applicationDocumentsDirectory],kAudioFilePath]];
}




- (IBAction)startStopButtonPressed:(id)sender {
    
    if (isPressed) {
        isPressed = false;
        [self.startstopBtn setImage:[UIImage imageNamed:@"stop_btn"] forState:UIControlStateNormal];
        [self.microphone startFetchingAudio];
    }else{
        isPressed = true;
        [self.startstopBtn setImage:[UIImage imageNamed:@"ready_btn"] forState:UIControlStateNormal];
        [self.microphone stopFetchingAudio];
    
    }
    
}


- (IBAction)cancelButtonPresssed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
