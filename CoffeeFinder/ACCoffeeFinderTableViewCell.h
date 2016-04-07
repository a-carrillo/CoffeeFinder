//
//  ACCoffeeFinderTableViewCell.h
//  CoffeeFinder
//
//  Created by Alvaro Carrillo on 7/04/2016.
//  Copyright © 2016 Acarrillo Enterprises Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACCoffeeFinderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *venueNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *venueDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *venueAddressLabel;
@property (copy, nonatomic) void (^launchInMapsBlock)(void);

@end
