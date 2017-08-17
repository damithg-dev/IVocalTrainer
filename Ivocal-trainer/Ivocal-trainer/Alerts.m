//
//  Alerts.m
//  Ivocal-trainer
//
//  Created by Gayanath Damith Amarasinghe on 8/7/17.
//  Copyright © 2017 Gayanath Damith Amarasinghe. All rights reserved.
//

#import "Alerts.h"

@implementation Alerts


+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)msg controller:(id)controller {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:okAction];
    
    [controller presentViewController:alertController animated:YES completion:nil];
}


@end
