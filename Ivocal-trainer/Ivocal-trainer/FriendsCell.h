//
//  FriendsCell.h
//  Ivocal-trainer
//
//  Created by Gayanath Damith Amarasinghe on 10/1/17.
//  Copyright © 2017 Gayanath Damith Amarasinghe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *friendImg;
@property (weak, nonatomic) IBOutlet UILabel *friendNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *friendLevelLbl;
@end
