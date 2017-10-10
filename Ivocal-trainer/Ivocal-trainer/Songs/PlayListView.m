//
//  PlayListView.m
//  Ivocal-trainer
//
//  Created by Gayanath Damith Amarasinghe on 7/13/17.
//  Copyright © 2017 Gayanath Damith Amarasinghe. All rights reserved.
//

#import "PlayListView.h"

@interface PlayListView (){

    NSMutableArray *songsArray;
    NSMutableDictionary *songDict;
    
}
@end

@implementation PlayListView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    [self getAllSongs];
    
    songsArray = [[NSMutableArray alloc]init];
    songDict = [[NSMutableDictionary alloc]init];
}

-(void)initNavigationBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FE4E71"]}];
    self.title = @"Playlist";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.playListTbl setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return songsArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SongsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"songscell"];
    NSMutableDictionary *tempDict = [[NSMutableDictionary alloc]initWithDictionary:[songsArray objectAtIndex:indexPath.row]];
    cell.songNameLbl.text = [tempDict valueForKey:@"name"];
    cell.songDetatilLbl.text = [tempDict valueForKey:@"genre"];
    cell.songLengthLbl.text = [tempDict valueForKey:@"length"];
    [cell.songAlbumArtImgView sd_setImageWithURL:[NSURL URLWithString:[tempDict valueForKey:@"img"]]
                          placeholderImage:[UIImage imageNamed:@"song_placeholder.png"]
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {}];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    songDict = [[NSMutableDictionary alloc]initWithDictionary:[songsArray objectAtIndex:indexPath.row]];
    [self performSegueWithIdentifier:@"toSongs" sender:nil];
}



-(void)getAllSongs{
    [SVProgressHUD show];
    NSString *apiUrl = [NSString stringWithFormat:@"%@%@",BASE_URL,SONG_PLAYLIST];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy.allowInvalidCertificates = NO;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager POST:apiUrl parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
             // NSLog(@"getAllSongs  : %@", responseObject);
              songsArray = [[responseObject valueForKey:@"records"] mutableCopy];
              NSLog(@"getAllSongs  : %@", songsArray);
              [self.playListTbl reloadData];

              
              [SVProgressHUD dismiss];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: response%@", operation.response);
              [Alerts showAlertWithTitle:@"Error" message:@"It seems that your device doesn't Have internet. " controller: self];

              [SVProgressHUD dismiss];
            }
     ];
    [manager self];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//toSongs - segue for playlist to song


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toSongs"]) {
        
        SongView *vc = [segue destinationViewController];
        vc.songDict = [songDict mutableCopy];
    }
}


@end
