//
//  FriendListView.h
//  Ivocal-trainer
//
//  Created by Gayanath Damith Amarasinghe on 8/14/17.
//  Copyright © 2017 Gayanath Damith Amarasinghe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendListView : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *friendsTblView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *categoryTab;

@end
