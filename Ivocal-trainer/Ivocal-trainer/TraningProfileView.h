//
//  TraningProfileView.h
//  Ivocal-trainer
//
//  Created by Gayanath Damith Amarasinghe on 8/22/17.
//  Copyright © 2017 Gayanath Damith Amarasinghe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+HexString.h"

@interface TraningProfileView : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgeVIew;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTxtView;
@property (strong, atomic) NSMutableDictionary *traningDict;


@end
