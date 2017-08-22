//
//  LessonsProfileView.h
//  Ivocal-trainer
//
//  Created by Gayanath Damith Amarasinghe on 8/22/17.
//  Copyright © 2017 Gayanath Damith Amarasinghe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+HexString.h"

@interface LessonsProfileView : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UITextView *decriptionTxtView;
@property (strong, atomic) NSMutableDictionary *lessonDict;

@end
