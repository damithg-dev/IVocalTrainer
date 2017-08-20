//
//  FriendListView.m
//  Ivocal-trainer
//
//  Created by Gayanath Damith Amarasinghe on 8/14/17.
//  Copyright © 2017 Gayanath Damith Amarasinghe. All rights reserved.
//

#import "FriendListView.h"

@interface FriendListView ()

@end

@implementation FriendListView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.friendsTblView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int i = 0;
    int index = (int)[self.categoryTab selectedSegmentIndex];
    switch (index) {
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        default:
            break;
    }
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = (int)[self.categoryTab selectedSegmentIndex];
    switch (index) {
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        default:
            break;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendscell"];
    return cell;
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
