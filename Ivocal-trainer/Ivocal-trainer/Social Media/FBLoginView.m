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
    
    
    loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.readPermissions =@[@"public_profile", @"email", @"user_friends"];
    loginButton.hidden = true;
}
- (IBAction)loginButtonPressed:(id)sender {
     [loginButton sendActionsForControlEvents: UIControlEventTouchUpInside];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        NSLog(@"token %@",[FBSDKAccessToken currentAccessToken]);
    }
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
