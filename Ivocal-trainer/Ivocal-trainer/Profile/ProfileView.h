//
//  ProfileView.h
//  Ivocal-trainer
//
//  Created by Gayanath Damith Amarasinghe on 7/13/17.
//  Copyright © 2017 Gayanath Damith Amarasinghe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBSDKCoreKit.h"
#import "FBSDKLoginKit.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SVProgressHUD.h"
#import "UIColor+HexString.h"


@interface ProfileView : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *prfImgeView;
@property (weak, nonatomic) IBOutlet UIImageView *backImgeView;

@end
