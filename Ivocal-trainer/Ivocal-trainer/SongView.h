//
//  SongView.h
//  Ivocal-trainer
//
//  Created by Gayanath Damith Amarasinghe on 7/16/17.
//  Copyright © 2017 Gayanath Damith Amarasinghe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "EZAudio.h"
#import "UIColor+HexString.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "RecordView.h"

@import AFNetworking;


@interface SongView : UIViewController<EZAudioPlayerDelegate,EZAudioFFTDelegate>

@property (weak, nonatomic) IBOutlet UILabel *songNameLbl;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *backwardBtn;
@property (weak, nonatomic) IBOutlet UIButton *forwardBtn;
@property (weak, nonatomic) IBOutlet UISlider *timeSlider;
@property (weak, nonatomic) IBOutlet UITextView *lyricView;
@property (weak, nonatomic) IBOutlet EZAudioPlotGL *audiographView;
@property (weak, nonatomic) IBOutlet UIImageView *backImgeView;


#pragma mark - Properties
//------------------------------------------------------------------------------

//
// An EZAudioFile that will be used to load the audio file at the file path specified
//
@property (nonatomic, strong) EZAudioFile *audioFile;

//------------------------------------------------------------------------------

//
// An EZAudioPlayer that will be used for playback
//
@property (nonatomic, strong) EZAudioPlayer *player;


@property (nonatomic, strong) EZAudioFFTRolling *fft;

@property(atomic , strong)NSMutableDictionary *songDict;



@end
