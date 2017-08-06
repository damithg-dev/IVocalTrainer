//
//  SongsCell.h
//  Ivocal-trainer
//
//  Created by Gayanath Damith Amarasinghe on 7/15/17.
//  Copyright © 2017 Gayanath Damith Amarasinghe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *songAlbumArtImgView;
@property (weak, nonatomic) IBOutlet UILabel *songNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *songDetatilLbl;
@end
