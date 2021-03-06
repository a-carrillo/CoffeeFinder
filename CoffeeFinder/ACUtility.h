//
//  ACUtility.h
//  CoffeeFinder
//
//  Created by Alvaro Carrillo on 6/04/2016.
//  Copyright © 2016 Acarrillo Enterprises Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACUtility : NSObject

+ (void)showMessage:(NSString *)message withTitle:(NSString *)title forViewController:(UIViewController *)viewController;
+ (void)showError:(NSString *)errorMessage forViewController:(UIViewController *)viewController;

@end
