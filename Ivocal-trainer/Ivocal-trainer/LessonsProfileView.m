//
//  LessonsProfileView.m
//  Ivocal-trainer
//
//  Created by Gayanath Damith Amarasinghe on 8/22/17.
//  Copyright © 2017 Gayanath Damith Amarasinghe. All rights reserved.
//

#import "LessonsProfileView.h"

@interface LessonsProfileView ()

@end

@implementation LessonsProfileView

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
    self.title = [self.lessonDict valueForKey:@"title"];
    self.imgView = [self.lessonDict valueForKey:@"imgp"];
    self.decriptionTxtView.text= [self.lessonDict valueForKey:@"description"];
    
}


- (IBAction)backButtonPressed:(id)sender {
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
