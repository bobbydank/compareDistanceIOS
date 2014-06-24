//
//  ViewController.h
//  Comparing Distance
//
//  Created by Robert Danklefsen on 6/19/14.
//  Copyright (c) 2014 Walsh Barnes Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate> {
    CLLocation *currentLocation;
    CLLocation *enteredZip;
}

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UITextField *zipCode;
@property (weak, nonatomic) IBOutlet UILabel *answer;

- (IBAction)goButton:(id)sender;
- (IBAction)locationButton:(id)sender;
@end
