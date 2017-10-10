//
//  FriendListView.m
//  Ivocal-trainer
//
//  Created by Gayanath Damith Amarasinghe on 8/14/17.
//  Copyright © 2017 Gayanath Damith Amarasinghe. All rights reserved.
//

#import "FriendListView.h"

@interface FriendListView (){
    NSMutableArray* friendsList, *localList, *globalList;
    
}

@end

@implementation FriendListView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.friendsTblView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    
    friendsList = [[NSMutableArray alloc]init];
    globalList = [[NSMutableArray alloc]init];
    localList = [[NSMutableArray alloc]init];
    
    [self fetchUserInfo];
    
}


-(void)fetchUserInfo
{
    if ([FBSDKAccessToken currentAccessToken])
    {
//        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id,name,link,first_name, last_name, picture.type(large), email, birthday,friends,gender,age_range,cover"}]
//         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//             if (!error)
//             {
//                 //NSLog(@"result is :%@",result);
//                 NSLog(@"User ID : %@",[result valueForKey:@"id"]);
//                 NSLog(@"User Name : %@",[result valueForKey:@"name"]);
//                 NSLog(@"User First Name :%@",[result valueForKey:@"first_name"]);
//                 NSLog(@"User Last Name :%@",[result valueForKey:@"last_name"]);
//                 NSLog(@"USER Email is :%@",[result valueForKey:@"email"]);
//                 NSLog(@"User fb_Link : %@",[result valueForKey:@"link"]);
//                 NSLog(@"User Birthday : %@",[result valueForKey:@"birthday"]);
//                 NSLog(@"FB Profile Photo Link :%@",[[[result valueForKey:@"picture"]objectForKey:@"data"]objectForKey:@"url"]);
//                 NSLog(@"User total friends : %@",[[[result valueForKey:@"friends"]objectForKey:@"summary"]valueForKey:@"total_count"]);
//                 NSLog(@"User Gender : %@",[result valueForKey:@"gender"]);
//                 NSLog(@"User age_range : %@",[[result valueForKey:@"age_range"]objectForKey:@"min"]);
//                 NSLog(@"User cover Photo Link : %@",[[result valueForKey:@"cover"]objectForKey:@"source"]);
//
//                 //Friend List ID And Name
//                 NSArray * allKeys = [[result valueForKey:@"friends"]objectForKey:@"data"];
//                 NSLog(@"User allKeys : %@",[result valueForKey:@"friends"]);
//
//                 NSMutableArray *
//                 fb_friend_Name = [[NSMutableArray alloc]init];
//                 NSMutableArray *fb_friend_id  =  [[NSMutableArray alloc]init];
//
//                 for (int i=0; i<[allKeys count]; i++)
//                 {
//                     [fb_friend_Name addObject:[[[[result valueForKey:@"friends"]objectForKey:@"data"] objectAtIndex:i] valueForKey:@"name"]];
//
//                     [fb_friend_id addObject:[[[[result valueForKey:@"friends"]objectForKey:@"data"] objectAtIndex:i] valueForKey:@"id"]];
//
//                 }
//                 NSLog(@"Friends ID : %@",fb_friend_id);
//                 NSLog(@"Friends Name : %@",fb_friend_Name);
//             }
//         }];
//
//
 
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me/friends" parameters:@{@"fields":@"id,email,name,picture.width(480).height(480)"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 NSLog(@"result is :%@",result);
                 friendsList = [result valueForKey:@"data"];
                 [self.friendsTblView reloadData];
             }
         }];
    }
    
//    FBSDKGraphRequest(graphPath: "me/friends", parameters: ["fields":"id,email,name,picture.width(480).height(480)"]).startWithCompletionHandler({

}



-(void)GetAllUsers{
    [SVProgressHUD show];
    NSString *apiUrl = [NSString stringWithFormat:@"%@%@",BASE_URL,CREATE_USER];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy.allowInvalidCertificates = NO;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    

    
    [manager POST:apiUrl parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              [SVProgressHUD dismiss];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: response%@", operation.response);
              
              
              [SVProgressHUD dismiss];
          }
     ];
    [manager self];
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int i = 0;
    int index = (int)[self.categoryTab selectedSegmentIndex];
    switch (index) {
        case 0:
            i = (int)friendsList.count;
            break;
        case 1:
            i = (int)localList.count;
            break;
        case 2:
            i = (int)globalList.count;
            break;
        default:
            break;
    }
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = (int)[self.categoryTab selectedSegmentIndex];
    NSDictionary* tempdict;
    switch (index) {
        case 0:
            tempdict = [friendsList objectAtIndex:indexPath.row];
            break;
        case 1:
            tempdict = [localList objectAtIndex:indexPath.row];
            break;
        case 2:
            tempdict = [globalList objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    FriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendscell"];
    NSLog(@"%@", tempdict);
    cell.friendNameLbl.text = [tempdict valueForKey:@"name"];
    NSString* imgUrl = [[[tempdict valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"];
    [cell.friendImg sd_setImageWithURL:[NSURL URLWithString:imgUrl]
                                placeholderImage:[UIImage imageNamed:@"song_placeholder.png"]
                                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {}];
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
