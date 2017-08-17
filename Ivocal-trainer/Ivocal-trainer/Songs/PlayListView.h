//
//  PlayListView.h
//  Ivocal-trainer
//
//  Created by Gayanath Damith Amarasinghe on 7/13/17.
//  Copyright © 2017 Gayanath Damith Amarasinghe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "utill.h"
#import "Alerts.h"
#import "SongsCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIColor+HexString.h"
#import "SongView.h"


@interface PlayListView : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *playListTbl;
//songscell cell idintifier



@end
