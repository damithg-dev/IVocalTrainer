//
//  ProfileView.m
//  Ivocal-trainer
//
//  Created by Gayanath Damith Amarasinghe on 7/13/17.
//  Copyright © 2017 Gayanath Damith Amarasinghe. All rights reserved.
//

#import "ProfileView.h"

@interface ProfileView ()

@end

@implementation ProfileView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    [self getFacebookProfileDetails];
}


-(void)getFacebookProfileDetails{
    
    if ([FBSDKAccessToken currentAccessToken] != NULL) {
        self.view.alpha = 0;
        [SVProgressHUD show];
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"email,name,first_name,cover,picture.type(large)"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 //             NSLog(@"fetched user:%@", result);
                 [self.navigationItem setTitle:result[@"name"]];
                 [self.navigationItem.rightBarButtonItem setEnabled:YES];
                 [self.backImgeView sd_setImageWithURL:[NSURL URLWithString:[[result valueForKey:@"cover"] valueForKey:@"source"]]
                                      placeholderImage:[UIImage imageNamed:@"user_cover"]
                                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {}];
                 [self.prfImgeView sd_setImageWithURL:[NSURL URLWithString:[[[result valueForKey:@"picture"] valueForKey:@"data"]valueForKey:@"url" ]]
                                     placeholderImage:[UIImage imageNamed:@"user_pic"]
                                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {}];
                 [SVProgressHUD dismiss];
                 self.view.alpha = 1;

             }
         }];
        
    }else{
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
        [self.navigationItem setTitle:@"User"];
        [self.backImgeView setImage:[UIImage imageNamed:@"user_cover"]];
        [self.prfImgeView setImage:[UIImage imageNamed:@"user_pic"]];
    }
}


-(void)initNavigationBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FE4E71"]}];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}


- (IBAction)actionButtonClicked:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Action" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [self dismissViewControllerAnimated:YES completion:^{}];
    }]];
    if ([FBSDKAccessToken currentAccessToken] != NULL) {
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Log out" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
            [loginManager logOut];
            [FBSDKAccessToken setCurrentAccessToken:nil];
            [self getFacebookProfileDetails];
            [self dismissViewControllerAnimated:YES completion:^{}];
        }]];
    }
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
    
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
