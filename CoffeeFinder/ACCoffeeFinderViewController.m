//
//  ACCoffeeFinderViewController.m
//  CoffeeFinder
//
//  Created by Alvaro Carrillo on 6/04/2016.
//  Copyright © 2016 Acarrillo Enterprises Pty Ltd. All rights reserved.
//

#import "ACCoffeeFinderViewController.h"
#import "ACFoursquareVenuesService.h"
#import "ACCoffeeFinderTableViewCell.h"
#import "ACFourSquareVenue.h"
#import "ACUtility.h"

@interface ACCoffeeFinderViewController ()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) NSArray *venuesToDisplay;

@end

@implementation ACCoffeeFinderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CoffeeFinder";
    
    // load and register table cell nib file
    UINib *tableCellNib = [UINib nibWithNibName:@"ACCoffeeFinderTableViewCell" bundle:nil];
    
    [self.tableView registerNib:tableCellNib forCellReuseIdentifier:@"VenueCell"];
    
    // set dynamic height for the table cells as the name of the venue
    // and the address may need to wrap to multiple lines
    self.tableView.estimatedRowHeight = 88.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // check permission to use Location services
    // if not allowed display message
    // else start location manager
    CLAuthorizationStatus authorisationStatus = [CLLocationManager authorizationStatus];
    
    if (authorisationStatus == kCLAuthorizationStatusRestricted || authorisationStatus == kCLAuthorizationStatusDenied) {
        NSString *title = @"Location services disabled";
        NSString *message = @"To use CoffeeFinder you must enable Location Services in iOS Settings";
        
        [ACUtility showMessage:message withTitle:title forViewController:self];
        
        return;
        
    } else {
        self.locationManager = [[CLLocationManager alloc] init];
        
        self.locationManager.delegate = self;
        
        if (authorisationStatus == kCLAuthorizationStatusNotDetermined) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        
        if ([CLLocationManager locationServicesEnabled]) {
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters; //default is kCLLocationAccuracyBest
            self.locationManager.distanceFilter = 50;
            [self.locationManager startUpdatingLocation];
        }
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.venuesToDisplay) {
        return 1;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return [self.venuesToDisplay count];
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ACCoffeeFinderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VenueCell" forIndexPath:indexPath];
    
    ACFoursquareVenue *venue = self.venuesToDisplay[indexPath.row];
    
    cell.venueNameLabel.text = venue.name;
    
    if (venue.distanceInMeters) {
        NSMutableString *distanceText = [NSMutableString stringWithString:[venue.distanceInMeters stringValue]];
        
        [distanceText appendString:@"m away"];
        
        cell.venueDistanceLabel.text = distanceText;
    }
    
    if (venue.address) {
        
        NSString *addressText = [venue.address componentsJoinedByString:@"\n"];
        
        cell.venueAddressLabel.text = addressText;
    }
    
    
    //we need to set the code block that will launch maps with the relevant location
    __weak ACFoursquareVenue *weakVenue = venue;
    
    cell.launchInMapsBlock = ^{
        ACFoursquareVenue *strongVenue = weakVenue;
        
        // in order to launch Apple maps we need to construct a URL and launch it
        // you can find info on map links here -> https://developer.apple.com/library/ios/featuredarticles/iPhoneURLScheme_Reference/MapLinks/MapLinks.html
        
        NSMutableString *latituteLongitude = [NSMutableString stringWithString:[strongVenue.latitude stringValue]];
        [latituteLongitude appendString:@","];
        [latituteLongitude appendString:[strongVenue.longitude stringValue]];
        
        NSMutableString *mapsLink = [NSMutableString stringWithString:@"http://maps.apple.com/?ll="];
        [mapsLink appendString:latituteLongitude];
        [mapsLink appendString:@"&q="];
        [mapsLink appendString:[strongVenue.name stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        
        NSURL *mapsUrl = [[NSURL alloc] initWithString:mapsLink];
        [[UIApplication sharedApplication] openURL:mapsUrl];
    };
    
    return cell;
}


#pragma mark - Location manager delegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //TODO: need to handle errors appropriately
    //[ACUtility showError:@"Failed to get your current location" forViewController:self];
    //[ACUtility showError:error.localizedDescription forViewController:self];
    NSLog(@"locationManager:didFailWithError: %@", error.localizedDescription);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *latestLocation = [locations lastObject];
    
    [self findCoffeeShopsFromFoursquareClosestToLocation:latestLocation withinMeters:[NSNumber numberWithInt:500]];
}


#pragma mark - View model

- (void)findCoffeeShopsFromFoursquareClosestToLocation:(CLLocation *)location withinMeters:(NSNumber *)meters
{
    NSNumber *latitude = [NSNumber numberWithDouble:location.coordinate.latitude];
    NSNumber *longitude = [NSNumber numberWithDouble:location.coordinate.longitude];
    
    ACFoursquareVenuesService *service = [[ACFoursquareVenuesService alloc] init];
    
    [service getCoffeeVenuesWithinMeters:meters ofLocationLatitude:latitude longitude:longitude withBlock:^(NSArray *venues, NSArray *errors) {
        
        if (!errors) {
            // sort the venues by distance in ascending order
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distanceInMeters" ascending:YES];
            
            self.venuesToDisplay = [venues sortedArrayUsingDescriptors:@[sortDescriptor]];
            
            [self.tableView reloadData];
            
        } else {
            NSLog(@"Errors: %@", errors);
            
        }
    }];
}

@end
