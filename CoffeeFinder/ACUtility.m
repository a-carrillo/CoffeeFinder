//
//  ACUtility.m
//  CoffeeFinder
//
//  Created by Alvaro Carrillo on 6/04/2016.
//  Copyright © 2016 Acarrillo Enterprises Pty Ltd. All rights reserved.
//

#import "ACUtility.h"

@implementation ACUtility

/**
 *  Displays an alert with the specified message and title
 *
 *  @param message        The message of the alert to be displayed
 *  @param title          The title of the alert to be displayed
 *  @param viewController The view controller from which the alert will be presented
 */
+ (void)showMessage:(NSString *)message withTitle:(NSString *)title forViewController:(UIViewController *)viewController
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [viewController presentViewController:alert animated:YES completion:nil];
}

/**
 *  Displays an alert with the specified error message
 *
 *  @param errorMessage   The error message of the alert to be displayed
 *  @param viewController The view controller from which the alert will be presented
 */
+ (void)showError:(NSString *)errorMessage forViewController:(UIViewController *)viewController
{
    [self showMessage:errorMessage withTitle:@"Error" forViewController:viewController];
}

@end
