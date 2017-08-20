//
//  PitchMeterView.h
//  Ivocal-trainer
//
//  Created by Gayanath Damith Amarasinghe on 8/20/17.
//  Copyright © 2017 Gayanath Damith Amarasinghe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EZAudio.h"
#import "UIColor+HexString.h"



@interface PitchMeterView : UIViewController<EZAudioFFTDelegate,EZMicrophoneDelegate>

@property (weak, nonatomic) IBOutlet UILabel *pitchLevelLbl;
@property (weak, nonatomic) IBOutlet UIButton *startstopBtn;


@property (nonatomic, strong) EZAudioFFTRolling *fft;
@property (nonatomic, strong) EZMicrophone *microphone;

@end
