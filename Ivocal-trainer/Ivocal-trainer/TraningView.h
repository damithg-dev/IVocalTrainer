//
//  TraningView.h
//  Ivocal-trainer
//
//  Created by Gayanath Damith Amarasinghe on 8/21/17.
//  Copyright © 2017 Gayanath Damith Amarasinghe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+HexString.h"
#import "HomeCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "utill.h"
#import "Alerts.h"
#import "TraningProfileView.h"

@interface TraningView : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *traningTbl;
@end
