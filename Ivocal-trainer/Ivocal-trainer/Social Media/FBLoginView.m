//
//  FBLoginView.m
//  Ivocal-trainer
//
//  Created by Gayanath Damith Amarasinghe on 7/13/17.
//  Copyright © 2017 Gayanath Damith Amarasinghe. All rights reserved.
//

#import "FBLoginView.h"

@interface FBLoginView (){

    FBSDKLoginButton *loginButton;
    NSString *uname,*fbuid,*frequncy;
 
}

@end

@implementation FBLoginView


- (void)viewDidLoad {
    self.view.alpha = 0;
    
    [super viewDidLoad];
    if ([FBSDKAccessToken currentAccessToken] != NULL) {
        [self performSegueWithIdentifier:@"tofrilist" sender:nil];
    }else{
        self.view.alpha = 1;
    }
    
    loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.readPermissions =@[@"public_profile", @"email", @"user_friends"];
    loginButton.hidden = true;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
    if ([FBSDKAccessToken currentAccessToken] != NULL) {
        [self performSegueWithIdentifier:@"tofrilist" sender:nil];
    }else{
        self.view.alpha = 1;
    }
}
- (IBAction)loginButtonPressed:(id)sender {
    [self loginButtonClicked];
}



-(void)loginButtonClicked
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             if ([result.grantedPermissions containsObject:@"email"])
             {
             [self fetchUserInfo];
             [SVProgressHUD show];
             NSLog(@"token %@",[FBSDKAccessToken currentAccessToken]);
             ProfileView *vc = [[ProfileView alloc]init];
             [vc getFacebookProfileDetails];
             
             }
         }
     }];
}


-(void)fetchUserInfo
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id,name,link,first_name, last_name, picture.type(large), email, birthday,friends,gender,age_range,cover,location"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 //NSLog(@"result is :%@",result);
                 NSLog(@"User ID : %@",[result valueForKey:@"id"]);
                 fbuid =[result valueForKey:@"id"];
                 NSLog(@"User Name : %@",[result valueForKey:@"name"]);
                 uname =[result valueForKey:@"name"];
                 NSLog(@"User First Name :%@",[result valueForKey:@"first_name"]);
                 NSLog(@"User Last Name :%@",[result valueForKey:@"last_name"]);
                 NSLog(@"USER Email is :%@",[result valueForKey:@"email"]);
                 NSLog(@"User fb_Link : %@",[result valueForKey:@"link"]);
                 NSLog(@"User Birthday : %@",[result valueForKey:@"birthday"]);
                 NSLog(@"FB Profile Photo Link :%@",[[[result valueForKey:@"picture"]objectForKey:@"data"]objectForKey:@"url"]);
                 NSLog(@"User total friends : %@",[[[result valueForKey:@"friends"]objectForKey:@"summary"]valueForKey:@"total_count"]);
                 NSLog(@"User Gender : %@",[result valueForKey:@"gender"]);
                 NSLog(@"User age_range : %@",[[result valueForKey:@"age_range"]objectForKey:@"min"]);
                 NSLog(@"User cover Photo Link : %@",[[result valueForKey:@"cover"]objectForKey:@"source"]);
                 
                 NSLog(@"User location : %@",[[result valueForKey:@"location"]objectForKey:@"country"]);
                 
                 //Friend List ID And Name
                 //NSArray * allKeys = [[result valueForKey:@"friends"]objectForKey:@"data"];
                 
                 [[NSUserDefaults standardUserDefaults] setValue:[result valueForKey:@"gender"] forKey:@"Gender"];
                 [[NSUserDefaults standardUserDefaults] setValue:[[result valueForKey:@"age_range"]objectForKey:@"min"] forKey:@"age"];
                 [[NSUserDefaults standardUserDefaults] setValue:[[result valueForKey:@"location"]objectForKey:@"country"] forKey:@"country"];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 
                 [self CreateUserTofb];
                 
//                 NSMutableArray *fb_friend_Name = [[NSMutableArray alloc]init];
//                 NSMutableArray *fb_friend_id  =  [[NSMutableArray alloc]init];
                 
//                 for (int i=0; i<[allKeys count]; i++)
//                 {
//                     [fb_friend_Name addObject:[[[[result valueForKey:@"friends"]objectForKey:@"data"] objectAtIndex:i] valueForKey:@"name"]];
//
//                     [fb_friend_id addObject:[[[[result valueForKey:@"friends"]objectForKey:@"data"] objectAtIndex:i] valueForKey:@"id"]];
//
//                 }
//                 NSLog(@"Friends ID : %@",fb_friend_id);
//                 NSLog(@"Friends Name : %@",fb_friend_Name);
             }
         }];
    }
}





-(void)CreateUserTofb{

    NSString *apiUrl = [NSString stringWithFormat:@"%@%@",BASE_URL,CREATE_USER];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy.allowInvalidCertificates = NO;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:uname forKey:@"uname"];
    [param setValue:fbuid forKey:@"fbuid"];
    
    
    [manager POST:apiUrl parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              [self performSegueWithIdentifier:@"tofrilist" sender:nil];
              [SVProgressHUD dismiss];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: response%@", operation.response);

              
              [SVProgressHUD dismiss];
          }
     ];
    [manager self];
    
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
