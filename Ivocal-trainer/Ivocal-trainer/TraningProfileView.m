//
//  TraningProfileView.m
//  Ivocal-trainer
//
//  Created by Gayanath Damith Amarasinghe on 8/22/17.
//  Copyright © 2017 Gayanath Damith Amarasinghe. All rights reserved.
//

#import "TraningProfileView.h"

@interface TraningProfileView ()

@end

@implementation TraningProfileView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    // Do any additional setup after loading the view.
}

-(void)initNavigationBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FE4E71"]}];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

-(void)showProfileDetails{
    self.title = [self.traningDict valueForKey:@"title"];
    self.imgeVIew = [self.traningDict valueForKey:@"imgp"];
    self.descriptionTxtView.text= [self.traningDict valueForKey:@"description"];
    
}


- (IBAction)backButttonPressed:(id)sender {
        [self.navigationController popViewControllerAnimated:YES];
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
