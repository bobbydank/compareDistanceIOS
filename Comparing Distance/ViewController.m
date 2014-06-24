//
//  ViewController.m
//  Comparing Distance
//
//  Created by Robert Danklefsen on 6/19/14.
//  Copyright (c) 2014 Walsh Barnes Interactive. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end
@implementation ViewController
@synthesize answer, zipCode, locationManager;
bool locationCalled = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)viewDidAppear:(BOOL)animated {
    if([CLLocationManager locationServicesEnabled]){
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [locationManager startUpdatingLocation];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    currentLocation = [locations objectAtIndex:0];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
         if (!(error)) {
             //tests current location data
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             
             NSLog(@"\nCurrent Location Detected\n");
             NSLog(@"placemark %@",placemark);
             NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
            
             NSString *Address = [[NSString alloc]initWithString:locatedAt];
             NSString *Zipcode = [[NSString alloc]initWithString:placemark.postalCode];
             NSLog(@"Address: %@",Address);
             NSLog(@"Zip Code: %@",Zipcode);
             
             [locationManager stopUpdatingLocation];
         }
         else {
             NSLog(@"Geocode failed with error %@", error); // Error handling must required
         }
    }];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"This app requires your current location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (IBAction)goButton:(id)sender {
    [zipCode resignFirstResponder];
    NSString *string = [[NSString alloc] initWithString:[zipCode text]];
    
    CLGeocoder *_geocoder = [[CLGeocoder alloc] init];
    [_geocoder geocodeAddressString:string completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks firstObject];
            enteredZip = placemark.location;
            // ... do whaterver you want to do with the location
            
            //NSLog(@"%f",enteredZip.coordinate.latitude);
            //NSLog(@"%f",enteredZip.coordinate.longitude);
            
            float distance = [currentLocation distanceFromLocation:enteredZip] * 0.000621371192;
            answer.text = [NSString stringWithFormat:@"%f",distance];
            //NSLog(@"%@",[NSString stringWithFormat:@"%f",distance]);
        }
    }];
}
- (IBAction)locationButton:(id)sender {
    if([CLLocationManager locationServicesEnabled]){
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [locationManager startUpdatingLocation];
    }
}
@end
