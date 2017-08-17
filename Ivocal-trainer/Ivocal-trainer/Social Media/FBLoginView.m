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
}

@end

@implementation FBLoginView


- (void)viewDidLoad {
    
    [super viewDidLoad];
    if ([FBSDKAccessToken currentAccessToken] != NULL) {
        [self performSegueWithIdentifier:@"tofrilist" sender:nil];
        NSLog(@"token %@",[FBSDKAccessToken currentAccessToken]);
    }
    
    loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.readPermissions =@[@"public_profile", @"email", @"user_friends",@"user_photos",@"publish_actions"];
    loginButton.hidden = true;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
    if ([FBSDKAccessToken currentAccessToken] != NULL) {
        [self performSegueWithIdentifier:@"tofrilist" sender:nil];
        NSLog(@"token %@",[FBSDKAccessToken currentAccessToken]);
    }
}
- (IBAction)loginButtonPressed:(id)sender {
    [self loginButtonClicked];
//     [loginButton sendActionsForControlEvents: UIControlEventTouchUpInside];
//    
//    if ([FBSDKAccessToken currentAccessToken]) {
//        NSLog(@"token %@",[FBSDKAccessToken currentAccessToken]);
//    }
}

-(void)loginButtonClicked
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             NSLog(@"token %@",[FBSDKAccessToken currentAccessToken]);

         }
     }];
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
