//
//  ViewController.m
//  ibeaconDemo
//
//  Created by Tom HU on 14-4-29.
//  Copyright (c) 2014年 Tom Hu. All rights reserved.
//

#import "ViewController.h"

@import CoreLocation;

@interface ViewController ()<CLLocationManagerDelegate>

@property (strong, nonatomic)   CLLocationManager *locationManager;
@property (nonatomic)               CLBeaconRegion      *beaconRegion;
@property (weak, nonatomic)     IBOutlet UILabel      *location;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self startMonitoring];
}

- (void)startMonitoring
{
    //uuid、major、minor跟iBeacon的参数对应。
    _beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"00D4B4DE-159B-704E-E317-1BBE3B7E8927"]
                                                            major:5
                                                            minor:1000
                                                            identifier:@"test"];
    [self.locationManager startMonitoringForRegion:_beaconRegion];
    [self.locationManager startRangingBeaconsInRegion:_beaconRegion];
}

- (NSString *)nameForProximity:(CLProximity)proximity {
    switch (proximity) {
        case CLProximityUnknown:
            return @"Unknown";
            break;
        case CLProximityImmediate:
            return @"Immediate";
            break;
        case CLProximityNear:
            return @"Near";
            break;
        case CLProximityFar:
            return @"Far";
            break;
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    NSLog(@"Failed monitoring region: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Location manager failed: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    for (CLBeacon *beacon in beacons) {
        _location.text = [NSString stringWithFormat:@"%@", [self nameForProximity:beacon.proximity]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
