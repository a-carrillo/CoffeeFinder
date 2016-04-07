//
//  ACCoffeeFinderTableViewCell.m
//  CoffeeFinder
//
//  Created by Alvaro Carrillo on 7/04/2016.
//  Copyright © 2016 Acarrillo Enterprises Pty Ltd. All rights reserved.
//

#import "ACCoffeeFinderTableViewCell.h"

@implementation ACCoffeeFinderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Actions

- (IBAction)launchInMaps:(id)sender {
    
    if (self.launchInMapsBlock) {
        self.launchInMapsBlock();
    }
    
}


@end
